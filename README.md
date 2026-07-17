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
| `.chezmoiexternal.toml.tmpl` | Skill-source repos ([public](https://github.com/ryjo1026/skills), private, team), cloned per machine profile |
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
- **`run_onchange_after_agent-skills.sh`** — merges skill sources into `~/.agents/skills` and fans out to non-native agents (see below).

## Agent skills

Skills route through `~/.agents/skills/` — the cross-agent dir most agents (Codex, Cursor, Gemini CLI, OpenCode, Amp) read natively. This repo carries **no skill content, only the routing**: `.chezmoiexternal.toml.tmpl` clones each source repo into `~/.agents/sources/<name>`, and `run_onchange_after_agent-skills.sh` merges them into `~/.agents/skills`, then fans the result into agents that don't read it natively (currently Claude Code).

| Layer | Source | Machines |
| --- | --- | --- |
| Public (world-shareable) | [ryjo1026/skills](https://github.com/ryjo1026/skills) | all |
| Private / team | work-hosted repos | work profile only |
| Trial / one-off | unmanaged real dirs in `~/.agents/skills/`, by hand or [`npx skills add`](https://github.com/vercel-labs/skills) | wherever you put them — chezmoi and the script never touch them |

**Precedence** on name collisions: real dirs (trials) beat source symlinks; among sources, the `SOURCES` array order in the script (private > team > public). Shadowed skills are skipped with a warning.

**Add a skill:** commit `<name>/SKILL.md` to the source repo matching its audience, then `chezmoi apply` (or wait out `refreshPeriod`). Remove it from the source repo and the next apply prunes its links.

**Add a source:** add its stanza to `.chezmoiexternal.toml.tmpl`, add its name to `SOURCES` in the script, `chezmoi apply`. Removing a source from both + deleting `~/.agents/sources/<name>` cleanly unlinks everything it provided.

**Gating:** per-profile gating is the externals template's conditionals; per-OS gating is `.chezmoiignore` — sources pull on Macs by default, and the Linux block ignores them on the server (opt one in with `!.agents/sources/<name>` + `!.agents/sources/<name>/**`).

**Caveats:**

- Write access to a subscribed source repo is code-execution for your agents — branch-protect team sources; treat third-party sources like dependencies.
- Never hand-edit `~/.agents/.skill-lock.json` — it belongs to the `npx skills` CLI, which wipes formats it doesn't recognize.
- The symlinks are script-managed, not chezmoi state — `chezmoi managed` won't list them; the script prunes dangling ones.
- Newly gating a source off a machine doesn't delete already-cloned files (standard chezmoi ignore semantics) — remove them manually.
- This repo is public: skill content lives in the source repos, never here.

## Pre-push hook

`.githooks/pre-push` renders every `*.tmpl` against each target combo (`darwin/arm64`, `linux/amd64`) and aborts the push if any fails. Enable for this repo:

```sh
git config core.hooksPath .githooks
```

This is wired up automatically via the `includeIf` block in `dot_gitconfig.tmpl` for clones at `~/.local/share/chezmoi/`.

## Local overrides

Drop machine-specific shell tweaks in `~/.zshrc.local` — sourced last by `.zshrc`, never tracked.
