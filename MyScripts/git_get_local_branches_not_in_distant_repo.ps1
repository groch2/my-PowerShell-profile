# obtenir la liste des branches du repo git actuel qui ne sont pas dans le repo disant
New-Variable -Name remote_branches_list -Value (git ls-remote origin | foreach { $_ -replace '^[0-9a-f]{40}\s+(refs/heads/)?', '' } | where { $_ -ne 'HEAD' }) -Visibility Private -Option Constant
New-Variable -Name local_branches_list -Value (git for-each-ref --format='%(refname:short)' refs/heads) -Visibility Private -Option Constant
New-Variable -Name local_not_in_remote -Value ($local_branches_list | where { $_ -notin $remote_branches_list }) -Visibility Private -Option Constant
New-Variable -Name git_branches_in_local_not_in_distant_repo_file -Value (Join-Path -Path $env:TEMP -ChildPath 'git_branches_in_local_not_in_distant_repo.txt') -Visibility Private -Option Constant
$local_not_in_remote -join "`n" | Out-File -FilePath $git_branches_in_local_not_in_distant_repo_file
npp $git_branches_in_local_not_in_distant_repo_file
