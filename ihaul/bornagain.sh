#!/bin/bash

# This script sets up a new macOS system with my preferred configuration

# ------------ Create directory structure ------------

echo "Creating directory structure..."

# Work directories
mkdir -p ~/work/{turtle,gumbo}/{projects,documents,branding,media,data}

# Personal directories
mkdir -p ~/personal/{playground,documents,media,data}

# Media directories
mkdir -p ~/music/{saved,songs,samples}
mkdir -p ~/movies/{saved,youtube}

# Document directories
mkdir -p ~/documents/{cv,books,notes,articles,research,drafts}

# ------------ Install Applications ------------

echo "Installing applications..."

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Browsers
brew install --cask microsoft-edge brave-browser firefox google-chrome-canary

# IDEs
brew install --cask cursor android-studio

# Terminal
brew install --cask iterm2

# Creative apps
brew install --cask figma audacity

# Development tools
brew install git gh node nvm python poetry pyenv docker docker-compose

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# ------------ Configure Development Environment ------------

echo "Configuring development environment..."

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configure Git
git config --global user.name "Trent"
git config --global init.defaultBranch main

echo "Setup complete! Please restart your terminal."
