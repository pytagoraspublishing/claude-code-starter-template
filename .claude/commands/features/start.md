Find the USERNAME of the currently logged in user in ther terminal.
Start a new development feature by creating a feature file in `.claude/features/USERNAME/` with the format `YYYY-MM-DD-HHMM-$ARGUMENTS.md` (or just `YYYY-MM-DD-HHMM.md` if no argument provided).

The feature file should begin with:
1. feature name and timestamp as the title
2. feature overview section with start time
3. Goals section (ask user for goals if not clear)
4. Empty progress section ready for updates

After creating the file, create or update `.claude/features/USERNAME/.current-feature.md` to track the active feature filename.

Confirm the feature has started and remind the user they can:
- Update it with `/project:feature:update`
- End it with `/project:feature:end`