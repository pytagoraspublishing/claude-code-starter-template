List all development sessions of the currently logged in user by:

1. Find the USERNAME of the currently logged in user in the terminal
2. Check if `.claude/sessions/USERNAME/` directory exists
3. List all `.md` files (excluding hidden files and `.current-session`)
4. For each session file:
   - Show the filename
   - Extract and show the session title
   - Show the date/time
   - Show first few lines of the overview if available
5. If `.claude/sessions/USERNAME/.current-session` exists, highlight which session is currently active
6. Sort by most recent first

Present in a clean, readable format.