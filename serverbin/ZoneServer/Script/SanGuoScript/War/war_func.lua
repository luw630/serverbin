--[[
file:	war_func.lua
author:	wk
update:	2015-08-11
desc:国战系统
]]--
--取数据
--存数据
--报名,保存队伍配置,已报名,则为修改队伍
--匹配,开战
--战斗结果
--兑换奖励--商店实现
--阵营获胜奖励结算
--排行榜
--退出
local _ceil=math.ceil

War_Time=War_Time or 0  --国战每轮的定时器id,停止定时器使用
local war_conf=war_conf
--单轮奖励配置,胜利
local war_rewardWin=war_conf.war_rewardWin
--单轮奖励配置,失败
local war_rewardFali=war_conf.war_rewardFali
--国战结束奖励配置--不是平局
local war_end_rewardConf=war_conf.war_end_rewardConf
--国战结束奖励配置--是平局
local war_end_rewardConf_draw=war_conf.war_end_rewardConf_draw
--国战报名阵营分配战力阀值
local warThreshold=war_conf.warThreshold
--参战等级限制
local lvLimit=war_conf.lvLimit

local addScore=war_conf.addScore --胜利给阵营增加积分
local winExtra =war_conf.winExtra --连胜额外奖励声望值  每次连胜奖励荣誉递增
local TurnTime=war_conf.TurnTime --每轮间隔时间
local MaxTurn=war_conf.MaxTurn --最大轮数
local robotNumPercent=war_conf.robotNumPercent



G_warData=G_warData or {}
--对应c++消息号
local WarMsg={
	joinRes=0,--报名信息
	teamList=1,--参战列表
	fight_start=2,--开战,对手信息
	fightRes=3,--结果
	fight_res_broadcast=4,--战斗结果广播
	exitWar=6,--退出
	isjoin=7,	--是否报名国战
	rank=8,  --排行榜更新
	warEnd=9, --国战结束
}

local myHeroInfo={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}-- 自己5个武将的血量,怒气,id,
local otherHeroInfo={}--对手武将信息,5*27个

--数据结构
--[[
	G_warData={
		turn=1,--第几轮
		['team1']=1  --1组平均战力
		['team2']=2	--2组平均战力
		["robotId"]=1, --机器人递增id
		["nameID"]=1, --机器人名字获取递增id
		["fightList"]={ --对战列表
				[sid1]=[sid2]
				[sid2]=[sid1]
			}
		["rank"]={ --排行榜2名
				[1]={"xxx",5,lv,icon,team}--名字 ,连胜
				[2]={"000",1}
			}
		["out"]={ --退出列表,退出再进时还进以前的组
				[sid]=1,
			}
			
		[1]={  --1组
				"score"=1,--1组积分
				"fight_all"=111,--1组总战力
				"list"={ --参战列表,匹配使用
						[1]={sid,name,fight},
						[2]={sid,name,fight},
					}
				[sid1]={ --武将信息,连胜
							"name"="一二一",
							"fight"=111,--战力
							"win"={1,2,3,4,5,6},--胜利场数,失败场数,当前连胜场数,最大连胜场数,总声望,总铜钱
							[1]={atc,hp,...skill1,skill1Lv...heroid},--16个基础属性数据(1-16)+8个技能数据(17-24)+2个血量怒气(25-26)+1武将id(27)
							[2]={heroid,atc,hp,...skill1,skill1Lv...},
							[3]={heroid,atc,hp,...skill1,skill1Lv...},
							[4]={heroid,atc,hp,...skill1,skill1Lv...},
							[5]={heroid,atc,hp,...skill1,skill1Lv...},
						}
			}
			
		[2]={  --2组
				
			}	
	}
]]



--取国战数据
local  function war_getdata()
	local worldData=GetWorldData()
	if worldData["war"]==nil then 
		worldData["war"]={}
	end
	if worldData["war"][1]==nil then  --初始化国战数据
		worldData["war"]={
			[1]={list={},},
			[2]={list={},},
			["out"]={},
			["rank"]={{"",0,0,0,0},{"",0,0,0,0}},
			["fightList"]={},
		 }
	end
	--look(worldData["war"])
	return worldData["war"]
	
end

--生成1个机器人
local function war_getOneRobot()
	local wdata=war_getdata()
	wdata.nameID= (wdata.nameID or 0)+1
	if wdata.nameID>#war_conf.name then 
		wdata.nameID=1
	end
	local robotData={}
	robotData.name=war_conf.name[wdata.nameID]
	local resTable={}
	Get_num(resTable,5,{1,#war_conf.attribute})
	for i=1,5 do
		robotData[i]=war_conf.attribute[resTable[i]]
	end
	return robotData
end

--查询报名与否,itype=1为前端请求,2为后端判断
function war_isJoin(sid,itype)
	local isjoin=2 --2未参加,1已经参加
	local team=1
	local wdata=war_getdata()
	if wdata[1][sid]~=nil  then
		isjoin=1
	elseif  wdata[2][sid]~=nil  then
		isjoin=1
		team=2
	end
	 
	 if itype==1 then
		
		CI_WarMsg(0,WarMsg.isjoin,isjoin,team)
	 end
	 return isjoin ,team
end
--报名,保存队伍配置,已报名,则为修改队伍
function war_join(sid,heroId1,heroId2,heroId3,heroId4,heroId5)
	look("war_join")
		local lv=CI_GetPlayerDataSG(0,AttType.lv)
		if lv<lvLimit then
			return
		end
	
		local wdata=war_getdata()
		local isjoin,lastteam=war_isJoin(sid,2)
		if isjoin==1 then
			CI_WarMsg(0,WarMsg.joinRes,2,lastteam)-- 已经成功,lastteam 组
			return
		end
		
		
		local joinData={}
		
		local herotable={heroId1,heroId2,heroId3,heroId4,heroId5}
		
		local allFight=0 --总战力
		for i=1,5 do
			if herotable[i]>0 then --有武将
				local joinInfo=CI_GetHeroInfo(0,herotable[i])  --取玩家武将信息 //16个属性+8个技能(id,lv)+1个战斗力
				--look(joinInfo)
				if joinInfo ==nil then 
					look("war_join error,sid="..tostring(sid))
					return 
				end
				allFight=allFight+joinInfo[25]
				joinInfo[25]=joinInfo[4] --血量.报名时为最大
				joinInfo[26]=0 --怒气,0
				joinInfo[27]=herotable[i] --武将id
				joinData[i]=joinInfo
			else --无武将
				joinData[i]={}
			end
		end
		
		
		
		joinData.name=CI_GetPlayerDataSG(0,4)
		local team=wdata.out[sid]
		local beginTeam= wdata.out[sid]
		if beginTeam==nil then --没退出过
			local maxFightStep=(wdata[1].fight_all or 0) - (wdata[2].fight_all or 0) 
			if (wdata[1].fight_all or 0)> (wdata[2].fight_all or 0) * warThreshold then  --总战力大于另一组 warThreshold 倍,直接分配
				team=2
			elseif (wdata[2].fight_all or 0)> (wdata[1].fight_all or 0) * warThreshold then 
				team=1
			else
				if math.random(1,100)<50 then 
					team=1
				else
					team=2
				end
			end	
		end
		
		wdata[team][sid]=joinData
		table.insert(wdata[team].list,{sid,CI_GetPlayerDataSG(0,4),allFight})
		wdata[team].fight_all=(wdata[team].fight_all or 0)+allFight
		
		
		CI_WarMsg(0,WarMsg.joinRes,1,team)--加入成功,num组
		--look(wdata)
end

--取阵营参战人员列表
function war_get_teamList(teamNum,beginNum)
	look("war_get_teamList")
	local wdata=war_getdata()
	local tlist={}
	if wdata[teamNum]==nil then 
		return 
	end
	local index=1
	for i=beginNum,beginNum+20 do
		if wdata[teamNum].list[i] then 
			tlist[index]=wdata[teamNum].list[i][2] or "xxx"
			index=index+1
		end	
	end
	--look(tlist)
	CI_WarMsg(0,WarMsg.teamList,teamNum,beginNum,tlist)
end

--匹配,开战,通知对手,itype=nil 时为首次
function war_fight_start(itype)
	look("war_fight_start")
	local wdata=war_getdata()
	if itype==nil then 
		wdata.turn=1
	else
		wdata.turn=wdata.turn +1
		if wdata.turn>MaxTurn then  --最后一轮,结算奖励
			look("war turn end")
			war_all_end()
			return
		end
	end
	--look(wdata)
	look("wdata.turn=="..tostring(wdata.turn))
	--定时下一轮
	War_Time=SetEvent(TurnTime, nil, "war_fight_start",1) 
	
	--添加机器人算法,使两边人数一样
	local list1={}
	local list2={}
	for k,v in pairs(wdata[1]) do
		if type (k)==type(0) and type(v)==type({}) then
			table.insert(list1,k)
		end
	end
	for k,v in pairs(wdata[2]) do
		if type (k)==type(0) and type(v)==type({}) then
			table.insert(list2,k)
		end
	end
	
	local playerNum1=#list1
	local playerNum2=#list2
	--算出需要增加的机器人人数
	if playerNum1>playerNum2 then
		if wdata.turn>1 then
			playerNum2=playerNum1-playerNum2
			playerNum1=0
		else
			playerNum2=playerNum1-playerNum2+math.ceil(playerNum1*robotNumPercent)
			playerNum1=math.ceil(playerNum1/10)
		end
	else
		if wdata.turn>1 then
				playerNum1=playerNum2-playerNum1
				playerNum2=0
		else
			playerNum1=playerNum2-playerNum1+math.ceil(playerNum2*robotNumPercent)
			playerNum2=math.ceil(playerNum2/10)
		end
	end
	--添加机器人
	local robotId=wdata.robotId or 1
	for i=robotId,playerNum1+robotId-1 do
		local robot=war_getOneRobot()
		wdata[1][i]=robot
		table.insert(list1,i)
		table.insert(wdata[1].list,{i,robot.name,0})
		robotId=robotId+1
	end
	for i=robotId,playerNum2+robotId-1 do
		local robot=war_getOneRobot()
		wdata[2][i]=robot
		table.insert(list2,i)
		table.insert(wdata[2].list,{i,robot.name,0})
		robotId=robotId+1
	end
	wdata.robotId=robotId
	
	 --生成对手列表
	 -- look(list1)
	 -- look(list2)
	local playerNum=#list1
	local resTable={}
	Get_num(resTable,playerNum,{1,playerNum})
	wdata.fightList={}
	for i=1,playerNum do
		wdata.fightList[list1[i]]=list2[resTable[i]] or 0
		wdata.fightList[list2[resTable[i]]]=list1[i] or 0
	end
	
	
	--广播开战,发送自己和对手信息
	local pData,otherData
	for k,v in pairs(wdata.fightList) do
		pData=wdata[1][k] or wdata[2][k]  --己方
		otherData=wdata[1][v] or wdata[2][v] --对手
		
		local index=1
		for i=1,5 do
			myHeroInfo[index]=pData[i][25] or 0
			myHeroInfo[index+1]=pData[i][26] or 0
			myHeroInfo[index+2]=pData[i][27] or 0
			index=index+3
		end
		for i=1,5 do
			for j=1,27 do
				otherHeroInfo[(i-1)*27+j]=otherData[i][j] or 0
			end
		end
		--look(otherHeroInfo)
		otherData.win=otherData.win or {}
		CI_WarMsg(k,WarMsg.fight_start,myHeroInfo,otherHeroInfo,wdata[1].score,wdata[2].score,otherData.name,otherData.win[3])--对手信息
	end
	look("war start end")
end

--战斗结果 res=1赢,2输;heroInfo为表,15个,(id,血量,怒气)*5
function war_fight_res(sid,res,heroInfo)
	look("war_fight_res")
	local wdata=war_getdata()
	local isjoin,team=war_isJoin(sid,2)
	if isjoin ~=1 then 
		CI_WarMsg(0,WarMsg.fightRes,100,0,0,0,0,0,0) --已结束 或 未参加
		look(" war_fight_res error ___not join__sid="..tostring(sid))
		return 
	end
	local pdata=wdata[team][sid]
	local winNum=0 --连胜数
	local rankUpdate=false
	
	if res==1 then --赢
	
		--设置最新血量怒气
		local tempHeroInfo={}
		local turn=1
		for i=1,5 do
			tempHeroInfo[heroInfo[turn]]={heroInfo[turn+1],heroInfo[turn+2]}
			turn=turn+3
		end
		local heroId=0
		for i=1,5 do
			heroId=wdata[team][sid][i][27] or 0
			if heroId>0 and tempHeroInfo[heroId] ~=nil then 
				pdata[i][25]=tempHeroInfo[heroId][1]
				pdata[i][26]=tempHeroInfo[heroId][2]
			end
		end
		pdata.win=pdata.win or {}
		--连胜处理
		pdata.win[1]=(pdata.win[1] or 0 )+1 --胜利+1
		pdata.win[3]=(pdata.win[3] or 0 )+1 --当前连胜+1
		if (pdata.win[4] or 0)<pdata.win[3] then --更新历史最大连胜
				pdata.win[4]=pdata.win[3]
		end
		local extraAward=(pdata.win[3]-1)*winExtra --额外得到声望
		pdata.win[5]=(pdata.win[5] or 0) +	war_rewardWin[1][3] +extraAward
		pdata.win[6]=(pdata.win[6] or 0) + war_rewardWin[2][3]
		
		winNum=pdata.win[3] --达到连胜
		--发奖励
		CI_AddGoods_SG(war_rewardWin[1][1], war_rewardWin[1][2], war_rewardWin[1][3]+extraAward, GoodsWay.warOfLeague)--声望
		CI_AddGoods_SG(war_rewardWin[2][1], war_rewardWin[2][2], war_rewardWin[2][3], GoodsWay.warOfLeague)
		
		--处理排行榜
		if pdata.win[3]>(wdata.rank[2][2] or 0) then --大于第二名
			local iconId=CI_GetPlayerDataSG(0,9)
			local lv=CI_GetPlayerDataSG(0,3)
			local prank={pdata.name,pdata.win[3],lv,iconId,team}
			if  pdata.win[3]>(wdata.rank[1][2] or 0) then --大于第一名
				if wdata.rank[1][1]~=pdata.name then --同一个人
					for i=1,5 do
						wdata.rank[2][i]=wdata.rank[1][i]
					end
				end
					wdata.rank[1]=prank
			else  --只大于第二名
				if wdata.rank[1][1]~=pdata.name then --同一个人
					wdata.rank[2]=prank
				end
			end
			rankUpdate=true
		end
		
		--增加阵营积分
		wdata[team].score=(wdata[team].score or 0) +addScore
	elseif res==2 then--输
		--,血量怒气复位
		for i=1,5 do
			pdata[i][25]=pdata[i][4]
			pdata[i][26]=0
		end
		pdata.win=pdata.win or {}
		--连胜处理
		winNum= pdata.win[3] or 0 --连胜被终结
		pdata.win[2]=(pdata.win[2] or 0 )+1 --失败+1
		pdata.win[3]=0 --连胜清0
		pdata.win[5]=(pdata.win[5] or 0) +	war_rewardFali[1][3]
		pdata.win[6]=(pdata.win[6] or 0) + war_rewardFali[2][3]
		--发奖励
		CI_AddGoods_SG(war_rewardFali[1][1], war_rewardFali[1][2], war_rewardFali[1][3], GoodsWay.warOfLeague)
		CI_AddGoods_SG(war_rewardFali[2][1], war_rewardFali[2][2], war_rewardFali[2][3], GoodsWay.warOfLeague)
	end
	look("war end ")
	--结果信息,x,x,胜利场数,失败场数,当前连胜场数,最大连胜场数,总声望,总灵芝
	CI_WarMsg(0,WarMsg.fightRes,res,pdata.win[1],pdata.win[2],pdata.win[3],pdata.win[4],pdata.win[5],pdata.win[6])
	
	
	--本阵营发战报消息
	for k,v in pairs (wdata[team]) do 
		if type(k)==type(0)  and type(v)==type({}) then 
			local otherdata=wdata[1][wdata.fightList[sid]] or wdata[2][wdata.fightList[sid]]
			CI_WarMsg(k,WarMsg.fight_res_broadcast,pdata.name,otherdata.name,res,winNum)--自己名字,对手名字,输赢,连胜数
		end
	end
	
	--排行更新,全阵营发送
	if rankUpdate then 
		local iconId=CI_GetPlayerDataSG(0,9)
		local lv=CI_GetPlayerDataSG(0,3)
		for k,v in pairs (wdata[1]) do 
			if type(k)==type(0)  and type(v)==type({}) then 
				war_getrank(k)
			end
		end
		for k,v in pairs (wdata[2]) do 
			if type(k)==type(0)  and type(v)==type({}) then 
				war_getrank(k)
			end
		end
	end
	
end

--发送排行榜
function war_getrank(sid)
	local wdata=war_getdata()
	CI_WarMsg(sid,WarMsg.rank,wdata.rank[1][1],wdata.rank[1][2],wdata.rank[1][3],wdata.rank[1][4],wdata.rank[1][5],
	wdata.rank[2][1],wdata.rank[2][2],wdata.rank[2][3],wdata.rank[2][4],wdata.rank[2][5])
end
--阵营获胜奖励结算
function war_all_end()
	look("war_all_end")
	local wdata=war_getdata()
	local winData=wdata[1]
	local failData =wdata[2]
	local winTeam=1
	local score1=wdata[1].score or 0
	local score2=wdata[2].score or 0
	local awards_conf=war_end_rewardConf
	if score1< score2 then 
		 winData=wdata[2]
		 failData =wdata[1]
		 winTeam=2
	elseif score1== score2 then  --平局
		 winTeam=3
		 awards_conf=war_end_rewardConf_draw
	end
	
	for k,v in pairs(winData) do
		if type(k)==type(0) and type(v)==type({}) and k>100000 then
		
			if IsOnline(k) then	
				for m,n in pairs (awards_conf) do
					look("online sid="..k)
					CI_AddGoods_SG(n[1], n[2], n[3], GoodsWay.warOfLeague,k)
				end
			else
				look("not online sid="..k)
				CI_WarMail(k,awards_conf[1][1],awards_conf[1][2],awards_conf[1][3])--不在线,发邮件
			end
			
			CI_WarMsg(k,WarMsg.warEnd,winTeam,score1,score2)
			
		end
	end
	if winTeam==3 then --平局,都有奖励
		for k,v in pairs(failData) do 
			if type(k)==type(0) and type(v)==type({}) and k>100000 then
					if IsOnline(k) then	
						for m,n in pairs (awards_conf) do
							look("online sid="..k)
							CI_AddGoods_SG(n[1], n[2], n[3], GoodsWay.warOfLeague,k)
						end
					else
						look("not online sid="..k)
						CI_WarMail(k,awards_conf[1][1],awards_conf[1][2],awards_conf[1][3])--不在线,发邮件
					end
				CI_WarMsg(k,WarMsg.warEnd,winTeam,score1,score2)
			end
		end

	else
		 for k,v in pairs(failData) do 
			if type(k)==type(0) and type(v)==type({}) and k>100000 then
				CI_WarMsg(k,WarMsg.warEnd,winTeam,score1,score2)
			end
		end
	
	end
	

	for k,v in pairs(wdata) do  --清空数据
		wdata[k]=nil
	end
end
--退出
function war_exit(sid)
	look("war_exit")
	local wdata=war_getdata()
	local isjoin,lastteam=war_isJoin(sid,2)
	if isjoin==1 then
		wdata[lastteam][sid]=nil
		wdata.out[sid]=lastteam
		for k,v in pairs(wdata[lastteam].list) do
			if sid==v[1] then 
				table.remove(wdata[lastteam].list,k)
				break
			end
		end
	end
	CI_WarMsg(0,WarMsg.exitWar)
end
-- local wdata=war_getdata()
-- look(wdata)