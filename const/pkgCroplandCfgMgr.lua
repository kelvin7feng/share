doNameSpace("pkgCroplandCfgMgr")

ErrorCode = {
    CFG_ILLEGAL             = 1,
    PARAM_ILLEGAL           = 2,
    GOODS_NOT_ENOUGH        = 3,
    PLANT_ERROR             = 4,
}

LangMap = {
    [ErrorCode.CFG_ILLEGAL]             = 100001,
    [ErrorCode.PARAM_ILLEGAL]           = 100002,
    [ErrorCode.GOODS_NOT_ENOUGH]        = 100004,
    [ErrorCode.PLANT_ERROR]             = 100005,
}

State = {
    EMPTY               = 0,
    PLANTING            = 1,
    HARVEST             = 2,
}

CROPLAND_COUNT = 9

function IsLandIndexOk(dIndex)
    if not dIndex or dIndex < 1 or dIndex > CROPLAND_COUNT then
        return false
    end

    return true
end

-- 种子配置
function GetCropCfg(dId)
    return _cfg.crop[tonumber(dId)]
end

function CanHarvest(tbLandInfo)

    if not tbLandInfo then
        return
    end
    
    local dState = tbLandInfo.dState
    if dState ~= pkgCroplandCfgMgr.State.PLANTING then
        return false
    end

    local tbCropCfg = pkgCroplandCfgMgr.GetCropCfg(tbLandInfo.dId)
    if not tbCropCfg then
        return false
    end
    
    local dCfgGrowTime = tbCropCfg.growTime
    local dPlantTime = tbLandInfo.dPlantTime
    local dEndTime = dPlantTime + dCfgGrowTime
    if os.time() < dEndTime then
        return false
    end

    return true
end