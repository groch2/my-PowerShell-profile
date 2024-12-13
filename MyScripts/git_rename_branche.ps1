param ($oldName, $newName)
git branch -m $oldName $newName
git push origin :$oldName $newName
git push origin -u $newName
