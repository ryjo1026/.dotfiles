# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). Targets macOS (Apple Silicon) and Linux.

## What's in here

| Path | Purpose |
| --- | --- |
| `dot_zsh/`, `dot_zshenv` | Zsh config, [antidote](https://github.com/mattmc3/antidote) plugins, Powerlevel10k prompt |
| `dot_Brewfile.tmpl` | Homebrew bundle (profile-aware: `personal` vs `work`) |
| `dot_gitconfig.tmpl`, `dot_gitmessage` | Git config with SSH-signed commits |
| `dot_aerospace.toml` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling WM config (opt-in) |
| `dot_vimrc`, `dot_vim/` | Vim config |
| `dot_tmux.conf` | tmux config |
| `dot_config/ghostty/`, `dot_config/cmux/` | Ghostty terminal & cmux configs |
| `dot_agents/skills/` | Agent-agnostic AI skills, symlinked into each agent's skills dir |
| `.chezmoiscripts/` | Bootstrap scripts: SSH key, macOS defaults, `brew bundle` |
| `.chezmoidata/defaults.toml` | Default values for template variables |
| `.githooks/pre-push` | Renders all templates against each target OS/arch before push |

## Install

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ryjo1026
```

This will clone the repo, prompt for the values below on first run, and apply.

## Configuration

Configure per-machine values in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
profile          = "work"           # "work" | "personal" — gates Brewfile entries
email            = "you@example.com"
sshKeyTitle      = "work-laptop"    # comment baked into the generated SSH key
aerospaceEnabled = true             # install AeroSpace + apply WM-friendly macOS defaults
gitSigningKey    = "~/.ssh/id_ed25519.pub"
```

Defaults live in `.chezmoidata/defaults.toml`.

## Bootstrap scripts

Run automatically by `chezmoi apply`:

- **`run_once_10-ssh-key.sh`** — generates `~/.ssh/id_ed25519` if missing and prints the public key.
- **`run_onchange_10-macos-defaults.sh`** — sets key repeat rate, screen saver, hot corners, and (if `aerospaceEnabled`) WM-friendly Dock/Spaces tweaks. macOS only.
- **`run_onchange_brew-bundle.sh`** — runs `brew bundle` against the rendered Brewfile when it changes. macOS only.
- **`run_onchange_after_agent-skills.sh`** — symlinks managed skills into each agent's skills dir (see below).

## Agent skills

Public, agent-agnostic AI skills live in `dot_agents/skills/<name>/` and deploy to `~/.agents/skills/`. A `run_onchange_after` script then symlinks each deployed skill into every agent's native skills dir (currently `~/.claude/skills/`), alongside unmanaged local skills — chezmoi never touches those, so private/work skills coexist freely.

**Add a skill:**

1. Create `dot_agents/skills/exact_<name>/SKILL.md` (plus any support files; `executable_` prefix for scripts). `exact_` keeps the deployed skill in lockstep with the repo.
2. Gate it in `.chezmoiignore` if it isn't for every machine (see below).
3. `chezmoi apply`.

**Remove a skill:** `chezmoi destroy ~/.agents/skills/<name>` (deletes target and source), then `chezmoi apply` to prune its symlinks.

**Gating** (`.chezmoiignore` is a template):

- Skills deploy to Macs by default; the whole tree is ignored on Linux. Opt a skill into the server with `!.agents/skills/<name>` + `!.agents/skills/<name>/**` inside the Linux block.
- Gate by machine profile, e.g. a work-only skill:

  ```
  {{ if ne .profile "work" }}
  .agents/skills/<name>
  .agents/skills/<name>/**
  {{ end }}
  ```

**Caveats:**

- The per-agent symlinks are script-managed, not chezmoi state — `chezmoi managed` won't list them; the script prunes dangling ones.
- Newly gating a skill off a machine doesn't delete already-deployed files (standard chezmoi ignore semantics) — remove them manually.
- This repo is public: only generic, shareable skills belong here. Work/private skills stay as unmanaged real dirs inside the agent dirs.

## Pre-push hook

`.githooks/pre-push` renders every `*.tmpl` against each target combo (`darwin/arm64`, `linux/amd64`) and aborts the push if any fails. Enable for this repo:

```sh
git config core.hooksPath .githooks
```

This is wired up automatically via the `includeIf` block in `dot_gitconfig.tmpl` for clones at `~/.local/share/chezmoi/`.

## Local overrides

Drop machine-specific shell tweaks in `~/.zshrc.local` — sourced last by `.zshrc`, never tracked.
