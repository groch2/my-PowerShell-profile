# afficher récursivement la liste de tous les fichiers qui sont sous le repértoire dont le chemin est passé en paramètre, ou à défaut du répertoire courant
param ($directory)
$directory = if ($directory -ne $null) { $directory } else { '.\' }
Get-ChildItem -Path $directory -Recurse | where { $_ -is [System.IO.FileInfo] } | foreach { $_.FullName }
