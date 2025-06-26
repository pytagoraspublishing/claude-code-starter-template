Show the current session status by:

1. Find the current terminal USERNAME.
2. Check if `.claude/sessions/USERNAME/.current-session` exists
3. If no active session, inform user and suggest starting one
4. If active session exists:
   - Show session name and filename
   - Calculate and show duration since start
   - Show last few updates
   - Show current goals/tasks
   - Remind user of available commands

Keep the output concise and informative.