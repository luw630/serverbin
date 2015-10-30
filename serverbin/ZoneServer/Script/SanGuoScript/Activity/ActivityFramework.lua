-- i.	登陆送礼     
-- ii.	冲级送礼	 
-- iii.	奖励翻倍     
-- iv.	限时抽将	 
-- v.	元宝基金
-- vi.	每日充值	
-- vii.	累计		
-- viii.	充值
-- ix.	充值返利

Activitymodule = 
{
	-- ActivityID = 0, 		--活动ID
	-- ActivityType = 0,		--活动类型
	-- ActivityEnable = false,
	-- ActivityTime = {date = 20150702,time = 2100},
}

function Activitymodule:new (o) 
 o = o or {} 
 setmetatable(o, self) 
 self.__index = self 
 return o 
end 

function Activitymodule:Init( actIndex )  --初始化一些必要的数据，读取相应的配置文件,活动中配置中的索引，也可以自己继承实现初始化其他的数据
	if g_ActivifyConfig == nil then
		return
	end
	local nowdate = tonumber(os.date("%Y%m%d",os.time()))	
	if g_ActivifyConfig[actIndex] ~= nil then
		self.ActivityID = g_ActivifyConfig[actIndex].ActivityID
		self.ActivityType = g_ActivifyConfig[actIndex].ActivityType
		self.ActivityEnable = g_ActivifyConfig[actIndex].ActivityEnable
		self.ActivityTime = g_ActivifyConfig[actIndex].ActivityTime
		self.ActivityName = g_ActivifyConfig[actIndex].ActivityName
		self.ActivityDataReset = false 												--数据重置

		-- if self.ActivityTime ~= nil and self.ActivityEnable == false then
		-- 	if self.ActivityTime.starttime <= nowdate and nowdate <= self.ActivityTime.endtime then
		-- 			self.ActivityEnable = true
		-- 	end
		-- end
	end
end

function Activitymodule:GetActivityIndex()
	return self.ActivityID
end

function Activitymodule:GetActivityType()
	return self.ActivityType
end

function Activitymodule:GetActivityEnable()
	return self.ActivityEnable
end

function Activitymodule:OnActivityClosed(actParam) --当活动关闭时
	--look("OnActivityClosed  "..actParam)
end

function Activitymodule:OnActivityOpened(actParam) --当活动开启时
	--look("OnActivityOpened "..actParam)
end

function Activitymodule:ResetData()
	ResetData(self.ActivityName)
end



function Activitymodule:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	--look("MyActivity OnTrigger "..self.ActivityID)
end

function Activitymodule:Getmodule(ActivityID)
	if ActivityID == self.ActivityID then
		return self
	end
	return nil
end



function Activitymodule:SaveData(datatable) --活动数据保存
	-- body
	DataServiceSaveData(self.ActivityName,datatable)
end

function Activitymodule:LoadData()   --数据读取
	local datatable = DataServiceGetData(self.ActivityName)
	if datatable == nil then
		datatable = {}
	end
	return datatable
end
