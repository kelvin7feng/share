doNameSpace("pkgFileMgr")

function readContentFromFile(strFilePath)
	local function handler(strFilePath)
		local file = io.open(strFilePath,"r")
		if not file then
			return
		end

		local str = file:read("*a")
		io.close(file)

		return str
	end

	local bIsOk, str = pcall(handler, strFilePath)
	if not bIsOk then
		print("readContentFromFile", strFilePath, str)
		return
	end

	return str
end

function FileExists(strFilePath)
    return KG.CustomFile.IsFileExits(strFilePath)
end

local function GetPersistentPath(strFileName)
	local filePath = string.format("%s%s", __persistentDataPath, strFileName)
	if not FileExists(filePath) then
		return
	end

	return filePath
end

local function GetStreamingPath(strFileName)
	local filePath = string.format("%s%s", __streamingAssetsPath, strFileName)
	if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android then
		if not KG.CustomFile.IsAndroidAssetExist(strFileName) then
			return
		end
	elseif not FileExists(filePath) then
		return
	end
	return filePath
end

function GetAssetPath(strFileName)
    local strFilePath = GetPersistentPath(strFileName)
	if not strFilePath then
		strFilePath = GetStreamingPath(strFileName)
	end

    return strFilePath
end