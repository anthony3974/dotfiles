### Download (First-Time Setup / Fresh Machine)

To clone the repo and set up the symlinks from scratch:

```bash
# 1. Clone your repo
git clone git@github.com:anthony3974/dotfiles.git ~/dotfiles

# 2. Back up existing i3 config if present
mv ~/.config/i3/config ~/.config/i3/config.bak 2>/dev/null || true

# 3. Create core symlinks
ln -sf ~/dotfiles/i3/config ~/.config/i3/config
ln -sfn ~/dotfiles/i3/conf.d ~/.config/i3/conf.d

# 4. Link the host override (run ONE of these depending on the machine):
# On Desktop:
ln -sf ~/dotfiles/i3/hosts/desktop.conf ~/.config/i3/local.conf

# On Laptop:
# ln -sf ~/dotfiles/i3/hosts/laptop.conf ~/.config/i3/local.conf

```

---

### Update Commands (Daily Workflow)

#### 1. Push Updates (From whichever machine you made changes on)

Because `~/.config/i3/config` points directly to `~/dotfiles/i3/config`, any edits you make are already inside the repo:

```bash
cd ~/dotfiles
git add -u
git commit -m "Update i3 configuration"
git push

```

#### 2. Pull & Apply Updates (On the other machine)

Pull down the new changes and instantly reload i3 without restarting your session:

```bash
cd ~/dotfiles && git pull && i3-msg reload

```

---

### Handy Bash Aliases (Optional)

Add these to your `~/.bashrc` to update or pull changes with a single word:

```bash
# Push dotfiles changes
alias dotpush='cd ~/dotfiles && git add -u && git commit -m "Update dotfiles" && git push && cd -'

# Pull changes and reload i3 immediately
alias dotpull='cd ~/dotfiles && git pull && i3-msg reload && cd -'

```

# part
# 2
Create the `README.md` file in the root of your `~/dotfiles` directory, commit it, and push it to GitHub.

### 1. Create the File

Run this on your desktop to generate a clean, structured `README.md`:

```bash
cat << 'EOF' > ~/dotfiles/README.md
# Dotfiles

Personal configuration files for Arch Linux running the i3 window manager.

## Structure

```text
~/dotfiles/
├── i3/
│   ├── config          # Core shared i3 configuration
│   ├── conf.d/         # Modular includes (e.g., i3bar.conf)
│   └── hosts/          # Machine-specific overrides
│       ├── desktop.conf
│       └── laptop.conf
└── README.md

```

## Setup & Installation

### 1. Clone the repository

```bash
git clone git@github.com:anthony3974/dotfiles.git ~/dotfiles

```

### 2. Symlink core i3 configurations

```bash
mkdir -p ~/.config/i3
ln -sf ~/dotfiles/i3/config ~/.config/i3/config
ln -sfn ~/dotfiles/i3/conf.d ~/.config/i3/conf.d

```

### 3. Link host-specific override

**Desktop:**

```bash
ln -sf ~/dotfiles/i3/hosts/desktop.conf ~/.config/i3/local.conf

```

**Laptop:**

```bash
ln -sf ~/dotfiles/i3/hosts/laptop.conf ~/.config/i3/local.conf

```

### 4. Reload i3

Press `$mod+Shift+z` or run:

```bash
i3-msg reload

```

## Daily Workflow

* **Push updates:**
```bash
cd ~/dotfiles && git add -u && git commit -m "Update configs" && git push

```


* **Pull updates & reload:**
```bash
cd ~/dotfiles && git pull && i3-msg reload

```



EOF

```

---

### 2. Commit and Push to GitHub

```bash
cd ~/dotfiles
git add README.md
git commit -m "Add README with installation and workflow docs"
git push

```

Once pushed, head over to `[https://github.com/anthony3974/dotfiles](https://github.com/anthony3974/dotfiles)` to see it rendered on your repo front page. On your laptop, a simple `cd ~/dotfiles && git pull` will fetch the new README.

