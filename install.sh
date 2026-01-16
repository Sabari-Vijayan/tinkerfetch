#!/bin/bash

# Tinkerfetch Installation Script
# Installs tinkerfetch, its configuration, and dependencies.

set -e

# --- Configuration ---
REPO_OWNER="Sabari-Vijayan"
REPO_NAME="tinkerfetch"
BRANCH="${BRANCH:-main}"
TARGET_DIR="$HOME/.config/$REPO_NAME"
BIN_DIR="$HOME/.local/bin"
BASE_URL="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH"

# --- Colors ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Helper Functions ---
log_info() { echo -e "${BLUE}::${NC} $1"; }
log_success() { echo -e "${GREEN}::${NC} $1"; }
log_error() { echo -e "${RED}!!${NC} $1"; }

# --- 1. Dependency Check ---
log_info "Checking dependencies..."
MISSING_DEPS=()
for cmd in fastfetch curl jq perl; do
    if ! command -v "$cmd" &> /dev/null; then
        MISSING_DEPS+=("$cmd")
    fi
done

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    log_error "Missing required dependencies: ${MISSING_DEPS[*]}"
    echo "Please install them using your system's package manager."
    echo "Example (Debian/Ubuntu): sudo apt install ${MISSING_DEPS[*]}"
    echo "Example (Arch): sudo pacman -S ${MISSING_DEPS[*]}"
    echo "Example (Fedora): sudo dnf install ${MISSING_DEPS[*]}"
    echo "Example (MacOS): brew install ${MISSING_DEPS[*]}"
    exit 1
fi
log_success "All dependencies met."

# --- 2. Create Directories ---
log_info "Creating directories at $TARGET_DIR..."
mkdir -p "$TARGET_DIR"
mkdir -p "$BIN_DIR"

# --- 3. Install Files ---
# Check if running locally (repo clone) or via curl
if [ -f "config.jsonc" ] && [ -f "tinkerfetch" ] && [ -f "events.jsonc" ]; then
    log_info "Installing from local directory..."
    cp config.jsonc events.jsonc logo.txt tinkerfetch "$TARGET_DIR/"
else
    log_info "Fetching files from GitHub ($BRANCH)..."
    FILES=("config.jsonc" "events.jsonc" "logo.txt" "tinkerfetch")
    for file in "${FILES[@]}"; do
        log_info "Downloading $file..."
        if ! curl -fsSL "$BASE_URL/$file" -o "$TARGET_DIR/$file"; then
            log_error "Failed to download $file from $BASE_URL/$file"
            exit 1
        fi
    done
fi

# --- 4. Set Permissions ---
chmod +x "$TARGET_DIR/tinkerfetch"

# --- 5. Create Symlink ---
log_info "Creating symlink in $BIN_DIR..."
ln -sf "$TARGET_DIR/tinkerfetch" "$BIN_DIR/tinkerfetch"

# --- 6. Path Configuration ---
log_info "Configuring PATH..."
SHELL_RC=""
case "$SHELL" in
    */zsh) SHELL_RC="$HOME/.zshrc" ;;
    */bash) SHELL_RC="$HOME/.bashrc" ;;
    *) SHELL_RC="$HOME/.profile" ;;
esac

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    if [ -f "$SHELL_RC" ]; then
        if ! grep -q "$BIN_DIR" "$SHELL_RC"; then
            echo "" >> "$SHELL_RC"
            echo "# tinkerfetch path" >> "$SHELL_RC"
            echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_RC"
            log_success "Added $BIN_DIR to $SHELL_RC"
        else
            log_info "$BIN_DIR is already in $SHELL_RC"
        fi
    else
        log_info "Could not determine shell config file. Please manually add $BIN_DIR to your PATH."
    fi
else
    log_success "$BIN_DIR is already in your PATH."
fi

# --- 7. Done ---
echo -e "\n${GREEN}✅ Installation Complete!${NC}"
echo -e "Restart your terminal or run: ${BLUE}source $SHELL_RC${NC}"
echo -e "Then run: ${GREEN}tinkerfetch --events${NC}\n"
