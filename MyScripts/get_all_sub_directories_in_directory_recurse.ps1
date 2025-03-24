# afficher récursivement la liste de tous les sous répertoires qui sont sous le repértoire dont le chemin est passé en paramètre, ou à défaut le répertoire courant
param ($directory)
$directory ??= '.\'
Get-ChildItem -Path $directory -Recurse -Force -Directory | foreach { $_.FullName }
