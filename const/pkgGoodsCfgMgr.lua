doNameSpace("pkgGoodsCfgMgr")

m_tbCrop = m_tbCrop or {}

local sortCrop = function(a, b)
	if a == nil or b == nil then 
		return false 
    end
    local cfg1 = pkgGoodsCfgMgr.GetGoodsCfg(a.id)
    local cfg2 = pkgGoodsCfgMgr.GetGoodsCfg(b.id)
    return cfg1.id > cfg2.id
end

function GetGoodsCfg(dId)
    return _cfg.goods[tonumber(dId)]
end

function GetAllCropCfg()
    return m_tbCrop
end

function init()
    for _, tbCfg in pairs(_cfg.goods) do
        if tbCfg.goodsType == GOODS_DEF.CROP then
            table.insert(m_tbCrop, tbCfg)
        end
    end

    table.sort(m_tbCrop, sortCrop)
end

init()