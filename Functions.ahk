;Function for finding unique strings inside an array
;Used for logic in volume hotkey portion for firefox multiwindow
uniq(nameArray)
{
  hash := {}
  for i, name in nameArray
    hash[name] := null

  trimmedArray := []
  for name, dummy in hash
    trimmedArray.Insert(name)

  return trimmedArray
}