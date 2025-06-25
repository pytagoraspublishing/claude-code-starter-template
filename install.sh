#!/bin/bash

# Claude Code Starter Template Installation Script
# This script pulls specific files and folders from the template repository
# into your current project.

# set -e  # Exit on error - commented out to prevent early exit on user choices

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

# Detect if running interactively
if [ -t 0 ]; then
    INTERACTIVE=true
else
    INTERACTIVE=false
fi

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
        
        if [ "$INTERACTIVE" = true ]; then
            read -p "Do you want to remove and re-add it? (y/N) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git remote remove "$TEMPLATE_REMOTE_NAME"
                print_success "Removed existing remote '$TEMPLATE_REMOTE_NAME'"
            else
                print_info "Using existing remote"
                return 0
            fi
        else
            # Non-interactive mode: always remove and re-add
            git remote remove "$TEMPLATE_REMOTE_NAME"
            print_success "Removed existing remote '$TEMPLATE_REMOTE_NAME' (non-interactive mode)"
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
        
        if [ "$INTERACTIVE" = true ]; then
            read -p "Do you want to overwrite it? (y/N) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_info "Skipping $item"
                return 1
            fi
        else
            # Non-interactive mode: skip existing files for safety
            print_info "Skipping $item (already exists, non-interactive mode)"
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
    
    # Create a single temporary directory for all operations
    local temp_dir=$(mktemp -d)
    print_info "Created temporary directory: $temp_dir"
    
    # Initialize temp git repo and fetch template
    print_info "Fetching template repository into temporary directory..."
    if ! (cd "$temp_dir" && \
          git init --quiet && \
          git remote add template "$TEMPLATE_REPO_URL" && \
          git fetch template --depth=1 --quiet); then
        print_error "Failed to fetch template repository"
        rm -rf "$temp_dir"
        return 1
    fi
    
    # Process each item
    for item in "${TEMPLATE_ITEMS[@]}"; do
        if check_conflicts "$item"; then
            print_info "Importing $item..."
            
            # Checkout the item in temp directory
            if (cd "$temp_dir" && git checkout "template/${TEMPLATE_BRANCH}" -- "$item" 2>/dev/null); then
                
                # Copy from temp to current directory
                if [ -d "$temp_dir/$item" ]; then
                    cp -r "$temp_dir/$item" . && print_success "Imported $item (directory)"
                elif [ -f "$temp_dir/$item" ]; then
                    cp "$temp_dir/$item" . && print_success "Imported $item (file)"
                else
                    print_warning "$item exists in repository but could not be copied"
                    continue
                fi
                
                ((imported_count++))
            else
                print_warning "Could not find $item in template repository"
            fi
        else
            ((skipped_count++))
        fi
    done
    
    # Cleanup temp directory
    rm -rf "$temp_dir"
    print_info "Cleaned up temporary directory"
    
    echo
    print_info "Summary: $imported_count items imported, $skipped_count items skipped"
}

# Remove template remote
cleanup_remote() {
    if [ "$INTERACTIVE" = true ]; then
        read -p "Do you want to remove the template remote? (Y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            git remote remove "$TEMPLATE_REMOTE_NAME"
            print_success "Removed template remote"
        else
            print_info "Template remote kept as '$TEMPLATE_REMOTE_NAME'"
        fi
    else
        # Non-interactive mode: always remove template remote
        git remote remove "$TEMPLATE_REMOTE_NAME"
        print_success "Removed template remote (non-interactive mode)"
    fi
}

# Main execution
main() {
    echo "Claude Code Starter Template Installer"
    echo "======================================"
    echo
    
    if [ "$INTERACTIVE" = false ]; then
        print_info "Running in non-interactive mode"
        echo
    fi
    
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