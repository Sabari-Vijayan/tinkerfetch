#!/bin/bash

# Configuration
REPO_NAME="tinkerfetch"
TARGET_DIR="$HOME/.config/$REPO_NAME"
BIN_DIR="$HOME/.local/bin"
SHELL_RC="$HOME/.bashrc"
# Check for Zsh if Bash isn't the primary
[[ $SHELL == *"zsh"* ]] && SHELL_RC="$HOME/.zshrc"

echo -e "\e[32m[1/3]\e[0m Creating directories at $TARGET_DIR..."
mkdir -p "$TARGET_DIR"
mkdir -p "$BIN_DIR"

echo -e "\e[32m[2/3]\e[0m Installing files..."
# Copy all assets to the config folder
cp config.jsonc events.jsonc logo.txt tinkerfetch "$TARGET_DIR/"
chmod +x "$TARGET_DIR/tinkerfetch"

# Create a symbolic link in the local bin
ln -sf "$TARGET_DIR/tinkerfetch" "$BIN_DIR/tinkerfetch"

echo -e "\e[32m[3/3]\e[0m Updating shell PATH..."
# Only add to PATH if it's not already there to prevent duplication
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    if ! grep -q "$BIN_DIR" "$SHELL_RC"; then
        echo -e "\n# $REPO_NAME path\nexport PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_RC"
        echo "Added $BIN_DIR to $SHELL_RC"
    fi
fi

echo -e "\n\e[32m✅ Installation Complete!\e[0m"
echo -e "Please run: \e[33msource $(basename "$SHELL_RC")\e[0m"
echo -e "Then try: \e[36mtinkerfetch --events\e[0m"
