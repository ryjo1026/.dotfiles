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

## Pre-push hook

`.githooks/pre-push` renders every `*.tmpl` against each target combo (`darwin/arm64`, `linux/amd64`) and aborts the push if any fails. Enable for this repo:

```sh
git config core.hooksPath .githooks
```

This is wired up automatically via the `includeIf` block in `dot_gitconfig.tmpl` for clones at `~/.local/share/chezmoi/`.

## Local overrides

Drop machine-specific shell tweaks in `~/.zshrc.local` — sourced last by `.zshrc`, never tracked.
