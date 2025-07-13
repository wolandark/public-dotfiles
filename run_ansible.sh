#!/usr/bin/env bash

# Ansible Dotfiles Migration Runner
# This script provides an easy way to run the Ansible playbook

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_ansible() {
    if ! command -v ansible &> /dev/null; then
        print_error "Ansible is not installed. Please install it first:"
        echo "sudo pacman -S ansible"
        exit 1
    fi
    print_success "Ansible is installed"
}

install_collections() {
    print_status "Installing required Ansible collections..."
    ansible-galaxy collection install -r requirements.yml
    print_success "Collections installed"
}

main() {
    print_status "Starting Ansible dotfiles migration..."
    
    check_ansible
    install_collections
    
    DRY_RUN=false
    VERBOSE=""
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --check|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE="-v"
                shift
                ;;
            -vv|--very-verbose)
                VERBOSE="-vv"
                shift
                ;;
            -vvv|--debug)
                VERBOSE="-vvv"
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --check, --dry-run    Show what would be changed without making changes"
                echo "  -v, --verbose         Verbose output"
                echo "  -vv, --very-verbose  More verbose output"
                echo "  -vvv, --debug        Maximum verbosity"
                echo "  --help, -h           Show this help message"
                echo ""
                echo "Examples:"
                echo "  $0                    # Run normally"
                echo "  $0 --check           # Dry run"
                echo "  $0 -v                # Verbose output"
                echo "  $0 --check -v        # Dry run with verbose output"
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    # Build command
    CMD="ansible-playbook -i inventory.ini playbook.yml"
    
    if [ "$DRY_RUN" = true ]; then
        CMD="$CMD --check"
        print_warning "Running in dry-run mode (no changes will be made)"
    fi
    
    if [ -n "$VERBOSE" ]; then
        CMD="$CMD $VERBOSE"
    fi
    
    print_status "Running: $CMD"
    echo ""
    
    # Execute the command
    if eval "$CMD"; then
        print_success "Ansible playbook completed successfully!"
        
        if [ "$DRY_RUN" = true ]; then
            print_warning "This was a dry run. Run without --check to apply changes."
        else
            print_success "Your dotfiles have been migrated successfully!"
        fi
    else
        print_error "Ansible playbook failed!"
        exit 1
    fi
}

main "$@"