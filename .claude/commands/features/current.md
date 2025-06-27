Show the current feature status by:

1. Find the current terminal USERNAME.
2. Check if `.claude/features/USERNAME/.current-feature.md` exists
3. If no active feature, inform user and suggest starting one
4. If active feature exists:
   - Show feature name and filename
   - Calculate and show duration since start
   - Show last few updates
   - Show current goals/tasks
   - Remind user of available commands

Keep the output concise and informative.