doNameSpace("pkgAchievementCfgMgr")

AchievementType = {
    PLAYER_LEVEL                  = 1,
    HOUSE_LEVEL_UP                = 2,
    BATTLE_LEVEL                  = 3,
    HOUSE_UPGRADE                 = 4,
}

UnlockType = {
    PLAYER_LEVEL                  = 1,
}

ErrorCode = {
    CFG_ILLEGAL             = 1,
    [1]                     = "smithy_cfg_illegal",
}

le_tbAchievementMap = le_tbAchievementMap or {}
le_tbAchievementUnlockMap = le_tbAchievementUnlockMap or {}

function init()
    for _, dAchievementType in pairs(AchievementType) do
        le_tbAchievementMap[dAchievementType] = dAchievementType
    end

    local dUnlockType = nil
    for dId, tbAchievementCfg in pairs(_cfg.achievement) do
        dUnlockType = tbAchievementCfg.unlockType
        if not le_tbAchievementUnlockMap[dUnlockType] then
            le_tbAchievementUnlockMap[dUnlockType] = {}
        end

        le_tbAchievementUnlockMap[dUnlockType][dId] = tbAchievementCfg
    end
end

init()

function isAchievementDef(dAchievementType)
    if not dAchievementType then
        return false
    end

    return le_tbAchievementMap[dAchievementType] and true or false
end

function getAchievementByUnlockType(dUnlockType)
    return le_tbAchievementUnlockMap[dUnlockType]
end

function getAchievementCfg(dId)
    return _cfg.achievement[dId]
end

function getRewardCfg(dId)
    local tbReward = {}
    local tbCfg = getAchievementCfg(dId)
    for i=1, 5 do
        local dGoodsType = tbCfg["goodsType"..i]
        local dCount = tbCfg["count"..i]
		if dGoodsType > 0 and dCount > 0 then
            table.insert(tbReward,{dGoodsType, dCount})
        end
    end
    return tbReward
end

function getDefaultAchievement()
    local tbAll = {}
    for _, cfg in pairs(_cfg.achievement) do
        if cfg.default == 1 then
            tbAll[tostring(cfg.achievementType)] = {dType = cfg.achievementType, dId = cfg.id, dProcess = cfg.initProcess}
        end
    end
    
    return tbAll
end

function getDesc3(tbCfg)
    local strParam = pkgLevelCfgMgr.GetLevelCfg(tbCfg.target).name
    return pkgLanguageMgr.FormatStr(tbCfg.desc, strParam)
end

function getDesc(dId)
    local strDesc = nil
    local tbCfg = getAchievementCfg(dId)
    local dAchievementType = tbCfg.achievementType
    if pkgAchievementCfgMgr["getDesc"..dAchievementType] then
        strDesc = pkgAchievementCfgMgr["getDesc"..dAchievementType](tbCfg)
    else
        strDesc = pkgLanguageMgr.FormatStr(tbCfg.desc, tbCfg.target)
    end

    return strDesc
end