--三国活动lua消息定义,根据自身不同的活动分别定义
local IMessage = require("Script.SanGuoScript.NetMessage.MessageDefine")


local ACTIVITYMESSAGE = {}
ACTIVITYMESSAGE.imessagetype = IMessage.SANGUO_ACTIVITYMESSAGE
ACTIVITYMESSAGE.Head = 
{
	SANGUO_ACTIVITY_PRAYER = 1,    --元宝祈福
	SANGUO_ACTIVITY_TREASURE = 2,    --充值聚宝盆
}
ACTIVITYMESSAGE.Contents = {}

look(ACTIVITYMESSAGE)

