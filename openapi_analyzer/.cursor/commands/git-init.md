# Git Repository Initialization Command

This command sets up a complete Git repository with proper branching strategy including main and develop branches, and optionally creates a remote repository on GitHub.

## Command Usage

`@git-init [repository_name]`

Examples:
- `@git-init` - Initialize with current directory name
- `@git-init my-project` - Initialize with specified name

## What This Command Does

- Checks for existing Git repository
- Initializes Git repository if needed
- Creates main branch (renames master if exists)
- Creates develop branch from main
- Initializes with first commit
- Optionally creates GitHub remote repository
- Sets up remote tracking for both branches
- Switches to develop branch for active development

## Prerequisites

- Git must be installed and configured
- Current directory should be a project directory
- No conflicting .git directory should exist (will be checked)

## Repository Initialization Process

### Step 1: Check for Existing Repository

Check if a Git repository already exists:

```bash
git status
```

**If repository exists:**
- Show current repository information:
  - Current branch
  - Remote configuration
  - Repository status
- Ask user if they want to:
  1. Keep existing repository
  2. Re-initialize (backup and start fresh)
  3. Cancel operation
- Wait for user confirmation before proceeding

**If no repository exists:** Proceed to Step 2

### Step 2: Determine Repository Name

Extract repository name from:
1. User-provided argument
2. Current directory name (if no argument)

Example:
- Directory: `/path/to/my-project/`
- Repository name: `my-project`

### Step 3: Initialize Git Repository

Create new Git repository:

```bash
git init
```

This creates the `.git` directory and initializes the repository.

### Step 4: Configure Initial Branch Name

Set the default branch name to `main`:

```bash
git branch -M main
```

**Note**: This creates or renames the initial branch to `main`.

### Step 5: Create Initial Commit

Create the initial commit with all project files:

```bash
git add .
git commit -m "Initial commit"
```

**Commit message**: "Initial commit"

**If no files to commit:**
- Create an empty commit:
```bash
git commit --allow-empty -m "Initial commit"
```

### Step 6: Create Develop Branch

Create and switch to develop branch:

```bash
git branch develop
git checkout develop
```

**Alternative single command:**
```bash
git checkout -b develop
```

### Step 7: Create Remote Repository (Optional)

Ask user if they want to create a GitHub remote repository:

```
Would you like to create a GitHub remote repository? [y/n]
```

**If yes:**
- Create GitHub repository using GitHub API or GitHub CLI
- Repository settings:
  - Name: repository name from Step 2
  - Private: ask user preference
  - Description: optional
  - Initialize README: no (we already have files)
  - Add .gitignore: no (use existing if present)
  - Choose license: optional

**If no:** Skip to Step 9

### Step 8: Configure Remote

Add the remote repository as origin:

```bash
git remote add origin <repository-url>
```

**URL format**: `https://github.com/username/repository-name.git`

Verify remote:
```bash
git remote -v
```

### Step 9: Push Initial Branches

Push both main and develop branches to remote:

```bash
git checkout main
git push -u origin main

git checkout develop
git push -u origin develop
```

**Note**: `-u` flag sets up tracking branches

### Step 10: Final Configuration

- Set default branch rules (optional):
  - Set develop as default branch for development
  - Configure branch protection for main (via GitHub API if available)

- Create .gitignore (if doesn't exist):
  - Suggest common ignores based on project type
  - Ask user if they want to add common ignore patterns

### Step 11: Display Summary

Show configuration summary:

```
✓ Git repository initialized
✓ Repository name: <name>
✓ Initial branch: main
✓ Development branch: develop
✓ Current branch: develop
✓ Remote: <url> (if configured)
✓ Initial commit created
✓ Branches pushed to remote (if configured)

Next steps:
1. Start making changes on develop branch
2. Create feature branches for new work
3. Merge features to develop, then to main
```

## Branch Strategy

After initialization, the repository will have:

```
main (production-ready code)
  └── develop (integration branch)
      └── feature/* (feature branches)
```

**Workflow:**
1. Create feature branches from develop
2. Merge features to develop
3. Merge develop to main for releases

## GitHub Integration

### Creating Remote Repository

**Using GitHub CLI (gh):**
```bash
gh repo create <repo-name> --private --source=. --remote=origin --push
```

**Using GitHub API:**
- POST to `https://api.github.com/user/repos`
- Include authentication token
- Configure repository settings via API

### Repository Settings

Ask user for preferences:
- **Visibility**: Public or Private
- **Description**: Optional project description
- **License**: MIT, Apache, etc.
- **Topics**: Relevant tags/keywords

## Error Handling

### Repository Already Exists

```
Git repository already exists in this directory

Current status:
- Branch: <branch-name>
- Remote: <remote-url>
- Status: <status>

Options:
1. Keep existing repository
2. Backup and re-initialize
3. Cancel

Choose an option [1-3]:
```

### Initialization Fails

```
Error: Failed to initialize Git repository

Possible causes:
- Insufficient permissions
- .git directory conflicts
- Git not installed

Please check your configuration and try again.
```

### Remote Creation Fails

```
Warning: Could not create remote repository automatically

Repository initialized locally but not connected to remote.

To add remote manually:
git remote add origin <url>
git push -u origin main
git push -u origin develop

Or use GitHub CLI:
gh repo create <repo-name>
```

## Post-Initialization

### Recommended Next Steps

1. **Configure Git User** (if not already done):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. **Set Up .gitignore**:
   - Add common ignore patterns for your project type
   - Consider using GitHub's gitignore templates

3. **Create README.md**:
   - Add project description
   - Include setup instructions
   - Document usage examples

4. **Set Up Branch Protection** (via GitHub):
   - Require pull request reviews for main
   - Require status checks to pass
   - Prevent force pushes

## Examples

### Basic Initialization

```
User: @git-init

System:
1. Checking for existing repository... None found
2. Using directory name: my-project
3. Initializing Git repository... ✓
4. Creating main branch... ✓
5. Creating initial commit... ✓
6. Creating develop branch... ✓
7. Would you like to create GitHub remote? [y/n]: n

✓ Repository initialized successfully
✓ Current branch: develop
✓ Ready for development

Next: Create feature branches for new work
```

### Full Setup with GitHub

```
User: @git-init awesome-app

System:
1. Checking for existing repository... None found
2. Using name: awesome-app
3. Initializing Git repository... ✓
4. Creating main branch... ✓
5. Creating initial commit... ✓
6. Creating develop branch... ✓
7. Would you like to create GitHub remote? [y/n]: y
   - Repository visibility [public/private]: private
   - Description: An awesome application
   - Creating GitHub repository... ✓
8. Adding remote origin... ✓
9. Pushing main branch... ✓
10. Pushing develop branch... ✓

✓ Repository fully configured
✓ Local and remote branches synced
✓ Current branch: develop

Repository URL: https://github.com/username/awesome-app.git
```

### Existing Repository Detected

```
User: @git-init

System:
Git repository already exists in this directory

Current status:
- Branch: feature/new-api
- Remote: https://github.com/username/my-project.git
- Status: Modified files

Options:
1. Keep existing repository
2. Backup and re-initialize
3. Cancel

Choose an option [1-3]: 1

Keeping existing repository as-is.
```

## Best Practices

1. **Always use develop as working branch** - Main is for stable releases only
2. **Create feature branches** - One branch per feature/fix
3. **Regular commits** - Commit often with descriptive messages
4. **Pull before push** - Sync with remote before pushing changes
5. **Protect main branch** - Use branch protection rules on GitHub
6. **Version tags** - Tag releases on main branch
7. **Keep history clean** - Use meaningful commit messages

## Additional Configuration

### Initial .gitignore

Suggest creating .gitignore based on project type:

**Dart/Flutter:**
```
.dart_tool/
.flutter-plugins
.packages
build/
*.lock
```

**Node.js:**
```
node_modules/
npm-debug.log
.env
```

**Python:**
```
__pycache__/
*.pyc
venv/
.env
```

### Branch Protection Setup

After repository is created, suggest setting up branch protection:

1. Go to repository Settings → Branches
2. Add rule for main branch:
   - Require pull request reviews (2 approvals)
   - Require status checks to pass
   - Include administrators
3. Add rule for develop branch:
   - Require pull request reviews (1 approval)
   - Require status checks to pass
   - Allow force pushes to develop

## Troubleshooting

### Git Not Installed

```
Error: Git is not installed

Please install Git first:
- Windows: https://git-scm.com/download/win
- macOS: brew install git
- Linux: sudo apt-get install git
```

### No Write Permissions

```
Error: Permission denied creating .git directory

Please check directory permissions or run with appropriate privileges.
```

### GitHub Authentication Failed

```
Warning: GitHub authentication failed

Repository initialized locally but remote creation skipped.

To authenticate:
1. Install GitHub CLI: https://cli.github.com
2. Run: gh auth login
3. Re-run @git-init or add remote manually
```
