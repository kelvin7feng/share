doNameSpace( "pkgStringMgr" )

function ConvertNumber2Short(dNum)
    if dNum < 10000 then
        return tostring(dNum)
    elseif dNum < 1000000 then
        local dNum = math.floor(dNum/100)/10
        return tostring(dNum).."K"
    else
        local dNum = math.floor(dNum/100000)/10
        return tostring(dNum).."M"
    end
end

function StrToTable(str)
    local len  = #str
    local left = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    local t = {}
    local start = 1
    local wordLen = 0
    local dAsciiNum = 0
    while len ~= left do
        local tmp = string.byte(str, start)
        if not tmp then
            break
        end

        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                break
            end
            i = i - 1
        end
        wordLen = i + wordLen
        local tmpString = string.sub(str, start, wordLen)
        start = start + i
        left = left + i
        t[#t + 1] = tmpString

        if i == 1 then
        	dAsciiNum = dAsciiNum + 1
        end
    end

    return t, dAsciiNum
end

function GetStringLen(str)
	local tb, dAsciiNum = StrToTable(str)
	return #tb, dAsciiNum
end

function SubString(str, dStart, dEnd)
    local tbStr = StrToTable(str)
    if not tbStr then
        return str
    end

    if dStart > dEnd then
        return
    end

    if #tbStr < dEnd then
        return
    end

    local tbResult = {}
    for i = dStart, dEnd do
        local strSingle = tbStr[i]
        table.insert(tbResult, strSingle)
    end

    local strResult = table.concat(tbResult, "")
    return strResult
end
