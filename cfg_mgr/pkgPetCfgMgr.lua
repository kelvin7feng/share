doNameSpace("pkgPetCfgMgr")

function GetPetCfg(dId)
    return pkgMonsterCfgMgr.GetMonsterCfg(dId)
end

function IsLegalSlot(dSlotId)
    if not dSlotId or dSlotId <= 0 or dSlotId > 6 then
        return false
    end
    return true
end
