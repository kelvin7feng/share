doNameSpace("pkgTimeMgr")

-- 每天重置时间
GAME_RESET_TIME = 6

ONE_MIN_SECONDS = 60
ONE_HOUR_SECONDS = 60*ONE_MIN_SECONDS 
ONE_DAY_SECONDS = 24*ONE_HOUR_SECONDS

local function date2TimeZero(dTime, dHour)
	if dTime <= 0 then
		return 0
	end

	local tbDate = os.date("*t", dTime)
	tbDate.hour = dHour or GAME_RESET_TIME
	tbDate.min = 0
	tbDate.sec = 0
	return os.time(tbDate)
end

--dHour超过几点算第二天
function IsTodayTime(dTime, dTimeNow, dHour)
	assert(dTime)

	dTimeNow = dTimeNow or os.time()
	
	if dTime <= 0 then
		return false
	end
	
	local tbLastTime = os.date("*t", dTime)
	local dZeroTime = os.time({year=tbLastTime.year, month=tbLastTime.month, day=tbLastTime.day, hour = dHour or 0, min=0, sec=0})
	
	if dTime >= dZeroTime then
		local dDiff = dTimeNow - dZeroTime
		return dDiff <= ONE_DAY_SECONDS
	else
		return dTimeNow <= dZeroTime
	end	
end

-- 是否为同一天
function IsSameDay(dTestTime, dServerTime)

    local bIsSame = false
    local bIsToday = IsTodayTime(dTestTime, dServerTime, GAME_RESET_TIME)
    if bIsToday then
        bIsSame = true
    end

    return bIsSame
end

-- 把数字格式化成 hh:mm:ss
function FormatTimestamp(dTime, bWithDay)
	local dHour = 3600
	local dMin = 60
	local h = dTime / 3600
	local m = dTime % 3600
	m = m/60
	s = dTime%60
	local str
	if bWithDay then
		local d = dTime/(dHour*24)
		h = math.floor(h)
		h = h%24
		str = string.format("%d%s%02d:%02d:%02d", d,"天",h, m, s)
	else
		str = string.format("%02d:%02d:%02d", h, m, s)
	end
	return str
end

--获取当前时间次日6点
function GetTomorrowStartTime(dTimeNow, dHour)

    dTimeNow = dTimeNow or os.time()
    local dZeroTime = date2TimeZero(dTimeNow, dHour)
    if dTimeNow < dZeroTime then
        return dZeroTime
    else
        return dZeroTime + ONE_DAY_SECONDS
    end
end