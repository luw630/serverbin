
FBAct =  Activitymodule:new()
FBAct:Init(ActIndex.FBThumbUp)
ActivityRegister(FBAct)
local fbData = FBAct:LoadData()	--玩家的积分排行榜
