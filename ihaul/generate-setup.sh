#!/bin/bash

# generate-setup.sh: Generates a setup.sh script to clone your macOS setup onto another machine.

OUTPUT_FILE="setup.sh"

echo "Generating setup.sh..."

cat >"$OUTPUT_FILE" <<'EOF'
#!/bin/bash

# setup.sh: Script to set up a macOS system based on your current configuration.

# Exit on errors
set -e

echo "Setting up macOS system..."

# --- Helper functions ---
function install_homebrew {
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed!"
  else
    echo "Homebrew already installed!"
  fi
}

function install_brew_packages {
  echo "Installing Homebrew packages..."
  brew update
EOF

# List installed Homebrew packages and append to setup.sh
brew list --formula | while read -r package; do
  echo "  brew install $package" >>"$OUTPUT_FILE"
done

# List installed Homebrew casks and append to setup.sh
brew list --cask | while read -r cask; do
  echo "  brew install --cask $cask" >>"$OUTPUT_FILE"
done

cat >>"$OUTPUT_FILE" <<'EOF'
  echo "Homebrew packages installed!"
}

function clone_dotfiles {
  echo "Cloning dotfiles..."
  # Replace with your actual dotfiles repository URL
  DOTFILES_REPO="https://github.com/your-username/dotfiles.git"
  DOTFILES_DIR="$HOME/.dotfiles"

  if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    echo "Dotfiles cloned!"
  else
    echo "Dotfiles repository already exists at $DOTFILES_DIR"
  fi

  echo "Applying dotfiles..."
  if [ -f "$DOTFILES_DIR/install.sh" ]; then
    bash "$DOTFILES_DIR/install.sh"
  else
    echo "No install script found in the dotfiles repo; you may need to set it up manually."
  fi
}

function setup_environment_variables {
  echo "Setting up environment variables..."
  cat << 'EOV' >> "$HOME/.bash_profile"

# Environment Variables
export PATH="$PATH:/usr/local/bin"
# Add additional environment variables here

EOV
  echo "Environment variables set!"
}

function create_directory_structure {
  echo "Creating directory structure..."
EOF

# Append directory structure replication to setup.sh
find ~ -type d -not -path "*/.*" -not -path "*node_modules*" -not -path "*Library*" | while read -r dir; do
  echo "  mkdir -p \"$dir\"" >>"$OUTPUT_FILE"
done

cat >>"$OUTPUT_FILE" <<'EOF'
  echo "Directory structure created!"
}

function apply_macos_defaults {
  echo "Applying macOS settings..."
  # Add your custom macOS settings here
  defaults write com.apple.dock autohide -bool true
  killall Dock
  echo "macOS settings applied!"
}

# --- Main execution ---
install_homebrew
install_brew_packages
clone_dotfiles
setup_environment_variables
create_directory_structure
apply_macos_defaults

echo "Setup complete! Please restart your terminal for changes to take effect."
EOF

chmod +x "$OUTPUT_FILE"

echo "setup.sh generated successfully!"
echo "Run './setup.sh' on the target machine to replicate your macOS setup."
