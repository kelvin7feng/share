doNameSpace("pkgAttrMgr")

m_dTotalAttr = m_dTotalAttr or 12

AttrType = {
    HP               = 1,
    ATTACK           = 2,
    DEFEND           = 3,
    CRITICAL_RATE    = 4,
    CRITICAL         = 5,
    DODGE            = 6,
    HIT_RATE         = 7,
}

DefaultAttr = {
    [AttrType.CRITICAL]          = 1,
    [AttrType.HIT_RATE]          = 100,
}

function GetDefaultAttr()
    local tbAttr = {}
    local dBaseVal = 0
    for i=1, m_dTotalAttr do
        dBaseVal = DefaultAttr[i] or 0
        table.insert(tbAttr, {finalVal = 0, baseVal = dBaseVal, abs = 0, percent = 0})
    end
    return tbAttr
end

function CalcBaseAttr(tbAttr, tbAttrList)

    tbAttr = tbAttr or GetDefaultAttr()

    local dAttr = nil
    local dUnit = nil
    for i, tbTempAttr in ipairs(tbAttrList) do
        for j=1, m_dTotalAttr do
            dAttr = tbTempAttr["attr"..j]
            dUnit = tbTempAttr["unit"..j]
            if dUnit ~= 1 then
                dAttr = dAttr * 0.01
            end
            tbAttr[j].baseVal = tbAttr[j].baseVal + dAttr
        end
    end

    return tbAttr
end

function CalcTotalAttr(tbAttr, tbAttrList)

    tbAttr = tbAttr or GetDefaultAttr()

    local dAttr = nil
    local dUnit = nil
    for i, tbTempAttr in ipairs(tbAttrList) do
        for i=1, m_dTotalAttr do
            dAttr = tbTempAttr["attr"..i]
            dUnit = tbTempAttr["unit"..i]
            if dUnit ~= 1 then
                dAttr = dAttr * 0.01
                tbAttr[i].percent = tbAttr[i].percent + dAttr
            else
                tbAttr[i].abs = tbAttr[i].abs + dAttr
            end
        end
    end

    for i=1, m_dTotalAttr do
        tbAttr[i].finalVal = tbAttr[i].baseVal + tbAttr[i].abs + tbAttr[i].baseVal * tbAttr[i].percent
    end

    return tbAttr
end
