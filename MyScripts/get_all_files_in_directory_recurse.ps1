# afficher récursivement la liste de tous les fichiers qui sont sous le repértoire dont le chemin est passé en paramètre, ou à défaut le répertoire courant
param ($directory)
$directory ??= '.\'
Get-ChildItem -Path $directory -Recurse -Force -File | foreach { $_.FullName }
