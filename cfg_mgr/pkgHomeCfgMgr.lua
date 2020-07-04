doNameSpace("pkgHomeCfgMgr")

ErrorCode = {
    CFG_ILLEGAL             = 1,
    PARAM_ILLEGAL           = 2,
    LEVEL_NOT_ENOUGH        = 3,
    GOODS_NOT_ENOUGH        = 4,
}

LangMap = {
    [ErrorCode.CFG_ILLEGAL]             = 100001,
    [ErrorCode.PARAM_ILLEGAL]           = 100002,
    [ErrorCode.LEVEL_NOT_ENOUGH]        = 100003,
    [ErrorCode.GOODS_NOT_ENOUGH]        = 100004,
}

m_tbLevelUpCfg = m_tbLevelUpCfg or {}

function Init()
    m_tbLevelUpCfg = {}

    local dStar = nil
    local dLevel = nil
    for _, tbCfg in pairs(_cfg.homeLevelUp) do
        dStar = tbCfg.star
        dLevel = tbCfg.level
        if not m_tbLevelUpCfg[dStar] then
            m_tbLevelUpCfg[dStar] = {}
        end
           
        m_tbLevelUpCfg[dStar][dLevel] = tbCfg
    end
end

Init()

function GetMaxLevel(dStar)
    local dMaxLevel = 0
    if not m_tbLevelUpCfg[dStar] then
        return dMaxLevel
    end
    return table.count(m_tbLevelUpCfg[dStar]) - 1
end

function GetLevelUpCfg(dStar, dLevel)
    if not m_tbLevelUpCfg[dStar] or not m_tbLevelUpCfg[dStar][dLevel] then
        return nil
    end
    return m_tbLevelUpCfg[dStar][dLevel]
end

function GetLevelUpCost(dStar, dLevel)
    local tbCost = {}
    local tbCfg = GetLevelUpCfg(dStar, dLevel)
    if not tbCfg then
        return tbCost
    end
    for i=1, 5 do
        local dGoodsType = tbCfg["goodsType"..i]
        local dCount = tbCfg["count"..i]
		if dGoodsType > 0 and dCount > 0 then
            table.insert(tbCost,{dGoodsType, dCount})
        end
    end
    return tbCost
end

function HaveNextLevel(dStar, dLevel)
    local tbCfg = GetLevelUpCfg(dStar, dLevel+1)
    return tbCfg and true or false
end

function HaveNextStar(dStar)
    local tbCfg = GetLevelUpCfg(dStar + 1, 0)
    return tbCfg and true or false
end