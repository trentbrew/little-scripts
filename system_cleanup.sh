#!/bin/bash

# system_cleanup.sh - System Storage Cleanup Workflow
# Usage: bash system_cleanup.sh [--auto]
# The --auto flag will skip confirmations (use with caution)

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo -e "\n${GREEN}=== $1 ===${NC}\n"
}

# Function to ask for confirmation
confirm() {
    if [[ "$AUTO" == "true" ]]; then
        return 0
    fi
    read -p "$1 (y/n) " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Check for --auto flag
AUTO="false"
if [[ "$1" == "--auto" ]]; then
    AUTO="true"
    echo -e "${YELLOW}Running in automatic mode. All cleanups will be executed without confirmation.${NC}"
fi

print_header "1. Analyzing System Storage"

# Find large directories in Library
echo "Largest directories in ~/Library:"
du -sh ~/Library/* 2>/dev/null | sort -rh | head -n 10

# Find large files (>500MB)
echo -e "\nLarge files (>500MB):"
find ~ -type f -size +500M -exec du -sh {} \; 2>/dev/null | sort -rh | head -n 10

print_header "2. Checking Common Cache Locations"

# List sizes of various cache directories
echo "Cache sizes:"
CACHE_DIRS=(
    "~/Library/Caches"
    "~/Library/Application Support"
    "~/Library/Containers"
)

for dir in "${CACHE_DIRS[@]}"; do
    eval "du -sh $dir/* 2>/dev/null | sort -rh | head -n 5"
done

print_header "3. Development Tool Caches"

# Check common development tool caches
echo "Development tool caches:"
DEV_CACHE_DIRS=(
    "~/Library/Caches/pip"
    "~/Library/Caches/Yarn"
    "~/Library/Caches/pnpm"
    "~/Library/Caches/pypoetry"
    "~/Library/Developer/CoreSimulator"
    "~/Library/Caches/ms-playwright"
    "~/Library/Caches/Cypress"
)

for dir in "${DEV_CACHE_DIRS[@]}"; do
    eval "du -sh $dir 2>/dev/null"
done

print_header "4. Message Attachments"

# Check Messages attachments size
echo "Messages attachments size:"
du -sh ~/Library/Messages/Attachments 2>/dev/null

print_header "5. Cleanup Options"

# Function to cleanup with confirmation
cleanup_with_confirm() {
    local path="$1"
    local desc="$2"
    local size=$(du -sh "$path" 2>/dev/null | cut -f1)

    if [[ -e "$path" ]]; then
        echo -e "\nFound ${YELLOW}$desc${NC} using ${RED}$size${NC}"
        if confirm "Would you like to remove it?"; then
            rm -rf "$path"
            echo -e "${GREEN}Removed $desc${NC}"
        fi
    fi
}

# Offer to clean various caches
eval "cleanup_with_confirm ~/Library/Caches/com.apple.CharacterPaletteIM 'Character Palette Cache'"
eval "cleanup_with_confirm ~/Library/Developer/CoreSimulator 'iOS Simulator Files'"
eval "cleanup_with_confirm ~/Library/Messages/Attachments/* 'Message Attachments'"

print_header "6. Docker Cleanup (if installed)"

# Check if Docker is installed and offer cleanup
if command -v docker &>/dev/null; then
    echo "Docker is installed. Current usage:"
    docker system df
    if confirm "Would you like to clean unused Docker data?"; then
        docker system prune -a --volumes
    fi
fi

print_header "7. Package Manager Caches"

# Function to clean package manager caches
clean_package_cache() {
    local cmd="$1"
    local desc="$2"
    if command -v "$cmd" &>/dev/null; then
        echo -e "\nFound $desc"
        if confirm "Would you like to clean $desc cache?"; then
            case "$cmd" in
            "yarn")
                yarn cache clean
                ;;
            "pnpm")
                pnpm store prune
                ;;
            "pip3")
                pip3 cache purge
                ;;
            "poetry")
                poetry cache clear --all pypi
                ;;
            esac
            echo -e "${GREEN}Cleaned $desc cache${NC}"
        fi
    fi
}

# Clean various package manager caches
clean_package_cache "yarn" "Yarn"
clean_package_cache "pnpm" "pnpm"
clean_package_cache "pip3" "pip"
clean_package_cache "poetry" "Poetry"

print_header "Cleanup Complete"

# Final system status
echo "Current storage status:"
df -h /

echo -e "\n${GREEN}Cleanup process completed!${NC}"
echo "To save this report, pipe the output to a file:"
echo "bash system_cleanup.sh > cleanup_report_\$(date +%Y%m%d).txt"
