I created this tool to extract stuff from one or more ccts files.
You can configure the settings.ini to extract all ccts from a folder.

Feel free to edit or improve my code as long you keep the credits.

## This tool can extract:
* Images
* Sounds
* Fields
* Text
* Script (Only unprotected files)
* Flash

## Settings
* single_file = `true|false`  
  `true` will extract all ccts present in **cct_path** path.  
  `false` will request you to select an cct file to extract.  
* cct_path or output_path = `D:\folder\`  
  `<here>` will be replaced by the program path. Ex:`<here>input\`  
* sound_to_mp3 = `true|false`   
  `true` will extract as mp3 using the bitRate present in the **sound_mp3_bitrate** variable.  
  `false` will extract as wav (no quality loss).  
* sound_mp3_bitrate = `8-350`  
* swf_compressed = `true|false`  
  `true` will be zlib-compressed (Only works for Flash-Player 6 or newer)

## This tool uses the xtras below:
* Core xtras from Director MX 2004  
* FileIO  
* FileXtra4 by Kent Kersten > http://www.kblab.net/xtras  
* ImgXtra, MP3Xtra and swfExportXtra by Valentin Schmidt > https://valentin.dasdeck.com/xtras/

## How can i edit the source?
* You need **Macromedia Director MX 2004** to open the .dir file.
* You need to copy all xtras content to **C:\Program Files (x86)\Macromedia\Director MX 2004\Configuration\Xtras**
