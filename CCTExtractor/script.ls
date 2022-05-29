global saveFolder, settings

on enterFrame
  if not loadSettings() then return
  
  if value(getCnf(#single_file)) then
    filePath = displayOpen(new(xtra "fileio"))
    if filePath = void then return
    processFile(filePath)
  else
    processFolder(getCnf(#cct_path))
  end if
  
end

on processFolder(tPath)
  folderList = fx_FolderToList(new(xtra("FileXtra4")),tPath)
  repeat with tFile in folderList
    if tFile contains(".cct") then -- Its a valid file!
      processFile(tPath & tFile)
    end if
  end repeat
end

on processFile(tPath)
  if tPath contains(".cct") then
    
    castLib(2).fileName = tPath
    
    saveFolder = getOutputPath(tPath)
    newFolder(saveFolder)
    generateCredits
    
    repeat with tMem in castLib(2).member
      case tMem.type of  
        #field:
          handleField(tMem)
        #bitmap:
          handleImage(tMem)
        #script:
          handleScript(tMem)
        otherwise:
          -- Not Supported
      end case
    end repeat
    
  else
    alert("Invalid File.")
  end if
end

on handleScript(tMem)
  saveText(processName(tMem) & ".ls", tMem.scriptText)
end

on handleImage(tMem)
  saveImage(processName(tMem), tMem.image)
end

on handleField(tMem)
  saveText(processName(tMem), tMem.text)
end

on getOutputPath(tText)
  the itemDelimiter = "\"
  tText = tText.getProp(#item,tText.count(#item))
  the itemDelimiter = "."
  tText = tText.getProp(#item,1)
  return getCnf(#output_path) & tText & "\"
end

on processName(tMem)
  if tMem.name = EMPTY then return tMem.number
  return tMem.name
end

on newFolder(tPath)
  fxObj = new(xtra("FileXtra4"))
  if not fx_FolderExists(fxObj, tPath) then fx_FolderCreate(fxObj, tPath)
end

on saveImage(tName, tImage)
  imgXtra = new(xtra "ImgXtra")
  ix_saveImage(imgXtra, ["filename": saveFolder & tName & ".png", "image": tImage])
end

on saveText(tName, tText)
  fileio = new(xtra "fileio")
  createFile(fileio, saveFolder & tName)
  openFile(fileio, saveFolder & tName, 2)
  writeString(fileio, tText)
  closeFile(fileio)
end

on getCnf(tItem)
  return settings[tItem]
end

on loadSettings
  fileio = new(xtra("fileio"))
  openFile(fileio, the moviePath & "settings.ini", 1)
  if status(fileio) <> 0 then return false
  
  settings = parseSettings(readFile(fileio))
  closeFile(fileio)
  return true
end

on parseSettings(tText)
  tResult = [:]
  the itemDelimiter = "="
  repeat with i = 1 to tText.count(#lines)
    tLine = tText.line[i]
    if tLine.char[1] <> "#" then
      if tLine.item[2] <> "" then
        tResult.addProp(symbol(tLine.item[1]), replaceChunks(tLine.item[2],"<here>",the moviePath))
      end if
    end if
  end repeat
  return tResult
end

on generateCredits
  saveText("credits.txt", member("credits",1).text)
end

on replaceChunks(input, stringToFind, stringToInsert)
  output = ""
  findLen = stringToFind.length - 1
  repeat while input contains stringToFind
    currOffset = offset(stringToFind, input)
    output = output & input.char [1..currOffset]
    delete the last char of output
    output = output & stringToInsert
    delete input.char [1.. (currOffset + findLen)] 
  end repeat
  output = output & input
  return output
end

on exitFrame
  _movie.halt()
end
