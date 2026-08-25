# `npx skills add` writes real skill dirs into ~/.claude/skills, where they shadow the
# fan-out symlinks and are lost on the next rebuild; reroute a pasted invocation into the
# chezmoi source copy of dot_apm/apm.yml, the only declaration `chezmoi apply` honors.
if command -v apm &>/dev/null && command -v chezmoi &>/dev/null; then

  _skills_apm_manifest() {
    local src
    src=$(chezmoi source-path 2>/dev/null) || return 1
    [[ -f $src/dot_apm/apm.yml ]] || return 1
    print -r -- "$src/dot_apm/apm.yml"
  }

  _skills_apm_skill_path() {
    local repo=$1 ref=${2:-HEAD} name=$3 tree hit
    # gh prints the API error body on stdout, so a 404 ref still yields output.
    tree=$(gh api "repos/$repo/git/trees/$ref?recursive=1" --jq '.tree[].path' 2>/dev/null)
    if (( $? )) || [[ -z $tree ]]; then
      print -u2 "skills: cannot read $repo at $ref — check the ref, and that gh is installed and authenticated"
      return 1
    fi
    hit=$(print -r -- "$tree" | grep -E "(^|/)${name}/SKILL\.md\$" |
      awk '{ print length, $0 }' | sort -n | head -1 | cut -d' ' -f2-)
    if [[ -z $hit ]]; then
      print -u2 "skills: $repo has no skill named '$name'. It offers:"
      print -r -- "$tree" | grep -E '(^|/)SKILL\.md$' |
        sed -E 's:/SKILL\.md$::; s:.*/::' | sort -u | sed 's/^/  /' >&2
      return 1
    fi
    print -r -- "${hit%/SKILL.md}"
  }

  _skills_apm_declared() {
    awk -v dep="${2%%\#*}" '
      { entry = $0
        sub(/^[[:space:]]*-[[:space:]]*/, "", entry)
        sub(/#.*$/, "", entry)
        if (entry == dep) hit = 1 }
      END { exit !hit }
    ' "$1"
  }

  _skills_apm_add() {
    local arg source= ref= subpath= repo= host= remote= base d
    local -i yes=0 all=0
    local -a wanted deps fresh

    for arg in "$@"; do
      [[ $arg == (-l|--list) ]] && { command npx skills add "$@"; return }
    done

    while (( $# )); do
      case $1 in
        -s|--skill)
          shift
          while (( $# )) && [[ $1 != -* ]]; do wanted+=$1; shift; done ;;
        --skill=*) wanted+=${1#*=}; shift ;;
        -a|--agent)
          shift
          while (( $# )) && [[ $1 != -* ]]; do shift; done ;;
        --agent=*|-g|--global|--copy) shift ;;
        -y|--yes) yes=1; shift ;;
        --all) all=1; yes=1; shift ;;
        -*) print -u2 "skills: ignoring $1"; shift ;;
        *)
          [[ -n $source ]] && print -u2 "skills: ignoring extra source $1" || source=$1
          shift ;;
      esac
    done

    if [[ -z $source ]]; then
      print -u2 "usage: skills add <owner/repo|url|path> [--skill <name> ...] [--all]"
      return 2
    fi

    [[ $source == *\#* ]] && { ref=${source##*\#}; source=${source%%\#*} }

    case $source in
      ./*|../*|/*) ;;
      git@*:*) host=${${source#git@}%%:*}; remote=${${source#*:}%.git} ;;
      *://*)   host=${${source#*://}%%/*}; remote=${${source#*://*/}%.git} ;;
      *)
        if [[ ${source%%/*} == *.* ]]; then
          host=${source%%/*}; remote=${source#*/}
        else
          host=github.com; remote=$source
        fi ;;
    esac

    if [[ $host == github.com ]]; then
      local -a p=(${(s:/:)remote})
      repo="${p[1]}/${p[2]}"
      if [[ ${p[3]} == (tree|blob) ]]; then
        ref=${ref:-${p[4]}}
        subpath=${(j:/:)p[5,-1]}
      else
        subpath=${(j:/:)p[3,-1]}
      fi
      base=$repo${subpath:+/$subpath}
    elif [[ -n $host ]]; then
      base=$host/$remote
    else
      base=$source
    fi

    if (( all )) || (( ! $#wanted )) || (( ${wanted[(Ie)*]} )); then
      deps=($base)
    elif [[ -z $repo ]]; then
      print -u2 "skills: --skill resolves names on GitHub only; give apm the skill's subpath"
      return 2
    else
      for arg in $wanted; do
        d=$(_skills_apm_skill_path "$repo" "$ref" "$arg") || return 1
        deps+="$repo/$d"
      done
    fi
    [[ -n $ref ]] && deps=("${(@)deps/%/#$ref}")

    local manifest
    manifest=$(_skills_apm_manifest) || {
      print -u2 "skills: no dot_apm/apm.yml under the chezmoi source dir"
      return 1
    }

    for d in $deps; do
      if _skills_apm_declared "$manifest" "$d"; then
        print "skills: already declared — $d"
      else
        fresh+=$d
      fi
    done
    (( $#fresh )) || return 0

    print "skills → apm  ($manifest)"
    for d in $fresh; do print "  + $d"; done
    if (( ! yes )); then
      read -q "?Add these and run chezmoi apply? [y/N] " || { print; return 1 }
      print
    fi

    local tmp=${TMPDIR:-/tmp}/skills-apm.$$.yml
    awk -v adds="${(j:,:)fresh}" '
      BEGIN { n = split(adds, add, ",") }
      /^  apm:/ { pending = 1; print; next }
      pending && !/^    - / { for (i = 1; i <= n; i++) print "    - " add[i]; pending = 0 }
      { print }
      END { if (pending) for (i = 1; i <= n; i++) print "    - " add[i] }
    ' "$manifest" > "$tmp" && mv "$tmp" "$manifest" || {
      print -u2 "skills: could not write $manifest"
      return 1
    }

    chezmoi apply && print "skills: declared and applied — commit dot_apm/apm.yml"
  }

  npx() {
    local -i i=1
    while (( i <= $# )); do
      case ${@[i]} in
        -y|--yes|-q|--quiet|--silent|--no-install) (( i++ )) ;;
        -*) command npx "$@"; return ;;
        *) break ;;
      esac
    done
    if [[ ${${@[i]}%%@*} == skills && ${@[i+1]} == add ]]; then
      local -a rest=("${@[i+2,-1]}")
      _skills_apm_add "${rest[@]}"
      return
    fi
    command npx "$@"
  }

  skills() {
    if [[ $1 == add ]]; then
      shift
      _skills_apm_add "$@"
    elif whence -p skills &>/dev/null; then
      command skills "$@"
    else
      command npx skills "$@"
    fi
  }

fi
