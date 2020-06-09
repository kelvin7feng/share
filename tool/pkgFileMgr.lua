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