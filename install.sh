#!/bin/bash

set -e

INSTALL_DIR="/usr/local/bin/malang"
LINK_PATH="/usr/local/bin/mal"
SCRIPT_NAME="mal"

echo "📁 Installing MALANG interpreter..."

# Check if mal interpreter file exists in current directory
if [ ! -f "./$SCRIPT_NAME" ]; then
    echo "❌ Error: '$SCRIPT_NAME' not found in current directory."
    exit 1
fi

# Create install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "🔧 Creating $INSTALL_DIR..."
    sudo mkdir -p "$INSTALL_DIR"
fi

# Copy interpreter to install dir
echo "📄 Copying interpreter to $INSTALL_DIR..."
sudo cp "./$SCRIPT_NAME" "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Create symlink if it doesn't exist or is outdated
if [ -L "$LINK_PATH" ]; then
    echo "🔁 Updating existing symlink..."
    sudo rm "$LINK_PATH"
elif [ -f "$LINK_PATH" ]; then
    echo "⚠️ Error: $LINK_PATH exists and is not a symlink. Aborting to avoid overwrite."
    exit 1
fi

echo "🔗 Creating global symlink: $LINK_PATH -> $INSTALL_DIR/$SCRIPT_NAME"
sudo ln -s "$INSTALL_DIR/$SCRIPT_NAME" "$LINK_PATH"

echo "✅ MALANG installed successfully!"
echo "👉 You can now run: mal yourscript.mal"

