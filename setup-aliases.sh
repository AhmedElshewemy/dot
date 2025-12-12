#!/bin/bash

# Script to setup bash aliases
# This script checks if .bash_aliases exists in home directory
# If it exists, it appends the content to the end
# If it doesn't exist, it copies the file to home directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALIASES_FILE="$SCRIPT_DIR/.bash_aliases"
HOME_ALIASES="$HOME/.bash_aliases"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if source file exists
if [ ! -f "$ALIASES_FILE" ]; then
    echo -e "${RED}Error: .bash_aliases file not found in current directory${NC}"
    exit 1
fi

# Check if .bash_aliases exists in home directory
if [ -f "$HOME_ALIASES" ]; then
    echo -e "${YELLOW}Found existing .bash_aliases in home directory${NC}"
    echo "Appending new aliases to the end of the file..."
    
    # Add a separator comment
    echo "" >> "$HOME_ALIASES"
    echo "# ============================================" >> "$HOME_ALIASES"
    echo "# Aliases added by setup script on $(date)" >> "$HOME_ALIASES"
    echo "# ============================================" >> "$HOME_ALIASES"
    
    # Append the content
    cat "$ALIASES_FILE" >> "$HOME_ALIASES"
    
    echo -e "${GREEN}✓ Aliases appended successfully${NC}"
else
    echo -e "${YELLOW}.bash_aliases not found in home directory${NC}"
    echo "Copying .bash_aliases to home directory..."
    
    # Copy the file
    cp "$ALIASES_FILE" "$HOME_ALIASES"
    
    echo -e "${GREEN}✓ .bash_aliases copied successfully${NC}"
fi

# Make sure .bashrc sources .bash_aliases
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "\.bash_aliases" "$HOME/.bashrc"; then
        echo -e "${YELLOW}Adding source command to .bashrc${NC}"
        echo "" >> "$HOME/.bashrc"
        echo "# Source bash aliases" >> "$HOME/.bashrc"
        echo "if [ -f ~/.bash_aliases ]; then" >> "$HOME/.bashrc"
        echo "    . ~/.bash_aliases" >> "$HOME/.bashrc"
        echo "fi" >> "$HOME/.bashrc"
        echo -e "${GREEN}✓ .bashrc updated${NC}"
    else
        echo -e "${GREEN}✓ .bashrc already sources .bash_aliases${NC}"
    fi
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo "Run 'source ~/.bash_aliases' or restart your terminal to use the aliases."
