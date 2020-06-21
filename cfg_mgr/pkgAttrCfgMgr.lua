doNameSpace("pkgAttrCfgMgr")

function GetAttrCfg(dId)
    return _cfg.attr[dId]
end

function GetAttrDescList(dId)
    local tbAttr = {}
    local tbCfg = GetAttrCfg(dId)
    if not tbCfg then
        return tbAttr
    end

    local dAttr = nil
    local dUnit = 0
    local dLId = 0
    for i=1,12 do
        dAttr = tbCfg["attr"..i]
        dUnit = tbCfg["unit"..i]
        dLId = pkgAttrMgr.AttrLanguage["attr"..i]
        if dAttr > 0 then
            if dUnit == 1 then
                dAttr = dAttr
                table.insert(tbAttr, string.format(pkgLanguageMgr.GetStringById(dLId),dAttr))
            else
                dAttr = dAttr * 0.01
                table.insert(tbAttr, string.format(pkgLanguageMgr.GetStringById(dLId),dAttr) .. "%")
            end
        end
    end

    return tbAttr
end

function GetLevelUpAttrDescList(dId)
    local tbAttr = {}
    local tbCfg = GetAttrCfg(dId)
    if not tbCfg then
        return tbAttr
    end
    
    local dAttr = nil
    local dUnit = 0
    local dLId = 0
    for i=1,11 do
        dAttr = tbCfg["attr"..i]
        dUnit = tbCfg["unit"..i]
        dLId = pkgAttrMgr.AttrLanguage["attr"..i]
        if dAttr > 0 then
            if dUnit == 1 then
                dAttr = dAttr
                table.insert(tbAttr, string.format(pkgLanguageMgr.GetStringById(dLId),dAttr))
            else
                dAttr = dAttr * 0.01
                table.insert(tbAttr, string.format(pkgLanguageMgr.GetStringById(dLId),dAttr) .. "%")
            end
        end
    end

    return tbAttr
end