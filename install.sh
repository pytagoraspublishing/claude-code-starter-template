#!/bin/bash

# Claude Code Starter Template Installation Script
# This script pulls specific files and folders from the template repository
# into your current project.

set -e  # Exit on error

# Configuration
TEMPLATE_REPO_URL="https://github.com/pytagoraspublishing/claude-code-starter-template.git"
TEMPLATE_REMOTE_NAME="template"
TEMPLATE_BRANCH="main"

# Files and folders to import from template
# Add more items to this array as needed
TEMPLATE_ITEMS=(
    ".claude"
    "CLAUDE.md"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}→ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

# Check if we're in a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository. Please initialize git first with 'git init'"
        exit 1
    fi
}

# Check if template remote already exists
check_remote_exists() {
    if git remote get-url "$TEMPLATE_REMOTE_NAME" > /dev/null 2>&1; then
        print_warning "Remote '$TEMPLATE_REMOTE_NAME' already exists"
        read -p "Do you want to remove and re-add it? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git remote remove "$TEMPLATE_REMOTE_NAME"
            print_success "Removed existing remote '$TEMPLATE_REMOTE_NAME'"
        else
            print_info "Using existing remote"
            return 0
        fi
    fi
    return 1
}

# Add template remote
add_template_remote() {
    print_info "Adding template remote..."
    git remote add "$TEMPLATE_REMOTE_NAME" "$TEMPLATE_REPO_URL"
    print_success "Added template remote: $TEMPLATE_REPO_URL"
}

# Fetch from template
fetch_template() {
    print_info "Fetching from template repository..."
    git fetch "$TEMPLATE_REMOTE_NAME" --quiet
    print_success "Fetched template repository"
}

# Check for conflicts
check_conflicts() {
    local item="$1"
    if [ -e "$item" ]; then
        print_warning "$item already exists in your project"
        read -p "Do you want to overwrite it? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Skipping $item"
            return 1
        fi
    fi
    return 0
}

# Import files and folders
import_template_items() {
    local imported_count=0
    local skipped_count=0
    
    print_info "Importing template files and folders..."
    
    for item in "${TEMPLATE_ITEMS[@]}"; do
        if check_conflicts "$item"; then
            print_info "Importing $item..."
            if git checkout "${TEMPLATE_REMOTE_NAME}/${TEMPLATE_BRANCH}" -- "$item" 2>/dev/null; then
                print_success "Imported $item"
                ((imported_count++))
            else
                print_warning "Could not find $item in template repository"
            fi
        else
            ((skipped_count++))
        fi
    done
    
    echo
    print_info "Summary: $imported_count items imported, $skipped_count items skipped"
}

# Remove template remote
cleanup_remote() {
    read -p "Do you want to remove the template remote? (Y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        git remote remove "$TEMPLATE_REMOTE_NAME"
        print_success "Removed template remote"
    else
        print_info "Template remote kept as '$TEMPLATE_REMOTE_NAME'"
    fi
}

# Main execution
main() {
    echo "Claude Code Starter Template Installer"
    echo "======================================"
    echo
    
    # Step 1: Check git repository
    check_git_repo
    
    # Step 2: Handle remote
    if ! check_remote_exists; then
        add_template_remote
    fi
    
    # Step 3: Fetch template
    fetch_template
    
    # Step 4: Import items
    import_template_items
    
    # Step 5: Cleanup
    echo
    cleanup_remote
    
    echo
    print_success "Installation complete!"
    echo
    echo "Next steps:"
    echo "1. Review the imported files"
    echo "2. Commit the changes: git add . && git commit -m 'Import Claude Code template'"
    echo "3. Check CLAUDE.md for project setup instructions"
}

# Run main function
main