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

### 3. Add Workflow Aliases to Bash

Run this once to append `dotpush` and `dotpull` to your shared Bash config:

```bash
cat << 'EOF' >> ~/dotfiles/bash/bashrc

# Dotfiles synchronization aliases
alias dotpush='cd ~/dotfiles && git add -u && git commit -m "Update dotfiles" && git push && cd -'
alias dotpull='cd ~/dotfiles && git pull && i3-msg restart && cd -'
EOF

```

### 4. Configure i3

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

### 5. Configure i3blocks

```bash
# Back up existing i3blocks directory
mv ~/.config/i3blocks ~/.config/i3blocks.bak 2>/dev/null || true

# Symlink full directory
ln -sfn ~/dotfiles/i3blocks ~/.config/i3blocks

```

### 6. Apply Changes

Restart i3 and reload Bash:

```bash
i3-msg restart
source ~/.bashrc

```

---

## Daily Workflow

### Push Changes (From active machine)

```bash
dotpush
# Or manually:
# cd ~/dotfiles && git add -u && git commit -m "Update dotfiles" && git push

```

### Pull Changes (On other machine)

```bash
dotpull
# Or manually:
# cd ~/dotfiles && git pull && i3-msg restart

```
