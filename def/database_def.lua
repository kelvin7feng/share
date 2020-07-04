
-- 数据库名字
DATABASE_TABLE_NAME = 
{
	GLOBAL 				=  "global",
	ACCCUNT				=  "account",
	REGISTER 			=  "register",
	GAME_DATA 			=  "gamedata"
}

-- 全局配置字段
DATABASE_TABLE_GLOBAL_FIELD = 
{
	USER_ID								= "UserGlobalId",
}

-- 全局配置默认值
DATABASE_TABLE_GLOBAL_DEFALUT = 
{
	[DATABASE_TABLE_GLOBAL_FIELD.USER_ID] = 100001,
}

-- 游戏数据表名
GAME_DATA_TABLE_NAME = 
{
	USER_INFO							= "UserInfo",
	BASE_INFO							= "BaseInfo",
	BATTLE_INFO							= "BattleInfo",
	BAG_INFO							= "BagInfo",
	EQUIP_INFO							= "EquipInfo",
	HOME_INFO							= "HomeInfo",
	ACHIEVEMENT_INFO	    			= "AchievementInfo",
	CROPLAND_INFO   	    			= "CroplandInfo",
	COLLECTION_INFO   	    			= "CollectionInfo",
	SHOP_INFO   	    				= "ShopInfo",
	PET_INFO   	   		 				= "PetInfo",
	GUIDE_INFO 	   		 				= "GuideInfo",
	TASK_INFO 	   		 				= "TaskInfo",
}

-- 数据字段表
GAME_DATA_FIELD_NAME = {}

-- 用户表数据
GAME_DATA_FIELD_NAME.UserInfo = 
{
	DEVICE_ID								= "DeviceId",
	REGISTER_IP								= "RegisterIp",
	PHONE_NO								= "PhoneNo"
}

-- 游戏基础字段
GAME_DATA_FIELD_NAME.BaseInfo = 
{
	USER_ID									= "UserId",
	AVATAR									= "Avatar",
	SEX 									= "Sex",
	NAME									= "Name",
	DIAMOND 								= "Diamond",
	GOLD 									= "Gold",
	LEVEL 									= "Level",
	LAST_LOGIN_TIME							= "LastLoginTime",
}

-- 战斗数据
GAME_DATA_FIELD_NAME.BattleInfo = 
{
	CUR_CHALLENGE_TYPE							= "CurChallengeType",
	NEXT_CHALLENGE_TYPE							= "NextChallengeType",
	NORMAL_TYPE									= "NormalType",
	BOSS_TYPE									= "BossType",
	CUR_LEVEL									= "CurLevel",
	CUR_MONSTER_ID								= "CurMonsterId",
	LAST_COLLECT_TIME   						= "LastCollectTime",
}

-- 背包数据
GAME_DATA_FIELD_NAME.BagInfo = 
{

}

-- 战斗类型
BATTLE_CHALLENGE_TYPE = {
	NORMAL_TYPE 								= 1,
	BOSS_TYPE 									= 2,
	[1]			= GAME_DATA_FIELD_NAME.BattleInfo.NORMAL_TYPE,
	[2]			= GAME_DATA_FIELD_NAME.BattleInfo.BOSS_TYPE,
}

-- 数据库字段,构建该表是为了初始化玩家数据时直接引用
DATABASE_TABLE_FIELD = 
{

	[GAME_DATA_TABLE_NAME.USER_INFO]	= 
	{
		[GAME_DATA_FIELD_NAME.UserInfo.DEVICE_ID]				 = "",		-- 设备Id
		[GAME_DATA_FIELD_NAME.UserInfo.REGISTER_IP]				 = "",		-- 注册Ip	
		[GAME_DATA_FIELD_NAME.UserInfo.PHONE_NO]				 = "",		-- 电话
	},

	[GAME_DATA_TABLE_NAME.BASE_INFO]	= 
	{
		UserId									 				 = 0,		-- 玩家Id
		Avatar													 = 0,		-- 职业头像
		Sex													     = 0,		-- 性别
		Name													 = "Guest",	-- 名字
		Diamond				    								 = 0,		-- 钻石
		Gold				    								 = 5000,	-- 金币
		Level				     								 = 1,		-- 等级
		LastLoginTime										     = 0,	    -- 上次登录时间
	},

	[GAME_DATA_TABLE_NAME.BATTLE_INFO]	= 
	{
		CurLevel									 			 = 1,		-- 当前关卡
		CurMonsterId										 	 = 1,		-- 当前怪物Id
		NextChallengeType									 	 = 1,		-- 即将挑战类型
		CurChallengeType									 	 = 1,		-- 当前挑战类型
		LastCollectTime										     = 0,		-- 挂机时间
	},

	[GAME_DATA_TABLE_NAME.BAG_INFO]	= 
	{
		["1"]													 = 5000,
		["2"]													 = 100,
		["100"]													 = 1,
		["2001"]											     = 1,
	},

	[GAME_DATA_TABLE_NAME.EQUIP_INFO]	= 
	{
		tbSlot													 = {0,0,0,0,0,0},
		tbEquipList											     = {}, -- {id, cfgId, level}
	},
	
	[GAME_DATA_TABLE_NAME.HOME_INFO]	= {
		dStar													 = 0,
		dLevel													 = 0,
	},

	[GAME_DATA_TABLE_NAME.ACHIEVEMENT_INFO]	= {
		
	},

	[GAME_DATA_TABLE_NAME.CROPLAND_INFO]	= 
	{

	},

	[GAME_DATA_TABLE_NAME.COLLECTION_INFO]	= 
	{

	},

	--[[
		1:普通商店
		2:公会商店
		3:宠物商店
	--]]
	[GAME_DATA_TABLE_NAME.SHOP_INFO]	= 
	{
		[1]								= {dLastUpdateTime = 0, tbGoodsList = {}},
		[2]								= {dLastUpdateTime = 0, tbGoodsList = {}},
		[3]								= {dLastUpdateTime = 0, tbGoodsList = {}},
	},

	[GAME_DATA_TABLE_NAME.PET_INFO]	= 
	{
		tbTeam							= {0,0,0,0,0,0},
		tbPetList						= {
											--["10001"] = {slot = 1, level = 0, cfgId = "10001"},
										},  -- {id, cfgId, level}
	},

	[GAME_DATA_TABLE_NAME.GUIDE_INFO]	= 
	{
		dGuideId						= 0,
	},
	
	[GAME_DATA_TABLE_NAME.TASK_INFO]	= 
	{
		-- tbTaskList = {dId = dId, dProgress = 0, dState = pkgTaskCfgMgr.TaskState.DOING}
		tbDaily							= {dLiveness = 0, tbLivenessReward = {}, dLastUpdateTime = 0, tbTaskList = {}},
		tbWeekly						= {dLiveness = 0, tbLivenessReward = {}, dLastUpdateTime = 0, tbTaskList = {}},
	},
}
