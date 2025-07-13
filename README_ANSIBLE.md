# Ansible Dotfiles Migration

This Ansible playbook replaces the `migration.sh` bash script with a more maintainable, idempotent, and version-controlled approach to setting up your dotfiles environment.

## Prerequisites

1. **Install Ansible**:
   ```bash
   sudo pacman -S ansible
   ```

2. **Install required collections**:
   ```bash
   ansible-galaxy collection install -r requirements.yml
   ```

## Usage

### Basic Usage
```bash
# Run the playbook
ansible-playbook -i inventory.ini playbook.yml
```

### With Verbose Output
```bash
# Run with verbose output to see detailed progress
ansible-playbook -i inventory.ini playbook.yml -v
```

### Dry Run (Check Mode)
```bash
# See what would be changed without making changes
ansible-playbook -i inventory.ini playbook.yml --check
```

## Features

### ✅ **Idempotent Operations**
- The playbook can be run multiple times safely
- Only installs packages that aren't already installed
- Only copies files that have changed

### ✅ **Better Error Handling**
- Continues execution even if some AUR packages fail to install
- Provides detailed error messages for troubleshooting

### ✅ **Modular Design**
- Tasks are organized logically
- Easy to modify individual sections
- Can run specific parts of the setup

### ✅ **Version Control Friendly**
- All configuration is in YAML format
- Easy to track changes in git
- Can be used in CI/CD pipelines

## What the Playbook Does

1. **Package Installation**:
   - Installs yay (AUR helper) if not present
   - Installs all pacman packages from the original script
   - Installs all AUR packages from the original script

2. **Configuration Files**:
   - Copies all config files to `~/.config/`
   - Copies shell configuration files (bashrc, aliases, etc.)
   - Sets up tmux with TPM

3. **System Configuration**:
   - Copies system-wide configs (proxychains, keyboard, doas)
   - Sets up QEMU and virtualization
   - Configures user groups

4. **Themes and Tools**:
   - Sets up Rofi themes
   - Downloads QT5CT themes
   - Installs FZF
   - Downloads pistol for lf

5. **Custom Scripts**:
   - Copies local bin files
   - Clones wim repository
   - Runs NEKO updater

## Quick Start

```bash
# Install Ansible
sudo pacman -S ansible

# Install collections
ansible-galaxy collection install -r requirements.yml

# Run the playbook
./run_ansible.sh

# Or run with dry-run first
./run_ansible.sh --check
```

## Advantages Over Bash Script

1. **Idempotency**: Can be run multiple times safely
2. **Error Handling**: Better error reporting and recovery
3. **Modularity**: Easy to modify individual components
4. **Version Control**: YAML is more git-friendly than bash
5. **Documentation**: Self-documenting through task names
6. **Testing**: Can use Ansible's testing frameworks
7. **CI/CD**: Can be integrated into automated workflows
