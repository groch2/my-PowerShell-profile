# enregistrer dans un fichier la liste de toutes les branches du repo git courant, avec le commit sur lequel elles pointent
New-Variable -Name repo_name -Value (Split-Path -Path (git rev-parse --show-toplevel) -Leaf) -Visibility Private -Option Constant
New-Variable -Name repo_branches_backup_directory -Value (Join-Path $env:USERPROFILE 'Documents\git_branches_with_head_commit' $repo_name) -Visibility Private -Option Constant
if (!(Test-Path -PathType Container $repo_branches_backup_directory)) {
  New-Item -ItemType Directory -Path $repo_branches_backup_directory
}
New-Variable -Name date -Value (Get-Date -Format 'yyyy-MM-dd') -Visibility Private -Option Constant
New-Variable -Name nb_existing_backup_files  -Value ((Get-ChildItem $repo_branches_backup_directory -File -Filter "$($date)_??.txt").Count + 1) -Visibility Private -Option Constant
New-Variable -Name backup_file_name -Value "$($date)_$('{0:D2}' -f [int]$nb_existing_backup_files).txt" -Visibility Private -Option Constant
New-Variable -Name backup_file_path -Value (Join-Path $repo_branches_backup_directory $backup_file_name) -Visibility Private -Option Constant
git for-each-ref --format='%(objectname:short) %(refname:short)' refs/heads | Out-File -FilePath $backup_file_path
npp $backup_file_path
