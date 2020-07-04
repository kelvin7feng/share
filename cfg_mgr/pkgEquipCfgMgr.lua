doNameSpace("pkgEquipCfgMgr")

m_tbLevelUpCfg = m_tbLevelUpCfg or {}

function Init()
    m_tbLevelUpCfg = {}

    local dEquipId = nil
    local dLevel = nil
    for _, tbCfg in pairs(_cfg.equipLevelUp) do
        dEquipId = tbCfg.equipId
        dLevel = tbCfg.level
        if not m_tbLevelUpCfg[dEquipId] then
            m_tbLevelUpCfg[dEquipId] = {}
        end

        m_tbLevelUpCfg[dEquipId][dLevel] = tbCfg
    end
    
end

Init()

function GetEquipCfg(dId)
    return _cfg.equip[dId]
end

function IsLegalSlot(dSlotId)
    if not dSlotId or dSlotId <= 0 or dSlotId > 6 then
        return false
    end
    return true
end

function GetLevelUpCfg(dEquipId, dLevel)
    -- print("dEquipId, dLevel：", dEquipId, dLevel)
    return m_tbLevelUpCfg[dEquipId][dLevel]
end

function GetMaxLevel(dEquipId)
    return table.count(m_tbLevelUpCfg[dEquipId]) - 1
end

function GetLevelUpExp(tbConsumeEquip)
    local dExp = 0
    if not tbConsumeEquip or #tbConsumeEquip <= 0 then
        return dExp
    end

    local dValue = nil
    local tbLevelUpCfg = nil
    for _, tbConsumeInfo in ipairs(tbConsumeEquip) do
        dValue = 0
        tbLevelUpCfg = GetLevelUpCfg(tbConsumeInfo.cfgId, tbConsumeInfo.dLevel)
        if tbLevelUpCfg and tbLevelUpCfg.value > 0 then
            dValue = tbLevelUpCfg.value
        end

        dExp = dExp + dValue
    end

    return dExp
end

function CalcMaxLevel(dEquipCfgId, dCurLevel, dCurExp, dAddExp)
	
    local dMaxLevel = dCurLevel
    local dRemainingValue = dCurExp
    local tbLevelUpCfg = GetLevelUpCfg(dEquipCfgId, dCurLevel)
    if not tbLevelUpCfg then
        return dMaxLevel,dRemainingValue
    end

    local dTestExp = 0
    for i=0, dCurLevel-1 do
        tbLevelUpCfg = GetLevelUpCfg(dEquipCfgId, i)
        dTestExp = dTestExp + tbLevelUpCfg.levelUpExp
    end

    dTestExp = dTestExp + dCurExp + dAddExp
	
    -- 最大十级
    local dTopLevel = GetMaxLevel(dEquipCfgId)
    for i=0, dTopLevel-1 do
        local tbCurLevelUpCfg = GetLevelUpCfg(dEquipCfgId, i)
        if dTestExp >= tbCurLevelUpCfg.levelUpExp then
            dMaxLevel = i+1
            dTestExp = dTestExp - tbCurLevelUpCfg.levelUpExp
        else
            break
        end
    end

    if dMaxLevel > dTopLevel then
        dTestExp = 0
        dMaxLevel = dTopLevel + 1
    end
    
    return dMaxLevel, dTestExp
end