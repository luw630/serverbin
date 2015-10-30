--[[
file:	NotificationProcess.lua
author:	Jonson
update:	2015-05-20
desc:�ȶ�������ϵͳ֪ͨ����ش���
]]--

local _NotificationConfig = NotificationConfig

function FillNotificationData()
	--���˴�ʱ�����͵�ϵͳ֪ͨ
	local curNotification = {}
	local curTime = GetServerTime()
	local notificationIndex = 1
	local dt = os.date("*t", curTime)
	for i, v in ipairs(_NotificationConfig) do
		local value = v
		local notify = false
		--�жϵ�ǰ�������Ƿ�ֻ��һ���е�ĳ����Ŵ���
		if not value.wday then
			notify = true--��������ͻ���ÿһ���ĳһ��ʱ��㴥��
		else
			for _, subV in ipairs(value.wday) do
				if dt.wday == subV then
					notify = true--��������ͽ�����Դ���
					break
				end
			end
		end
		
		--�жϸ�����֪ͨ�Ƿ�Ҫ���͵��ͻ���
		if notify then
			curNotification[notificationIndex] = {}
			curNotification[notificationIndex][1] = i--��ø����͵�ID
			curNotification[notificationIndex][2] = value[1] --��ø����ͻᴥ����ʱ��
			curNotification[notificationIndex][3] = value[2] --��ø����͵ı���
			curNotification[notificationIndex][4] = value[3]--��ø����͵�����
			notificationIndex = notificationIndex + 1
		end
	end
	
	CI_SynNotificationDataSG(curNotification)
end