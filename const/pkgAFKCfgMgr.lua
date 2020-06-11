doNameSpace("pkgAFKCfgMgr")

MAX_AFK_TIME = 24 * 60
MAX_AFK_SECOND = 24 * 60 * 60

m_dRandomLibCount = 5

function GetAFKCfg(dLevel)
    return _cfg.afk[dLevel]
end

function CalcScoreLevel(dLevel, dScore)
    local dScoreLevel = nil
    local tbLib = {}
    local tbLevel = {}
    local dLibIndex = 0
    for dTempScoreLevel, tbCfg in pairs(_cfg.afkRandom) do
        if dScore >= tbCfg.minScore and dScore <= tbCfg.maxScore 
            and dLevel >= tbCfg.minLevel and dLevel <= tbCfg.maxLevel then
            local dTotalProb = 0
            for i=1, m_dRandomLibCount do
                local dProb = tbCfg["prob"..i]
                if dProb and dProb > 0 then
                    dTotalProb = dTotalProb + dProb
                end
            end
            if dTotalProb > 0 then
                dLibIndex = dLibIndex + 1
                tbLib["prob"..dLibIndex] = dTotalProb
                tbLib["level"..dLibIndex] = dTempScoreLevel
            end
        end
    end

    if dLibIndex <= 0 then
        return dScoreLevel
    end

    local dKey = randomKey(tbLib)
	
    if dKey then
        dScoreLevel = tbLib["level" .. dKey]
    end
    --print("dScoreLevel ======================== ", dScoreLevel)
    return dScoreLevel
end

function RandomScoreIndex(dScoreLevelId)
    
    local tbCfgLib = _cfg.afkRandom[dScoreLevelId]
    if not tbCfgLib then
        return nil
    end
    
    local dKey = randomKey(tbCfgLib)
    local dType = nil
    local dLibId = nil
    if dKey then
        dType = tbCfgLib["type" .. dKey]
        if dType == 1 then
            dLibId = tbCfgLib["goodsLib" .. dKey]
        elseif dType == 2 then
            dLibId = tbCfgLib["equipLib" .. dKey]
        end
    end
    --print("RandomScoreIndex ================== ", dType, dLibId)
    return dType, dLibId
end

function RandomGoodsLib(dLibId)
    local tbCfgLib = _cfg.goodsLib[dLibId]
    if not tbCfgLib then
        return nil
    end
    local dKey = randomKey(tbCfgLib)
    local dGoodsId = nil
    if dKey then
        dGoodsId = tbCfgLib["goodsId" .. dKey]
    end
    return dGoodsId
end

function RandomEquipIndex(dLibId)
    local tbCfgLib = _cfg.equipLib[dLibId]
    assert(tbCfgLib)
    local dKey = randomKey(tbCfgLib)
    if dKey then
        return tbCfgLib["equipId" .. dKey]
    end
    return nil
end