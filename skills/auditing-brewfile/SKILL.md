---
name: auditing-brewfile
description: Audit installed Homebrew packages against this chezmoi repo's dot_Brewfile.tmpl and promote hand-installed keepers into it. Use when the user asks to audit, reconcile, or clean up the Brewfile, asks which packages are installed but not codified, wonders why a new machine is missing a tool, or runs brew-audit. Also use after installing something by hand that should survive a rebuild.
---

# Auditing the Brewfile

`brew bundle` is install-only, so anything installed by hand stays installed and
invisible: it works on this machine and is silently absent from the next one.
`dot_Brewfile.tmpl` records what is *guaranteed*, never what is present. This
skill closes the gap.

## Run the audit

```bash
scripts/brew-audit
```

Works from any directory and through the `~/.agents/skills` symlink — it locates
the repo from its own path. Exits non-zero when anything needs a decision.

| Section | Meaning | Action |
| --- | --- | --- |
| `PROMOTE?` | installed on purpose, declared nowhere in the template | promote, or uninstall |
| `OFF-BRANCH` | declared only under a profile branch this machine does not render | usually a wrong branch condition, or installed by hand on the wrong profile |
| `DECLARED, ABSENT` | in this machine's Brewfile but not installed | run `chezmoi apply`; if it persists, the formula or cask was renamed upstream |

Only intentional installs are considered — the audit reads
`brew leaves --installed-on-request`, so dependencies pulled in by something
else never appear as candidates.

## Triage each candidate

Work through them one at a time and ask the user when the call is theirs. There
is no ignore list: a candidate left alone is reported again on every run, so say
so rather than letting the user assume it was recorded somewhere.

Questions that decide it:

- Would a fresh machine be broken or annoying without it? → promote.
- Does it duplicate something already codified? Flag the conflict instead of
  promoting a second tool for the same job — this repo already carries `fnm` and
  `mise`, so `nvm` is a live example.
- Is it work-specific, personal-only, or GUI-only? That picks the profile
  branch, not whether to promote.
- Genuinely unwanted? Propose uninstalling it, and never run that unprompted.

## Promoting: where the line goes

`dot_Brewfile.tmpl` is grouped by purpose (`# Dev tools`, `# Productivity
Tools`, `# CLI Tools`, `# Fonts`) and then split by profile. Use the matching
group, and the profile conditional only when the package is genuinely
profile-specific — unconditional is the default.

- `brew "x"` for formulae, `cask "x"` for GUI apps and fonts.
- A formula from a non-core tap needs its `tap "owner/repo"` line too, as
  `datadog-labs/pack` does.
- Casks from a tap keep the full token (`nikitabobko/tap/aerospace`).

A promoted tool is rarely just a Brewfile line. Finish the job:

- **Shell setup** goes in its own self-guarding `dot_zsh/<tool>.zsh` module,
  never appended to `dot_zshrc.tmpl`. See `AGENTS.md`.
- **Config files** belong in this repo under `dot_config/<tool>/`.
- **Docs row**: add the tool to the docs table in `AGENTS.md`, so future config
  work starts from its official docs.

## Verify

```bash
chezmoi apply && scripts/brew-audit
```

The promoted entry should be gone from `PROMOTE?`. A clean tree prints one line
and exits 0.

## Never

- **Never run `brew bundle cleanup --force`.** It uninstalls everything absent
  from the Brewfile — the whole audit list — which is the opposite of promoting.
  It is also a bad read of the same question: it skips casks whose upstream token
  was renamed, and pads its list with autoremovable dependencies that were never
  intentional installs.
- **Never edit `~/.Brewfile`** — it is rendered from `dot_Brewfile.tmpl`.
- **Never promote silently.** Adding a package to every future machine is the
  user's call.
