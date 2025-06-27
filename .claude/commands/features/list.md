List all development features of the currently logged in user by:

1. Find the USERNAME of the currently logged in user in the terminal
2. Check if `.claude/features/USERNAME/` directory exists
3. List all `.md` files (excluding hidden files and `.current-feature.md`)
4. For each feature file:
   - Show the filename
   - Extract and show the feature title
   - Show the date/time
   - Show first few lines of the overview if available
5. If `.claude/features/USERNAME/.current-feature.md` exists, highlight which feature is currently active
6. Sort by most recent first

Present in a clean, readable format.