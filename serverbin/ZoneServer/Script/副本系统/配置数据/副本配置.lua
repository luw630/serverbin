NPC所带任务列表 = {
	[1] = {1},
}
--副本仓库使用的道具专用id号段
副本道具表 = {{10002,10002},{10182,10182},{10362,10362},{10542,10542},{10722,10722},{30006,30006}}
副本配置 = {
	[1] = {
		副本名字 = '华山论剑',
		描述 ='华山论剑，十年之期当至，各大名门正派又或旁门左道纷纷收到武林盟英雄帖，相邀十月十日华山峰顶，以剑论天下武学高低！众高手齐聚华山，只为争那当世第一高手的名号，却不知武林盟早已暗中埋伏，只待收网捕鱼，瓮中捉鳖。此时华山顶上一阵山摇地动，眼看武林盟阴谋得逞，山脚下早已按捺不住的各门派弟子如鱼贯一般涌上华山峰顶。',
		完成描述 = '恭喜阁下成功闯关华山论剑副本任务',
		
		显示等级限制 = 10,		
		每天最大次数 = 300,
		最大人数= 5,
		开放时间 = {
			开始 = { hour = 00, min = 00, sec = 0 }, 
			结束 = { hour = 23, min = 59, sec = 59 },
			},
		时间限制=60,
		地图组 = {
			{
				地图编号 = 73,
				跳转点 = {					
				},
				NPC列表 = {
					[1]={regionId = 73,name="吴孟达",title="仓库小二", imageId = 26,  x = 10, y = 19, dir = 5, objectType = 1, controlId = 400005,clickScript=30000},
					[2]={regionId = 73,name="受伤弟子",title="", imageId = 26,  x = 12, y = 24, dir = 5, objectType = 1, controlId = 400006,clickScript=30000},
				},
				怪物列表 = {
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 14, y = 175,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 12, y = 167,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 13, y = 159,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 12, y = 149,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 10, y = 119,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 12, y = 119,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 14, y = 119,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 18, y = 120,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟侍从', monsterId = 41, imageId = 1,  x = 21, y = 121,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟护法', monsterId = 42, imageId = 1,  x = 15, y = 60,  deadScript = 2, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '武林盟护法', monsterId = 42, imageId = 1,  x = 20, y = 60,  deadScript = 2, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '朱侠武', monsterId = 43, imageId = 1,  x = 15, y = 25,  deadScript = 3, refreshTime = -1, dir = 3, objectType = 0 },
				},
				复活点 = {regionId=73,x=15,y=22},
			},
		},
		仓库 = {
			NPC=1,
			道具={{10002,1},{10182,1}, {10362,1},{10542,1},{10722,1},{30006,1}},
		},
		初始位置列表 = {
			{ 地图编号 = 73, x = 14, y = 209 },
			{ 地图编号 = 73, x = 15, y = 209 },
			{ 地图编号 = 73, x = 16, y = 209 },
			{ 地图编号 = 73, x = 17, y = 209 },
			{ 地图编号 = 73, x = 18, y = 209 },
		},

		准备条件 = {
			等级 = 10,	--进入等级限制
			金钱 = 0,
			道具 = {{id=4024,num=1,name='英雄帖'},
				},
		},
		
		完成目标 = "击退武林盟背后主谋: %\031朱侠武",
		完成条件 = {
			怪物死亡 = { 
				[2]={name="武林盟护法",id=2,num=2},
				[3]={name="朱侠武",id=3,num=1},
			},
		},
			
		奖励 = {
			Exp = 1000,
			Money = 10000,
			ItemList = {
				{ 概率 = { 0, 20 }, 物品ID = 10010, 数量 = { 1, 1 } },
				{ 概率 = { 20,40 }, 物品ID = 10190, 数量 = { 1, 1 } },
				{ 概率 = { 40,60 }, 物品ID = 10370, 数量 = { 1, 1 } },
				{ 概率 = { 60,80 }, 物品ID = 10550, 数量 = { 1, 1 } },
				{ 概率 = { 80,100 }, 物品ID = 10730, 数量 = { 1, 1 } },
			}
		},
	},
}

副本NPC = 副本NPC or {
	--[id] : controlId - 400000
	[5]={ talk='奉武林盟主之命，在此向各位江湖朋友提供帮助，练功的必需品——药物、武器、装备、铜人应有尽有，敬请选用。#打开仓库。#暂时没有需要。#', 		
			ClickMenu=function(index)
				if index==1 then
					local sid = GetPlayerData(17)		
					local csTemp = CS_GetPlayerTemp(sid)	
					local copySceneGID = csTemp.CopySceneGID
					local copyScene = CS_GetData(copySceneGID)
					local storyhome = copyScene.Storage
					--发消息到客户端,初始化副本仓库
					SendLuaMsg(0, { ids = {4,100}, data = storyhome }, 9 )
				end
			end,
		},
	[6]={ talk='想出去吗? 啊-哈-哈-哈-哈, 给我10000块! #给就给。#我没有钱。#',
			ClickMenu=function(index) 
				if index==1 then
					local teamInfo = GetTeamInfo()
					if teamInfo ~= nil then
						local teamID = GetPlayerData(12)
						local playerSID = GetPlayerData(17)
						DeleteTeamMember(teamID, playerSID)
					end	
					CS_DoExit()
					CS_Back( playerSID )
					return
				end
			end,
		},
} 