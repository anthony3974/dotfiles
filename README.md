# Dotfiles

Personal config for Arch Linux + i3. This is a normal git repo at `~/dotfiles`; the
places each program expects its config are **symlinks into this repo**, so editing
either path edits the tracked file.

## Layout

| Repo path | Linked from | Purpose |
|---|---|---|
| `bash/bashrc` | `~/.bashrc` | shared shell config, aliases, prompt |
| `i3/config` | `~/.config/i3/config` | shared i3 config |
| `i3/conf.d/` | `~/.config/i3/conf.d` | extra i3 includes (e.g. `i3bar.conf`) |
| `i3/hosts/desktop.conf`, `laptop.conf` | `~/.config/i3/local.conf` | per-machine i3 override (pick one) |
| `i3blocks/` | `~/.config/i3blocks` | status bar config + `mediaplayer`, `volume` scripts |
| `bin/` | `~/.local/bin` | personal scripts, on `PATH` |

`i3/config` ends with `include` lines for `conf.d/i3bar.conf` and `local.conf`.
`~/.bash_profile` (not tracked) puts `~/.local/bin` on `PATH`, so everything in
`bin/` runs as a command (`res-4k-165`, `toggle-display`, `nightlight`, `volume_osd`,
`ytm`, `tray`, `ai`, ...).

### Not tracked (see `.gitignore`)

- Secrets/tokens/keys, `*.bak`, `*.old`, `*.swp`, etc.
- `i3/hosts`-style `local.conf` (it is just a symlink to a host file)
- Large binaries: `bin/agy`, `bin/llm`
- Machine-specific symlinks in `bin/` such as `claude` (points at a versioned
  install under `~/.local/share/claude`) and `display` (points at a `res-*` script)

---

## Setup & Installation (Fresh Machine)

### 1. Clone the repository

```bash
git clone git@github.com:anthony3974/dotfiles.git ~/dotfiles
```

### 2. Configure Bash

```bash
# Back up existing config
mv ~/.bashrc ~/.bashrc.bak 2>/dev/null || true

# Symlink shared bashrc
ln -sf ~/dotfiles/bash/bashrc ~/.bashrc

# Optional local overrides file
touch ~/.bashrc.local
```

Make sure `~/.bash_profile` contains:

```bash
export PATH="$HOME/.local/bin:$PATH"
[[ -f ~/.bashrc ]] && . ~/.bashrc
```

### 3. Link scripts

```bash
# If ~/.local/bin already exists, move its contents into ~/dotfiles/bin first
mkdir -p ~/.local
ln -sfn ~/dotfiles/bin ~/.local/bin
```

### 4. Add workflow aliases to Bash

Run once to append `dotpush` and `dotpull` to the shared Bash config
(skip if `grep dotpush ~/dotfiles/bash/bashrc` already finds them):

```bash
cat << 'EOF' >> ~/dotfiles/bash/bashrc

# Dotfiles synchronization aliases
alias dotpush='cd ~/dotfiles && git add -u && git commit -m "Update dotfiles" && git push && cd -'
alias dotpull='cd ~/dotfiles && git pull && i3-msg restart && cd -'
EOF
```

### 5. Configure i3

```bash
# Prepare directories & backup
mkdir -p ~/.config/i3
mv ~/.config/i3/config ~/.config/i3/config.bak 2>/dev/null || true

# Symlink shared configs
ln -sf ~/dotfiles/i3/config ~/.config/i3/config
ln -sfn ~/dotfiles/i3/conf.d ~/.config/i3/conf.d

# Symlink host-specific override (run ONE depending on the machine):
# Desktop:
ln -sf ~/dotfiles/i3/hosts/desktop.conf ~/.config/i3/local.conf

# Laptop:
# ln -sf ~/dotfiles/i3/hosts/laptop.conf ~/.config/i3/local.conf
```

### 6. Configure i3blocks

```bash
# Back up existing i3blocks directory
mv ~/.config/i3blocks ~/.config/i3blocks.bak 2>/dev/null || true

# Symlink full directory
ln -sfn ~/dotfiles/i3blocks ~/.config/i3blocks
```

### 7. Apply Changes

```bash
i3-msg restart
source ~/.bashrc
```

---

## Daily Workflow

### Push changes (from the active machine)

```bash
dotpush
# Or manually:
# cd ~/dotfiles && git add -u && git commit -m "Update dotfiles" && git push
```

`git add -u` only stages files git already tracks. For a **new** script or config,
`git add` it first.

### Pull changes (on the other machine)

```bash
dotpull
# Or manually:
# cd ~/dotfiles && git pull && i3-msg restart
```
