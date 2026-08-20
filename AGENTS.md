# Agent context

This is a **chezmoi source directory** (public repo). Files here render/deploy to `$HOME` on `chezmoi apply`.

- Always edit here, never the deployed copies in `$HOME`; run `chezmoi apply` after.
- Root files without `dot_` prefix deploy to `$HOME` too — repo-only files must be listed in `.chezmoiignore`.
- Every `*.tmpl` must render for both `darwin/arm64` and `linux/amd64` (pre-push hook enforces this).
- Per-tool shell config is its own self-guarding module in `dot_zsh/` (see `pyenv.zsh`, `mise.zsh`), auto-sourced by `.zshrc`. Guard on the tool's presence (`command -v` or `[[ -d ... ]]`) so it no-ops where absent — don't append tool setup to `dot_zshrc.tmpl`/`dot_zshrc.mac.tmpl`.

## Check the tool's official docs first

This repo configures fast-evolving tools whose flags, schemas, and capabilities change faster than any model's training data. **Before writing config for a tool, read its current official docs.** Don't infer capabilities from `--help`, a JSON schema, strings in the binary, or general knowledge — a capability you assumed missing is the usual cause of a contorted workaround. If the docs don't cover it, say so rather than quietly falling back to inference.

| Tool | Docs |
| --- | --- |
| chezmoi | https://www.chezmoi.io/ — [concepts](https://www.chezmoi.io/reference/concepts/), [source state attributes](https://www.chezmoi.io/reference/source-state-attributes/), [templates](https://www.chezmoi.io/reference/templates/), [special files](https://www.chezmoi.io/reference/special-files-and-directories/), [commands](https://www.chezmoi.io/reference/commands/) |
| Homebrew | https://docs.brew.sh/ — [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile), [manpage](https://docs.brew.sh/Manpage) |
| cmux | https://cmux.com/docs — also offline via `cmux docs [settings\|shortcuts\|api\|dock\|agents\|sidebars]` |
| Ghostty | https://ghostty.org/docs |
| AeroSpace | https://nikitabobko.github.io/AeroSpace/guide |
| mise | https://mise.jdx.dev/ |
| antidote | https://getantidote.github.io/ |
| fnm | https://github.com/Schniz/fnm |

Any tool not listed: find its official docs and add a row here.

## The Brewfile is install-only: audit before trusting it

`brew bundle` never uninstalls, so a package installed by hand keeps working here and is silently missing from the next machine. `dot_Brewfile.tmpl` is therefore not a record of what is installed — only of what is guaranteed.

- The `auditing-brewfile` skill carries the audit and the triage procedure; its `scripts/brew-audit` lists packages installed on purpose but declared nowhere, plus the reverse drift, and exits non-zero when anything needs a decision.
- There is no ignore list, so a candidate you decline is reported again next run.
- **Never run `brew bundle cleanup --force`** to resolve the audit — it uninstalls the entire list rather than codifying it.

Detailed agent docs live in `agents/`:

- **Before creating, moving, or removing any skill (`SKILL.md`), read [`agents/skill-routing.md`](agents/skill-routing.md)** — it defines the layered routing system (repo-local / public / private / team / trial) and where a new skill must live based on its subject and audience. Skills about *this repo's* mechanics live in `skills/` here; everything else lives in a source repo. Never drop skills directly into `~/.claude/skills/`.

`CLAUDE.md` is a symlink to this file — edit here only.
