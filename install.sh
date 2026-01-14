#!/bin/bash

# 1. Check if fastfetch is installed
if ! command -v fastfetch &> /dev/null; then
    echo "❌ Error: 'fastfetch' is not installed."
    echo "Please install it first (e.g., 'sudo apt install fastfetch' or 'brew install fastfetch')."
    exit 1
fi

# 2. Create the directory
mkdir -p ~/.config/tinkerfetch

# 3. Download the files (Using the RAW github domain)
BASE_URL="https://raw.githubusercontent.com/Sabari-Vijayan/tinkerfetch/main"

echo "Downloading configuration..."
curl -sL "$BASE_URL/config.jsonc" -o ~/.config/tinkerfetch/config.jsonc
curl -sL "$BASE_URL/logo.txt" -o ~/.config/tinkerfetch/logo.txt

# 4. Add the alias to .bashrc or .zshrc
# using a variable for the alias to keep it clean
TF_ALIAS="alias tinkerfetch='fastfetch --config ~/.config/tinkerfetch/config.jsonc'"

if [ -f ~/.bashrc ] && ! grep -q "alias tinkerfetch=" ~/.bashrc; then
    echo "$TF_ALIAS" >> ~/.bashrc
    echo "Added alias to .bashrc"
fi

if [ -f ~/.zshrc ] && ! grep -q "alias tinkerfetch=" ~/.zshrc; then
    echo "$TF_ALIAS" >> ~/.zshrc
    echo "Added alias to .zshrc"
fi

echo "✅ Tinkerfetch installed successfully!"
echo "Restart your terminal or run 'source ~/.bashrc' (or ~/.zshrc) and type 'tinkerfetch'."
