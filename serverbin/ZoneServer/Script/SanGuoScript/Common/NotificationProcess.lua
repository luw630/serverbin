--[[
file:	NotificationProcess.lua
author:	Jonson
update:	2015-05-20
desc:萌斗三国的系统通知的相关处理
]]--

local _NotificationConfig = NotificationConfig

function FillNotificationData()
	--存了此时会推送的系统通知
	local curNotification = {}
	local curTime = GetServerTime()
	local notificationIndex = 1
	local dt = os.date("*t", curTime)
	for i, v in ipairs(_NotificationConfig) do
		local value = v
		local notify = false
		--判断当前的推送是否只在一周中的某几天才触发
		if not value.wday then
			notify = true--代表该推送会在每一天的某一个时间点触发
		else
			for _, subV in ipairs(value.wday) do
				if dt.wday == subV then
					notify = true--代表该推送今天可以触发
					break
				end
			end
		end
		
		--判断该推送通知是否要推送到客户端
		if notify then
			curNotification[notificationIndex] = {}
			curNotification[notificationIndex][1] = i--存好该推送的ID
			curNotification[notificationIndex][2] = value[1] --存好该推送会触发的时间
			curNotification[notificationIndex][3] = value[2] --存好该推送的标题
			curNotification[notificationIndex][4] = value[3]--存好该推送的内容
			notificationIndex = notificationIndex + 1
		end
	end
	
	CI_SynNotificationDataSG(curNotification)
end