# Git Commit and Push Command

This command creates detailed commit messages and automatically pushes changes to the remote repository.

## Command Usage

`@git-commit-and-push [message]`

Examples:
- `@git-commit-and-push` - Will create a commit from staged changes with a detailed message
- `@git-commit-and-push "Add user authentication"` - Will create a commit with the provided message as the summary

## What This Command Does

- Creates detailed commit messages that explain:
  - What changes were made
  - Why the changes were made
  - Benefits or improvements achieved
  - Any breaking changes or important notes
- Automatically pushes to remote after committing, unless explicitly told otherwise
- Uses conventional commit format when appropriate (feat:, fix:, refactor:, etc.)
- Includes context about the scope and impact of changes

## Prerequisites

- Git repository must be initialized
- Changes must be staged with `git add`
- Working directory should be in the repository root

## Commit Message Format

### Type prefixes (conventional commit format):
- `feat:` - New feature
- `fix:` - Bug fix
- `refactor:` - Code refactoring
- `docs:` - Documentation changes
- `test:` - Test changes
- `chore:` - Maintenance tasks
- `style:` - Code style changes (formatting, missing semicolons, etc.)
- `perf:` - Performance improvements

### Commit message structure:

```
type: brief description

- Detailed bullet points explaining changes
- Technical details about implementation
- Benefits and improvements
- Any important notes for future developers
```

### Example commit messages:

```
feat: Add user authentication system

- Implement JWT-based authentication middleware
- Add login and registration endpoints
- Create user model with password hashing
- Add input validation for auth endpoints
- Benefits: Secure user access, session management
- Breaking changes: None

fix: Resolve memory leak in image processing

- Fix unclosed file streams in image loader
- Add proper resource cleanup in finally blocks
- Implement weak references for cached images
- Benefits: Reduced memory usage by 40%
- Breaking changes: None

refactor: Restructure database query logic

- Extract query builders into separate classes
- Implement repository pattern for data access
- Add query result caching layer
- Benefits: Improved testability and maintainability
- Breaking changes: API changes in DataAccess layer
```

## Process Flow

### Step 1: Check Git Status

Verify that there are staged changes to commit:

```bash
git status
```

**If no staged changes:**
- Inform user that nothing is staged
- Ask if they want to stage all changes with `git add .`
- Wait for user confirmation before proceeding

**If working directory has unstaged changes:**
- Notify user of unstaged changes
- Optionally offer to stage all changes

### Step 2: Analyze Changes

Determine what type of commit this is by examining the staged changes:

- Check modified files with `git diff --cached`
- Identify the primary type of change (feat, fix, refactor, etc.)
- Understand the scope and impact of changes

### Step 3: Generate Commit Message

**If message provided:**
- Use the provided message as the summary line
- Analyze the changes to generate detailed bullet points
- Add technical details, benefits, and important notes

**If no message provided:**
- Analyze staged changes to determine appropriate type
- Generate a descriptive summary based on file changes
- Create detailed bullet points explaining what was changed
- Add benefits and improvements achieved
- Note any breaking changes

### Step 4: Create Commit

Execute the commit with the generated message:

```bash
git commit -m "Type: Summary

- Bullet point 1
- Bullet point 2
- Benefits and improvements
- Important notes"
```

### Step 5: Push to Remote

Automatically push the commit to the remote repository:

```bash
git push
```

**If push fails:**
- Check if remote is configured
- Check if branch is being tracked
- Prompt user for instructions

**Special cases:**
- If user explicitly says not to push, skip this step
- If branch doesn't exist remotely, use `git push -u origin <branch>`

## Error Handling

### No Staged Changes
If there are no staged changes to commit:
- Inform the user
- Offer to stage all changes automatically
- Wait for user confirmation

### Nothing to Commit
If there's nothing new to commit:
- Inform the user that working directory is clean
- Suggest checking status with `git status`

### Push Conflicts
If push fails due to conflicts:
- Inform user of the conflict
- Suggest pulling latest changes first
- Offer to help resolve conflicts

## Examples

### Simple Bug Fix

```
User command: @git-commit-and-push

System analysis: Modified files include bug_fix.dart, tests updated
Generated commit:
fix: Resolve null pointer exception in data processor

- Add null checks in processData method
- Update error handling to gracefully handle missing data
- Add unit tests for edge cases
- Benefits: Prevents crashes when processing incomplete data
- Breaking changes: None

[pushed to remote]
```

### Feature with Description

```
User command: @git-commit-and-push "Add dark mode support"

System analysis: Modified UI components, added theme provider
Generated commit:
feat: Add dark mode support

- Implement theme provider with dark/light mode switching
- Update all UI components to respect theme settings
- Add user preference persistence in local storage
- Create theme toggle in settings page
- Benefits: Improved user experience, reduced eye strain
- Breaking changes: Theme API changes in UI components

[pushed to remote]
```

## Best Practices

1. **Always review the generated message** - Ensure it accurately describes the changes
2. **Provide context** - Include details about why changes were made
3. **Mention breaking changes** - Always note if changes affect existing functionality
4. **Keep summaries concise** - First line should be under 50 characters when possible
5. **Be descriptive in bullet points** - Provide enough detail for future reference
6. **Use conventional commit types** - Helps with automated tooling and changelog generation

## Additional Notes

- This command automatically pushes to remote unless explicitly told not to
- The commit message format is designed to be informative for code review and future reference
- Breaking changes should always be clearly marked
- The command will analyze file changes to provide context-aware commit messages
