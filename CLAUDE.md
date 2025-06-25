# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a blank starter template for Claude Code projects. It contains only:
- A minimal README.md file
- Git initialization

## Getting Started

This template is intentionally empty to provide maximum flexibility. When starting a new project:

1. **First Steps**:
   - Determine the project type and technology stack
   - Create an appropriate `.gitignore` file
   - Initialize project configuration (e.g., `package.json`, `requirements.txt`, `go.mod`)
   - Set up the directory structure

2. **Common Initialization Commands**:
   ```bash
   # For Node.js projects
   npm init -y
   
   # For Python projects
   python -m venv venv
   touch requirements.txt
   
   # For Go projects
   go mod init [module-name]
   ```

3. **Essential Files to Create**:
   - `.gitignore` - Language-specific ignore patterns
   - Configuration files for your chosen stack
   - Source code directory structure
   - Test directory structure

## Important Notes

- No pre-existing build, test, or lint commands exist
- No dependencies or frameworks are pre-installed
- The README.md should be updated with project-specific documentation
- Add development setup instructions as the project grows