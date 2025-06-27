Show help for the feature management system:

## feature Management Commands

The feature system helps document development work for future reference.

### Available Commands:

- `/project:feature:start [featurename]` - Start a new feature with optional feature name
- `/project:feature:update [notes]` - Add notes to current feature  
- `/project:feature:end` - End feature with comprehensive summary
- `/project:feature:list` - List all feature files
- `/project:feature:current` - Show current feature status
- `/project:feature:help` - Show this help

### How It Works:

1. features are markdown files in `.claude/features/USERNAME` where USERNAME is the username of the currently logged in user in the Terminal
2. Files use `YYYY-MM-DD-HHMM-featurename.md` format
3. Only one feature can be active at a time
4. features track progress, issues, solutions, and learnings

### Best Practices:

- Start a feature when beginning significant work
- Update regularly with important changes or findings
- End with thorough summary for future reference
- Review past features before starting similar work

### Example Workflow:

```
/project:feature-start refactor-auth
/project:feature-update Added Google OAuth restriction
/project:feature-update Fixed Next.js 15 params Promise issue  
/project:feature-end
```