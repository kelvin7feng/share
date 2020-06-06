doNameSpace("pkgShopCfgMgr")

ShopType = {
    NORMAL                        = 1,
    GUILD                         = 2,
    PET                           = 3,
}

m_tbShopLibCfg = m_tbShopLibCfg or {}

function Init()
    m_tbShopLibCfg = {}

    for _, tbCfg in pairs(_cfg.shop) do
        dShopType = tbCfg.shopType
        dGroup = tbCfg.group
        if not m_tbShopLibCfg[dShopType] then
            m_tbShopLibCfg[dShopType] = {}
        end

        m_tbShopLibCfg[dShopType][dGroup] = tbCfg
    end
end

Init()

function GetShopLib(dShopType)
    if not dShopType then
        return nil
    end
    return m_tbShopLibCfg[dShopType]
end

function GetRandomItem(tbLib)
    local dKey = randomKey(tbLib)
    if not dKey then
        return nil
    end

    local tbItem = {}
    if dKey then
        tbItem.id = tbLib["goodsId" .. dKey]
        tbItem.count = tbLib["count" .. dKey]
        tbItem.price = tbLib["price" .. dKey]
        tbItem.currency = tbLib["currency" .. dKey]
        tbItem.remaining = 1
    end

    return tbItem
end