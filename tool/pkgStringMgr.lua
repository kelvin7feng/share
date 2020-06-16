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