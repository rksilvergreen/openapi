# Git Merge to Main Command

This command handles controlled, versioned merges to the main branch with proper branching strategy. It requires version specification and ensures proper branching workflow.

## Command Usage

`@git-merge-to-main <version>`

**Version Format**: X.Y.Z (major.minor.patch)

Examples:
- `@git-merge-to-main 1.0.0` - Merge to main with version 1.0.0
- `@git-merge-to-main 2.5.3` - Merge to main with version 2.5.3

**Important**: Version is required. The command will fail if not provided.

## What This Command Does

- Validates current version in pubspec.yaml and main.dart
- Ensures you're not on the main branch
- Commits and pushes any current changes
- Merges feature branch to develop if needed
- Checks out main branch
- Merges develop into main with a merge commit
- Tags main branch with version number
- Returns to original branch
- Pushes all changes including tags to remote

## Prerequisites

- Git repository must be initialized
- Must have both main and develop branches
- Must NOT be on the main branch
- pubspec.yaml file must exist
- main.dart file must exist (if using version constant)

## Version Validation

The command verifies version consistency across:

1. **pubspec.yaml** - `version:` field
2. **main.dart** - `const VERSION = 'X.Y.Z'` constant (if present)

If versions don't match the requested version, they will be updated automatically.

## Branch Validation

The command enforces proper branching strategy:

- **NOT allowed**: Currently on main branch
- **Allowed**: On develop branch or any feature branch off develop
- Feature branches will be merged to develop first

## Complete Workflow

### Step 1: Validate Version Format

Check that the provided version follows X.Y.Z format and is parseable.

**If version invalid:**
- Show current version from pubspec.yaml
- Ask user to provide valid version
- Halt execution until valid version provided

### Step 2: Check Current Branch

```bash
git branch --show-current
```

**If on main branch:**
- Error: Cannot merge to main from main branch
- Suggest checking out develop or feature branch first
- Halt execution

**If not on main:** Proceed to next step

### Step 3: Check Version Consistency

Read and compare versions:

1. **Check pubspec.yaml:**
   ```yaml
   version: X.Y.Z
   ```

2. **Check main.dart (if exists):**
   ```dart
   const VERSION = 'X.Y.Z';
   ```

**If versions don't match requested version:**
- Update pubspec.yaml version
- Update main.dart VERSION constant (if exists)
- Stage the changes for commit

### Step 4: Commit Current Changes (if any)

Check if there are uncommitted changes:

```bash
git status
```

**If there are changes:**
- Stage all changes: `git add .`
- Create commit with message: `chore: Update version to X.Y.Z`
- Proceed to next step

**If no changes:** Skip to next step

### Step 5: Determine Branch Type

**If on develop branch:**
- Merge source: current branch (develop)
- Skip to Step 7 (skip feature branch merge)

**If on feature branch:**
- Merge source: feature branch
- Proceed to Step 6

### Step 6: Merge Feature Branch to Develop

If on a feature branch, merge it to develop:

```bash
git checkout develop
git merge --no-ff <feature-branch> -m "chore: Merge <feature-branch> to develop"
git push origin develop
```

**Note**: Uses `--no-ff` to ensure a merge commit is created even for fast-forward merges.

### Step 7: Merge to Main

Checkout main and merge develop:

```bash
git checkout main
git merge --no-ff develop -m "chore: Release version X.Y.Z"
```

**Critical**: 
- Always checkout main before merging
- Always use `--no-ff` to create a merge commit
- This preserves the history and makes the merge point clear

### Step 8: Tag the Release

Create an annotated tag on main:

```bash
git tag -a vX.Y.Z -m "Release version X.Y.Z"
```

**Tag format**: vX.Y.Z (e.g., v1.0.0, v2.5.3)

### Step 9: Push to Remote

Push everything to remote:

```bash
git push origin main
git push origin develop
git push --tags
```

**Push order**:
1. Push main branch
2. Push develop branch
3. Push all tags

### Step 10: Return to Original Branch

Return to the branch you started from:

```bash
git checkout <original-branch>
```

**If original was main:** Skip this step (you're already on main)

## Complete Workflow Example

### Scenario: Merging feature branch to main with version 1.2.0

```bash
# Start on feature/add-dark-mode branch
git checkout develop
git merge --no-ff feature/add-dark-mode -m "chore: Merge feature/add-dark-mode to develop"
git push origin develop

# Update pubspec.yaml and main.dart to version 1.2.0
# Stage and commit version changes

# Merge to main
git checkout main
git merge --no-ff develop -m "chore: Release version 1.2.0"

# Tag the release
git tag -a v1.2.0 -m "Release version 1.2.0"

# Push everything
git push origin main
git push origin develop
git push --tags

# Return to original branch
git checkout feature/add-dark-mode
```

## Error Handling

### Already on Main Branch
```
Error: Cannot merge to main from main branch
Please checkout develop or a feature branch first
```

### Invalid Version Format
```
Error: Invalid version format
Provided: 1.0
Required format: X.Y.Z (major.minor.patch)
Current version: 1.0.0
Please provide a valid version number
```

### Uncommitted Changes
```
Warning: You have uncommitted changes
These will be committed automatically as part of version update
Stage changes? [y/n]
```

### Merge Conflicts
```
Error: Merge conflicts detected
Please resolve conflicts manually:
1. Resolve conflicts in affected files
2. Stage resolved files: git add .
3. Complete merge: git commit
4. Run @git-merge-to-main again
```

## Version Update Examples

### pubspec.yaml Update

**Before:**
```yaml
name: my_package
version: 1.1.5
```

**After (requested 1.2.0):**
```yaml
name: my_package
version: 1.2.0
```

### main.dart Update

**Before:**
```dart
const String VERSION = '1.1.5';
```

**After (requested 1.2.0):**
```dart
const String VERSION = '1.2.0';
```

## Best Practices

1. **Always use versioned merges** - Don't merge to main without a version
2. **Follow semantic versioning** - Use MAJOR.MINOR.PATCH format
3. **Test before merging** - Ensure code works before merging to main
4. **Use descriptive branch names** - Makes history clearer
5. **Review before pushing** - Double-check what you're about to release
6. **Keep develop updated** - Regularly sync develop with main

## Important Notes

- **Always creates merge commits**: Uses `--no-ff` flag to preserve history
- **Always checks out main first**: Never merges to main from another branch
- **Automatic version updates**: Updates both pubspec.yaml and main.dart
- **Tagged releases**: Creates annotated tags for each release
- **Complete push**: Pushes branches and tags to remote
- **Returns to origin**: Restores your original working context

## Troubleshooting

### "Already up to date" Message
If you see "Already up to date" when merging to main:
- This means main already has all changes from develop
- The merge will still create a merge commit due to `--no-ff`
- Tag and push will proceed normally

### Tag Already Exists
If the tag already exists:
```
Error: Tag vX.Y.Z already exists
Please use a different version or delete the existing tag
```

Solution: Use a different version or delete existing tag:
```bash
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
```

### Remote Push Fails
If push fails due to remote changes:
- Pull latest changes first
- Resolve any conflicts
- Retry the merge command
