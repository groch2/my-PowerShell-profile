Set-Alias -Name npp -Value (Join-Path $env:Programfiles 'Notepad++\notepad++.exe')
function git-remote-prune-origin {
  git remote prune origin
}
function git-get-head-name {
  git symbolic-ref --short HEAD
}
function git-get-branches-list-short {
  git for-each-ref --format='%(refname:short)' refs/heads
}
New-Variable -Name my_scripts_directory -Value (Join-Path $env:USERPROFILE 'Documents\PowerShell\MyScripts') -Visibility Private -Option Constant
New-Variable -Name git_branches_in_local_not_in_distant_repo_file -Value (Join-Path $env:TEMP 'git_branches_in_local_not_in_distant_repo.txt') -Visibility Private -Option Constant
function git-get-local-branches-not-in-distant-repo {
  $script = Join-Path $my_scripts_directory 'git_get_local_branches_not_in_distant_repo.ps1'
  & $script
}
function git-delete-local-branches-not-in-distant-repo {
  Get-Content -Path $git_branches_in_local_not_in_distant_repo_file | foreach { git branch -d $_ }
}
function get-all-files-in-directory-recurse($directory) {
  $script = Join-Path $my_scripts_directory 'get_all_files_in_directory_recurse.ps1'
  & $script -directory $directory
}
function git-save-branches-with-current-head-commit {
  $script = Join-Path $my_scripts_directory 'git_save_branches_with_current_head_commit.ps1'
  & $script
}
function git-rename-branche($oldName, $newName) {
  $oldName ??= git-get-head-name
  # 'oldName: {0}, newName: {1}' -f ($oldName, $newName) | Write-Host
  # return
  $script = Join-Path $my_scripts_directory 'git_rename_branche.ps1'
  & $script -newName $newName -oldName $oldName
}
# function custom-command-test { Get-Date | Write-Host }
