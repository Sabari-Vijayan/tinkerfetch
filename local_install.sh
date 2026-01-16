#!/bin/bash

# 1. Dependency Check
for cmd in fastfetch curl jq perl; do
    if ! command -v $cmd &> /dev/null; then
        echo "❌ Error: '$cmd' is not installed."
        exit 1
    fi
done

# 2. Setup directory
mkdir -p ~/.config/tinkerfetch

# 3. Copy LOCAL files (for testing)
echo "Installing local configuration..."
cp config.jsonc events.jsonc logo.txt tinkerfetch ~/.config/tinkerfetch/

# 4. Setup Alias/Link
# We will create a symlink so 'tinkerfetch' works from anywhere
mkdir -p ~/.local/bin
ln -sf ~/.config/tinkerfetch/tinkerfetch ~/.local/bin/tinkerfetch

# Ensure ~/.local/bin is in PATH for the user
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

echo "✅ Tinkerfetch V2 installed locally!"
echo "Run 'source ~/.bashrc' and try 'tinkerfetch --events'"
