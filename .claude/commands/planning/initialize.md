# /project:planning:initialize

Initializes the planning folder structure for either a single app or multi-app project.

## Usage

`/project:planning:initialize <type>`

### Arguments

- `type`: Required. Must be either `single` or `multi`
  - `single`: For single application projects
  - `multi`: For multi-application systems

## Description

This command creates the initial planning folder structure based on the project type:

### For single app ($ARGUMENTS = `single`):
- Creates `planning/` folder
- Creates `planning/rules/` folder
- Creates `planning/app/` folder
- Creates `planning/app/app_manifesto.md` file
- Creates `planning/app/ui/` folder
- Creates `planning/app/ui/inspirations/` folder

### For multi-app ($ARGUMENTS = `multi`):
- Creates `planning/` folder
- Creates `planning/rules/` folder
- Creates `planning/rules/system_manifesto.md` file
- Creates `planning/rules/ui/` folder
- Creates `planning/rules/ui/inspirations/` folder

## Examples

```
/project:planning:initialize single
```

```
/project:planning:initialize multi
```