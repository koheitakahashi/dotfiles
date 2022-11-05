function open_github_pr
  set -l current_branch (git branch --show-current)

  if test "$current_branch" = "main"
    gh repo view --web
  else if test "$current_branch" = "master"
    gh repo view --web
  else
    gh pr view --web $current_branch
  end
end
