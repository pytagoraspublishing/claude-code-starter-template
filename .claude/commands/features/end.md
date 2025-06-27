End the current development feature by:

1. Find the current terminal USERNAME.
2. Check `.claude/features/USERNAME/.current-feature` for the active feature
3. If no active feature, inform user there's nothing to end
4. If feature exists, append a comprehensive summary including:
   - Feature duration
   - Git summary:
     * Total files changed (added/modified/deleted)
     * List all changed files with change type
     * Number of commits made (if any)
     * Final git status
   - Todo summary:
     * Total tasks completed/remaining
     * List all completed tasks
     * List any incomplete tasks with status
   - Key accomplishments
   - All features implemented
   - Problems encountered and solutions
   - Breaking changes or important findings
   - Dependencies added/removed
   - Configuration changes
   - Deployment steps taken
   - Lessons learned
   - What wasn't completed
   - Tips for future developers

5. Empty the `.claude/features/USERNAME/.current-feature.md` file (don't remove it, just clear its contents)
6. Inform user the feature has been documented

The summary should be thorough enough that another developer (or AI) can understand everything that happened without reading the entire feature.