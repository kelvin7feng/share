doNameSpace("pkgPlayerLevelCfgMgr")

function GetPlayerLevelCfg(dLevelId)
    return _cfg.playerLevelUp[dLevelId]
end

function GetLevelExp(dLevelId)
    local tbCfg = GetPlayerLevelCfg(dLevelId)
    return tbCfg.levelUpExp
end