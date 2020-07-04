doNameSpace("pkgTaskCfgMgr")

TaskState = {
    DOING               = 0,
    DONE                = 1,
}

TaskType = {
    DAILY               = 1,
    WEEKLY              = 2,
}

DailyTaskType = {
    EQUIP_LEVEL_UP      = 1,
    KILL_BOSS           = 2,
    PLANT_CROP          = 3,
}

WeeklyTaskType = {
    EQUIP_LEVEL_UP      = 1,
    KILL_BOSS           = 2,
    PLANT_CROP          = 3,
}

ErrorCode = {
    CFG_ILLEGAL             = 1,
    [1]                     = "smithy_cfg_illegal",
}

LivenessState = {
    NOT_ENOUGH          = 0,
    CAN_GET             = 1,
    GOT                 = 2,
}

m_tbRewardMap = nil

local sortTaskReward = function(a, b)
	if a == nil or b == nil then 
		return false 
    end
    local cfg1 = GetLivenessReward(a.id)
    local cfg2 = GetLivenessReward(b.id)
    local dLiveness1 = a.liveness
    local dLiveness2 = b.liveness
    if dLiveness1 ~= dLiveness2 then
        return dLiveness1 < dLiveness2
    else
        return cfg1.id > cfg2.id
    end
end

function Init()
    m_tbRewardMap = {}

    local dTaskType = nil
    for _, tbCfg in pairs(_cfg.taskReward) do
        dTaskType = tbCfg.taskType
        if not m_tbRewardMap[dTaskType] then
            m_tbRewardMap[dTaskType] = {}
        end

        table.insert(m_tbRewardMap[dTaskType], tbCfg)
    end

    for dTaskType, tbTaskList in pairs(m_tbRewardMap) do
        table.sort(m_tbRewardMap[dTaskType], sortTaskReward)
    end
end

function GetLivenessRewardList(dTaskType)
    return m_tbRewardMap[dTaskType]
end

function GetLivenessCfg(dTaskType, dLiveness)
    local tbList = GetLivenessRewardList(dTaskType)
    for _, tbCfg in pairs(tbList) do
        if tbCfg.liveness == dLiveness then
            return tbCfg
        end
    end

    return nil
end

function GetLivenessReward(dId)
    return _cfg.taskReward[tonumber(dId)]
end

function GetDailyCfgById(dId)
    return GetDailyCfg()[tonumber(dId)]
end

function GetDailyCfg()
    return _cfg.dailyTask
end

function GetWeeklyCfgById(dId)
    return GetWeeklyCfg()[tonumber(dId)]
end

function GetWeeklyCfg()
    return _cfg.weeklyTask
end

function GetAllTaskCfgByType(dType)
    if dType == TaskType.DAILY then
        return GetDailyCfg()
    elseif dType == TaskType.WEEKLY then
        return GetWeeklyCfg()
    else
        return nil
    end
end

function GetTaskCfgById(dType, dId)
    local tbAllCfg = GetAllTaskCfgByType(dType)
    if tbAllCfg then
        return tbAllCfg[tonumber(dId)]
    end
    return nil
end

Init()