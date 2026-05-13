# Create a git worktree adjacent to the current project, then open it in VS Code
wt() {
  # Get the feature name from the first argument
  local feature_name="$1"

  # Get the absolute path of the current project directory
  local project_dir="$(pwd)"

  # Extract the project folder name (e.g. "myapp")
  local project_name="$(basename "$project_dir")"

  # Build the path to the sibling -worktrees folder (e.g. "../myapp-worktrees")
  local worktrees_dir="$(dirname "$project_dir")/${project_name}-worktrees"

  # Create the -worktrees folder if it doesn't already exist
  mkdir -p "$worktrees_dir"

  # Full path where the new worktree will live
  local worktree_path="${worktrees_dir}/${feature_name}"

  # Create the git worktree and a new branch with the given feature name
  git worktree add -b "$feature_name" "$worktree_path"

  # Open the new worktree folder in a new VS Code window
  code --new-window "$worktree_path"
}
