dofile("SanGuoScript\\common\\globalType.lua")
dofile("SanGuoScript\\common\\player.lua")--
dofile("SanGuoScript\\common\\checkIn.lua")--签到
dofile("SanGuoScript\\common\\dbrpc.lua")--db操作


dofile("SanGuoScript\\common\\message.lua")

--提示字符串 统一脚本

dofile("SanGuoScript\\common\\TipConfig.lua")
dofile("SanGuoScript\\common\\TipFunction.lua")

--小型奖励的数据配置和逻辑处理模块的加载
dofile("SanGuoScript\\common\\DessertConfig.lua")
dofile("SanGuoScript\\common\\DessertLogic.lua")

--客户端的系统推送通知的处理模块
dofile("SanGuoScript\\common\\NotificationConfig.lua")
dofile("SanGuoScript\\common\\NotificationProcess.lua")

--玩家改名逻辑
dofile("SanGuoScript\\common\\ChangGameName.lua")

--任务相关逻辑
dofile("SanGuoScript\\common\\MissionData.lua")
--任务活跃度相关
dofile("SanGuoScript\\common\\MissionActivenessRewards.lua")

--玩家数据修改相回调
dofile("SanGuoScript\\common\\playerModifyCallBack.lua")

--月卡充值相关
dofile("SanGuoScript\\common\\MonthlyMembership.lua")

--玩家累计获得元宝
dofile("SanGuoScript\\common\\playerTotalDiamond.lua")
