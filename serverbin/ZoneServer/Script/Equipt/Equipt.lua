PlayerIntensify = tostring("playerIntensify") --玩家强化冷却数据
PlayerVIPLevel = 5 			--玩家vip等级大于2 将不会进入cd
function OnBeginIntensify(btype,bindex,bcount) --开始装备强化，类型，位置，和次数
	-- if IsLockedEquipColumnCell(bindex) == 1 then
	-- 	rfalse("item is lock")
	-- 	TalkToPlayer(2,"item is lock")
	-- 	return
	-- end

	-- if LockEquipColumnCell(bindex,1,0) == 0 then
	-- 	rfalse("lock faile")
	-- 	TalkToPlayer(2,"lock faile")
	-- 	return
	-- end

	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		local playerIntensifyInfo = LoadPlayerTable(PlayerIntensify)
		if playerIntensifyInfo == nil then
			playerIntensifyInfo = {}
			playerIntensifyInfo.coldtime = 0
			playerIntensifyInfo.coldstarttime = 0
			playerIntensifyInfo.isIntensify = 1  	--能否强化，在强化时间满以后必须等待时间为0，否则可以强化到时间满
		end
	
		if equip.bIntensifyLevel == EquipIntensify_MaxLevel then
			rfalse(" wIndex  = "..equip.wIndex.."is max level")
			local str = MystringFormat("MAX_LEVEL")
			if str ~= nil then
				TalkToPlayer(2,str)
			end
			--LockEquipColumnCell(bindex,0,0)
			return
		end

		for i=1,bcount do
			local IntensifyInfo = GetIntensifyInfo(equip.wIndex,equip.bIntensifyLevel)
			--rfalse("GetIntensifyInfo index = "..equip.wIndex.." bIntensifyLevel = "..equip.bIntensifyLevel)

			if IntensifyInfo == nil then
				rfalse("GetIntensifyInfo index = "..equip.wIndex.." bIntensifyLevel = "..equip.bIntensifyLevel.." nil ")
				return
			end

			if checktableitem(IntensifyInfo.coldtime) == false then
				return
			end

			calculatecoldtime(playerIntensifyInfo,true)
			if playerIntensifyInfo.coldtime >= EquipIntensifyColdTime then
				--rfalse("coldtime = "..playerIntensifyInfo.coldtime.."IntensifyInfo.coldtime = "..IntensifyInfo.coldtime)
				--LockEquipColumnCell(bindex,0,0)  		--解锁装备
				SendIntensifyResult(9)
				playerIntensifyInfo.isIntensify = 0 		--大于冷却时间，停止强化
				local str = MystringFormat("COLDTIMEFAIL")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"Time not cold")
				rfalse("Time not cold ="..playerIntensifyInfo.coldtime)
				WeekReturnChargeData(PlayerIntensify,playerIntensifyInfo)
				break
			end

			if playerIntensifyInfo.isIntensify ==  0 then
				local str = MystringFormat("COLDTIMEFAIL")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"wait coldTime to 0")
				rfalse("wait coldTime to 0 cold ="..playerIntensifyInfo.coldtime)
				break
			end
	

			local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
			if playermoney < IntensifyInfo.moneyconst then
				rfalse("playermoney not enough need  "..IntensifyInfo.moneyconst)
				local str = MystringFormat("NOCOIN")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"playermoney notenough")
				--LockEquipColumnCell(bindex,0,0)
				SendIntensifyResult(1)
				break
			end
			ChangeMoney(2,-IntensifyInfo.moneyconst)	

			
			local success = LuaRandRange(1,10000)
			if checktableitem(IntensifyInfo.successrate) == false then
				return
			end

			if IntensifyInfo.successrate >= success then
				equip.bIntensifyLevel = equip.bIntensifyLevel + 1
				equip.bornAttriValue = GetAttriValue(equip.wIndex,equip.bIntensifyLevel)
				SendIntensifyResult(0)
				OnTaskCallBack(TASK_EINTENSIFY,1,0)
				CompleteAndActiveness(3)
			else
				SendIntensifyResult(2)
			end

			if equip.bIntensifyLevel == EquipIntensify_MaxLevel then
				local str = MystringFormat("MAX_LEVEL")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				rfalse(" wIndex  = "..equip.wIndex.."is max level")
				--TalkToPlayer(2,"max level")
				break
			end
			GetVipIntensifyTime(IntensifyInfo)
			playerIntensifyInfo.coldtime = playerIntensifyInfo.coldtime + IntensifyInfo.coldtime
			playerIntensifyInfo.coldstarttime = os.time()  				--计算冷却时间
			WeekReturnChargeData(PlayerIntensify,playerIntensifyInfo)
		end
		SetEquipment(btype,bindex,equip)
		--SendIntensifyResult(0)
		OnGetIntensifyInfo(btype,bindex)
	end
	--LockEquipColumnCell(bindex,0,0)
end

function GetVipIntensifyTime(IntensifyInfo) --VIP减少冷却时间
	if type(IntensifyInfo) ~= "table" then
		return 
	end
	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	if viplevel ~= nil then
		viplevel = viplevel + 1
		if viplevel > 0 then
			if VIPEquipCD ~= nil and VIPEquipCD[viplevel] ~= nil then
				local  coldtime = VIPEquipCD[viplevel] 
				IntensifyInfo.coldtime = (1 - coldtime) * IntensifyInfo.coldtime
			end
		end
	end
	--rfalse("coldtime"..IntensifyInfo.coldtime.."")
end

function calculatecoldtime(playerIntensifyInfo,bisInIntensify)  --计算冷却剩余时间,是查询冷却时间还是需要计算
	if type(playerIntensifyInfo) ~= "table" then
		return 
	end
	local coldtime = playerIntensifyInfo.coldtime
	local coldstarttime = playerIntensifyInfo.coldstarttime
	local isIntensify = playerIntensifyInfo.isIntensify
	if coldtime > 0 then
		if os.time() > coldstarttime then
			local timediff = os.time() - coldstarttime
			if timediff >= coldtime then
				timediff = 0
				coldstarttime = 0
				isIntensify = 1 			--可以强化
			else
				timediff = coldtime - timediff
				coldstarttime = os.time()
			end
			playerIntensifyInfo.coldtime = timediff
			playerIntensifyInfo.coldstarttime = coldstarttime
			playerIntensifyInfo.isIntensify = isIntensify
		end
	end

	-- if bisInIntensify == true then
	-- 	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	-- 	viplevel = viplevel + 1
	-- 	if viplevel > 0 then
	-- 		if VIPEquipCD ~= nil then
	-- 			if VIPEquipCD[viplevel] ~= nil then	
	-- 				local cdtime = VIPEquipCD[viplevel] 
	-- 				playerIntensifyInfo.coldtime = playerIntensifyInfo.coldtime * (1 - cdtime)
	-- 				rfalse("coldCDtime  = "..cdtime.." playercoldtime ="..playerIntensifyInfo.coldtime.."")
	-- 			end
	-- 		end
	-- 	end
	-- end


	if playerIntensifyInfo.coldtime >= EquipIntensifyColdTime then
		playerIntensifyInfo.isIntensify = 0 		--大于冷却时间，停止强化
	end

end

function clearcoldtime() --清除冷却时间
	local playerIntensifyInfo = LoadPlayerTable(PlayerIntensify)
	if playerIntensifyInfo == nil then
		rfalse("player no IntensifyInfodata")
		return
	end
	local coldtime = playerIntensifyInfo.coldtime / 10
	if coldtime > 0 then
		local playermoney = GetPlayerData(0,GPP_MYMONEY) --玩家非绑定游戏币
		if playermoney < coldtime then 
			rfalse("clearcoldtime money Not enough")
			local str = MystringFormat("NOGOLD")
				if str ~= nil then
					TalkToPlayer(2,str)
			end
			--TalkToPlayer(2,"clearcoldtime gold Not enough")
			SendCleanColdResult(0)   				--发送清除强化冷却失败
			SendIntensifyResult(6) 					--发送金钱不足
			return
		end
		ChangeMoney(1,-coldtime)					--非绑定
		playerIntensifyInfo.coldtime = 0
		playerIntensifyInfo.coldstarttime = 0
		playerIntensifyInfo.isIntensify = 1  	--能否强化，在强化时间满以后必须等待时间为0，否则可以强化到时间满
		WeekReturnChargeData(PlayerIntensify,playerIntensifyInfo)
		--rfalse("clearcoldtime success")
		--TalkToPlayer(2,"cost "..coldtime.." gold to clean coldtime")
		SendCleanColdResult(1)   				--发送清除强化冷却成功
		return
	end
	
end

function OnGetIntensifyInfo(btype,bindex) --获取强化描述 类型装备栏和背包 ，位置
	local playerIntensifyInfo = LoadPlayerTable(PlayerIntensify)  --读取强化冷却时间
	if playerIntensifyInfo == nil then
		playerIntensifyInfo = {}
		playerIntensifyInfo.coldtime = 0
		playerIntensifyInfo.coldstarttime = 0
		playerIntensifyInfo.isIntensify = 1  	--能否强化，在强化时间满以后必须等待时间为0，否则可以强化到时间满
	end
	calculatecoldtime(playerIntensifyInfo,false)
	WeekReturnChargeData(PlayerIntensify,playerIntensifyInfo)
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		if equip.bIntensifyLevel == EquipIntensify_MaxLevel then
			equip.bIntensifyLevel = equip.bIntensifyLevel + 1
		end
--		rfalse("levele = "..equip.bIntensifyLevel.."")
		local sendEIntensify = GetIntensifyInfo(equip.wIndex,equip.bIntensifyLevel)
		if sendEIntensify ~= nil then
			sendEIntensify.playercoldtime = playerIntensifyInfo.coldtime    --强化冷却时间
			sendEIntensify.allcoldtime = EquipIntensifyColdTime 	  --所有冷却时间
			sendEIntensify.bCanIntensify = playerIntensifyInfo.isIntensify
			--printtable(sendEIntensify)
			SendIntensifyInfo(sendEIntensify)
		end
	end
end

function GetAttriValue(itemid,IntensifyLevel)
	if EquipIntensifyValue[itemid] ~= nil then
		return EquipIntensifyValue[itemid][IntensifyLevel]
	else
		return 0
	end
end

function GetIntensifyInfo(itemid,IntensifyLevel)
	if EquipIntensify[itemid] ~= nil then
		--rfalse("size = "..GetTableLenth(EquipIntensify[itemid].successrate).."")
		local EquipIntenstable = {}
		EquipIntenstable.moneyconst = EquipIntensify[itemid].moneyconst[IntensifyLevel]
		EquipIntenstable.successrate = EquipIntensify[itemid].successrate[IntensifyLevel]
		EquipIntenstable.coldtime = EquipIntensify[itemid].coldtime[IntensifyLevel]
		EquipIntenstable.upgradrate = EquipIntensify[itemid].upgradrate[IntensifyLevel]
		EquipIntenstable.nextupgradrate = EquipIntensify[itemid].nextupgradrate[IntensifyLevel]
		if IntensifyLevel < EquipIntensify_MaxLevel then
			IntensifyLevel = IntensifyLevel + 1
		end
		EquipIntenstable.attriValue = GetAttriValue(itemid,IntensifyLevel)
		--printtable(EquipIntenstable)
		return EquipIntenstable
	end
	rfalse("EquipIntensify itemid = "..itemid.." level = "..IntensifyLevel.." nil ")
end

function checktableitem(checkitem)
	if checkitem == nil then
		rfalse("Error "..tostring(checkitem).." nil")
		return false
	else
		return true
	end
end

function GetQualitySucess(itemid,IntensifyLevel) --获取升阶成功率
	if EquiptQualitySuccess[itemid] ~= nil then
		if EquiptQualitySuccess[itemid][IntensifyLevel] ~= nil then
			return EquiptQualitySuccess[itemid][IntensifyLevel] 
		end
	end
	rfalse("QualitySucess itemid = "..itemid.." level = "..IntensifyLevel.." nil ")
end

function GetQualityInfo(itemid,IntensifyLevel)
	if EquiptQuality[itemid] ~= nil and GetQualitySucess(itemid,IntensifyLevel) ~= nil then
		local EQuality = EquiptQuality[itemid]
		EQuality.Success = GetQualitySucess(itemid,IntensifyLevel)
		if EQuality.exchangeitem == 0 then
			EQuality.needLevel = 0
		else
			local itembase = GetItemBaseData(EQuality.exchangeitem)
			if itembase == nil then
				rfalse("exchangeitem nil")
				return
			end
			EQuality.needLevel = itembase.m_Level 
		end
		return EQuality
	end
	rfalse("GetQualityInfo nil")
end

function OnGetQualityInfo(btype,bindex) --获取提升品质描述 类型装备栏和背包 ，位置
	local equip = GetEquipment(btype,bindex)
	--rfalse("OnGetQualityInfo = "..btype.."   "..equip.wIndex.."")
	if equip ~= nil and equip.wIndex ~= 0 then
		local sendEQuality = GetQualityInfo(equip.wIndex,equip.bIntensifyLevel)
		if sendEQuality ~= nil then
			SendQualityInfo(sendEQuality,sendEQuality.needmaterial)
			--rfalse("SendQualityInfo")
			return
		else
            rfalse("OnGetQualityInfo nil wIndex = "..equip.wIndex.."")
            return
        end
	end
	rfalse("OnGetQualityInfo nil  type = "..btype.." index = "..bindex)
end
--GetItemNum
function OnBeginUpgradeQuality(btype,bindex) --开始升阶
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		local EQuality = GetQualityInfo(equip.wIndex,equip.bIntensifyLevel)
		rfalse("OnBeginUpgradeQuality "..equip.wIndex.."bIntensifyLevel = "..equip.bIntensifyLevel.."" )
		if EQuality ~= nil then

			local playerlevel = GetPlayerData(0,GPP_LEVEL)  --等级判断
			if playerlevel < EQuality.needLevel then
				rfalse("playerlevel notenough")
				local str = MystringFormat("LVNOTENOUGH")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"playerlevel notenough")
				return
			end

			if GetBlankCell() < 1 then
				rfalse("UpgradeQuality:bag Cell null")
				--TalkToPlayer(2,"bag Cell notenough")
				local str = MystringFormat("BAG_NOTENOUGH")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				return
			end

			local needmaterial = GetTableLenth(EQuality.needmaterial)
			for i=1,needmaterial do
				if i % 2 > 0 then
					local maternum = GetItemNum(EQuality.needmaterial[i])
					if maternum < EQuality.needmaterial[i+1] then
						rfalse("needmaterial no enough")
						--TalkToPlayer(2,"needmaterial notenough")
						local str = MystringFormat("ITEMNOTENOUGH")
						if str ~= nil then
							TalkToPlayer(2,str)
						end
						SendQualityResult(3,0) --发送材料不足
						return
					end
				end
			end
			local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
			if playermoney < EQuality.needmoney then
				rfalse("playermoney not enough need  "..EQuality.needmoney)
				local str = MystringFormat("NOCOIN")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"playermoney notenough")
				SendQualityResult(1,0) --发送金钱不足
				return
			end

			local itembase = GetItemBaseData(EQuality.exchangeitem)
			if itembase == nil then
				rfalse("exchangeitem nil")
				return
			end

			--开始升阶
			ChangeMoney(2,-EQuality.needmoney)	
			for i=1,needmaterial do 	--删除道具
				if i % 2 > 0 then
					local maternum = GetItemNum(EQuality.needmaterial[i])
					local isdel = DeleteItem(EQuality.needmaterial[i],EQuality.needmaterial[i+1])
					if isdel == 0 then
						rfalse("DeleteItem Error")
						return
					end
				end
			end

			local success = LuaRandRange(1,10000)
			if success < EQuality.Success then  --升阶成功
				local isdelequip = DelEquipment(bindex)
				if isdelequip == 0 then
					rfalse("DelEquipment Error")
					return
				end
				local itempos = AddItem(EQuality.exchangeitem)
				if itempos >= 0 then
					RecvUseItem(itempos)
					SendQualityResult(0,EQuality.exchangeitem) --发送升阶成功
					local str = MystringFormat("SUCCESS")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"EQuality Success")
					local Qualistequit = GetEquipment(btype,bindex)
					if Qualistequit ~= nil and Qualistequit.wIndex > 0 then
						Qualistequit.starAttriType = equip.starAttriType
						Qualistequit.starAttriValue = equip.starAttriValue
						Qualistequit.bCurrentStar = equip.bCurrentStar
						-- Qualistequit.bIntensifyLevel = equip.bIntensifyLevel
						-- Qualistequit.bornAttriValue = equip.bornAttriValue
						-- Qualistequit.bornAttriType = equip.bornAttriType
						Qualistequit.MaxKeYinLevel = equip.MaxKeYinLevel
						Qualistequit.MaxKeYinAttriValue = equip.MaxKeYinAttriValue
						Qualistequit.MaxKeYinAttriType = equip.MaxKeYinAttriType
						Qualistequit.MaxKeYinLevel2 = equip.MaxKeYinLevel2
						Qualistequit.MaxKeYinAttriValue2 = equip.MaxKeYinAttriValue2
						Qualistequit.MaxKeYinAttriType2 = equip.MaxKeYinAttriType2
						Qualistequit.MaxKeYinLevel3 = equip.MaxKeYinLevel3
						Qualistequit.MaxKeYinAttriValue3 = equip.MaxKeYinAttriValue3
						Qualistequit.MaxKeYinAttriType3 = equip.MaxKeYinAttriType3
						local propertyid = 0
						local propertyvalue = 0
						for i=1,6 do
							propertyid,propertyvalue = GetJDingProperty(i-1,equip,propertyid,propertyvalue)
							SetJDingProperty(i-1,Qualistequit,propertyid,propertyvalue)
						end
						SetEquipment(btype,bindex,Qualistequit)
					else
						rfalse("OnBeginUpgradeQuality:GetEquipment Faile")
					end
				end
				OnTaskCallBack(TASK_EQUALITY,1,0)
			else
				SendQualityResult(2,-1) --发送升阶失败几率
				rfalse("QualityEquipt Faile")
			end
		end
	end
end

function OnRecvBeginRefineStar(btype,bindex,bcount) --开始升星
	local playerlevel = GetPlayerData(0,GPP_LEVEL) --玩家等级
	if playerlevel < PLAYERLEVELLIMIT then
		rfalse("playerlevel = "..playerlevel)
		local str = MystringFormat("LVNOTENOUGH")
		TalkToPlayer(2,str)
		return
	end
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		local StarInfo = GetRefineStarInfo(equip.wIndex,equip.bCurrentStar)
		for i=1,bcount do
			if StarInfo ~= nil then
				local maternum = GetItemNum(StarInfo.needmaterialid)
				if maternum < StarInfo.needmaterialnum then
					rfalse("RefineStar:needmaterial no enough itemid = "..StarInfo.needmaterialid)
					local str = MystringFormat("ITEMNOTENOUGH")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"needmaterial notenough")
					SendRiseStarResult(3) --发送材料不足
					return
				end

				local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
				if playermoney < StarInfo.moneyconst then
					rfalse("RefineStar:playermoney not enough need  "..StarInfo.moneyconst)
					local str = MystringFormat("NOCOIN")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"playermoney notenough")
					SendRiseStarResult(1) --发送金钱不足
					return
				end

				if equip.bCurrentStar >= StarInfo.MaxStar then
					local str = MystringFormat("MAX_LEVEL")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"MaxStar")
					rfalse("MaxStar = "..StarInfo.MaxStar)
					SendRiseStarResult(4) --发送升星已满
					return
				end

				--开始升星
				ChangeMoney(2,-StarInfo.moneyconst)	 	--扣钱
				local isdel = DeleteItem(StarInfo.needmaterialid,StarInfo.needmaterialnum) --删除道具
				if isdel == 0 then
					rfalse("DeleteItem Error")
					return
				end

				local success = LuaRandRange(1,10000)
				if success < StarInfo.successrate then  --升星成功
					equip.starAttriType = StarInfo.AddPropertyID
					equip.starAttriValue = StarInfo.RefineStarValue
					equip.bCurrentStar = equip.bCurrentStar + 1
					SetEquipment(btype,bindex,equip)
					SendRiseStarResult(0) --发送升星成功
					OnGetRefineStarInfo(btype,bindex) --推送装备升星消息到客户端
					local str = MystringFormat("SUCCESS")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"RiseStar success")
					rfalse("RiseStar success")
					OnTaskCallBack(TASK_ERISE,1,0)
					CompleteAndActiveness(4)
				else
					SendRiseStarResult(2) --发送升星失败
					local str = MystringFormat("FAILURE")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"RiseStar Faile")
					rfalse("RiseStar Faile")
				end
			end
			StarInfo = GetRefineStarInfo(equip.wIndex,equip.bCurrentStar)
		end
	end
end

function GetRefineStarInfo(equiptid,starlevel) --取得装备升星信息
	local RefineStarInfo = nil
	--rfalse("starlevel = "..starlevel.."")
	if EquipRefineStarInfo[equiptid] ~= nil then
		if starlevel + 1 <= EquipRefineStarInfo[equiptid].MaxStar then
			starlevel = starlevel + 1
		end	
		RefineStarInfo = {}
		RefineStarInfo.AddPropertyID = EquipRefineStarInfo[equiptid].AddPropertyID 		--属性ID
		RefineStarInfo.needmaterialid = EquipRefineStarInfo[equiptid].needmaterialid 	--需求材料ID
		RefineStarInfo.needmaterialnum = EquipRefineStarInfo[equiptid].needmaterialnum[starlevel] --需求材料数量
		RefineStarInfo.RefineStarValue = EquipRefineStarInfo[equiptid].RefineStarValue[starlevel] --属性值
		RefineStarInfo.moneyconst = EquipRefineStarInfo[equiptid].moneyconst[starlevel] --银币花费
		RefineStarInfo.successrate = EquipRefineStarInfo[equiptid].successrate[starlevel] --成功率
		RefineStarInfo.MaxStar = EquipRefineStarInfo[equiptid].MaxStar --最大升星数
		--
	end
	return RefineStarInfo
end

function OnGetRefineStarInfo(btype,bindex) --客户端请求升星信息
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		local StarInfo = GetRefineStarInfo(equip.wIndex,equip.bCurrentStar)
		if StarInfo ~= nil then
			rfalse("starlevel = "..StarInfo.RefineStarValue.."")
			if SendRiseStarInfo(StarInfo) == 0 then
				rfalse("SendRiseStarInfo Faile")
			end
			return
		end
	end
	rfalse("OnGetRefineStarInfo Faile btype ="..btype.." bindex = "..bindex)
end


function OnEquiptKeYinInit(btype,bindex)  --刻印属性初始化
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		if equip.MaxKeYinAttriType == 0 and equip.MaxKeYinAttriType2 == 0 and equip.MaxKeYinAttriType3 == 0 then --未初始化
			local equipkeyin = GetEquiptKeYinProperty(equip.wIndex)
			local equipdate = GetEquiptKeYinDate(1)
			if equipkeyin ~= nil and equipdate ~= nil then
				equip.MaxKeYinAttriType = equipkeyin[1]
				equip.MaxKeYinAttriType2 =  equipkeyin[2]
				equip.MaxKeYinAttriType3 =  equipkeyin[3]
				equip.MaxKeYinAttriValue = equipdate.PropertyValue
				equip.MaxKeYinAttriValue2 = equipdate.PropertyValue
				equip.MaxKeYinAttriValue3 = equipdate.PropertyValue
				equip.MaxKeYinLevel = 1
				equip.MaxKeYinLevel2 = 1
				equip.MaxKeYinLevel3 = 1
				rfalse("MaxKeYinAttriType = "..equipkeyin[1].."   "..equipkeyin[2].."   "..equipkeyin[3].."")
				SetEquipment(btype,bindex,equip)
				return
			end
		end
	end
end

function OnGetEquiptKeYinInfo( btype,bindex,bPropertyIndex) --请求刻印相关描述信息
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		-- if equip.MaxKeYinAttriType == 0 and equip.MaxKeYinAttriType2 == 0 and equip.MaxKeYinAttriType3 == 0 then --未初始化
		-- 	OnEquiptKeYinInit(btype,bindex)
		-- end
		local level = 0
		if bPropertyIndex == 0 then
			level = equip.MaxKeYinLevel
		elseif bPropertyIndex == 1 then
			level = equip.MaxKeYinLevel2
		elseif bPropertyIndex == 2 then
			level = equip.MaxKeYinLevel3
		end



		--if level > 0 then
		local equipdate = GetEquiptKeYinDate(level+1)
		if equipdate ~= nil then
			SendEquiptKeYinInfo(equipdate)
		end
		--end
	end
end

function GetEquiptKeYinProperty(wIndex)
	if EquipKeYingInit ~= nil then
		if EquipKeYingInit[wIndex] ~= nil then
			return EquipKeYingInit[wIndex]
		end
	end
	return nil
end

function GetEquiptKeYinPropertyIndex(wIndex,bPropertyIndex)
	local equipkeyin = GetEquiptKeYinProperty(wIndex)
	if equipkeyin ~= nil then
		if equipkeyin[bPropertyIndex+ 1] ~= nil then
			return equipkeyin[bPropertyIndex+ 1]
		end
	end
	return nil
end

function GetEquiptKeYinDate(wlevel )
	 if EquipKeYingProperty ~= nil then
	 	local kyproperty = {}
	 	kyproperty.moneyconst = EquipKeYingProperty.moneyconst[wlevel]
	 	kyproperty.successrate = EquipKeYingProperty.successrate[wlevel]
	 	kyproperty.needmaterial = EquipKeYingProperty.needmaterial[wlevel]
	 	kyproperty.needmaterialnum = EquipKeYingProperty.needmaterialnum[wlevel]
	 	kyproperty.PropertyValue = EquipKeYingProperty.PropertyValue[wlevel]
	 	return kyproperty
	 end
	 return nil
end

function OnBeginKeYin(btype,bindex,bPropertyIndex ) --开始装备刻印
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		-- if equip.MaxKeYinAttriType == 0 and equip.MaxKeYinAttriType2 == 0 and equip.MaxKeYinAttriType3 == 0 then --未初始化
		-- 	rfalse("Equipt KeYin nil")
		-- 	OnEquiptKeYinInit(btype,bindex)
		-- 	return
		-- end
		--OnSendEquipKeYinData(equip.wIndex)
		local level = 0
		if bPropertyIndex == 0 then
			level = equip.MaxKeYinLevel
		elseif bPropertyIndex == 1 then
			level = equip.MaxKeYinLevel2
		elseif bPropertyIndex == 2 then
			level = equip.MaxKeYinLevel3
		end

		--if level > 0 then
			local equipdate = GetEquiptKeYinDate(level+1)
			if equipdate ~= nil then
				local maternum = GetItemNum(equipdate.needmaterial)  --检测材料数量
				if maternum < equipdate.needmaterialnum then
					rfalse("OnBeginKeYin:needmaterial no enough itemid = "..equipdate.needmaterial)
					local str = MystringFormat("ITEMNOTENOUGH")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"needmaterial notenough")
					SendKeYinResult(1)   --发送刻印失败
					return
				end

				local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
				if playermoney < equipdate.moneyconst then
					rfalse("OnBeginKeYin:playermoney not enough need  "..equipdate.moneyconst)
					local str = MystringFormat("NOCOIN")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"playermoney notenough")
					SendKeYinResult(1)   --发送刻印失败
					return
				end

				if level >= EquipKeYing_MaxLevel then
					local str = MystringFormat("MAX_LEVEL")
					if str ~= nil then
						TalkToPlayer(2,str)
					end
					--TalkToPlayer(2,"MaxStar")
					rfalse("OnBeginKeYin : MaxStar = "..level)
					SendKeYinResult(1)   --发送刻印失败
					return
				end

				--开始刻印
				ChangeMoney(2,-equipdate.moneyconst)	 	--扣钱
				local isdel = DeleteItem(equipdate.needmaterial,equipdate.needmaterialnum) --删除道具
				if isdel == 0 then
					rfalse("DeleteItem Error")
					return
				end

				local success = LuaRandRange(1,10000)
				if success < equipdate.successrate then  --刻印点亮成功
					--if level + 1 <= EquipKeYing_MaxLevel then   --得到下一等级的刻印数据
					level = level + 1
					equipdate = GetEquiptKeYinDate(level)
					local  PropertyIndex = GetEquiptKeYinPropertyIndex(equip.wIndex,bPropertyIndex)
					local initpropertyid = false
					if equipdate ~= nil then
						if level == 1 then  --
							initpropertyid = true
						end

						if bPropertyIndex == 0 then
							equip.MaxKeYinLevel = level
							equip.MaxKeYinAttriValue = equipdate.PropertyValue
							if initpropertyid == true then
								equip.MaxKeYinAttriType = PropertyIndex
							end
						elseif bPropertyIndex == 1 then
							equip.MaxKeYinLevel2 = level						
						local str = MystringFormat("SUCCESS")
						if str ~= nil then
							TalkToPlayer(2,str)
						end
							equip.MaxKeYinAttriValue2 = equipdate.PropertyValue
							if initpropertyid == true then
								equip.MaxKeYinAttriType2 = PropertyIndex
							end
						elseif bPropertyIndex == 2 then
							equip.MaxKeYinLevel3 = level
							equip.MaxKeYinAttriValue3 = equipdate.PropertyValue
							if initpropertyid == true then
								equip.MaxKeYinAttriType3 = PropertyIndex
							end
						end

						SetEquipment(btype,bindex,equip)
						local str = MystringFormat("SUCCESS")
						if str ~= nil then
						    TalkToPlayer(2,str)
						end
						--TalkToPlayer(2,"KeYinSuccess")
						rfalse("OnBeginKeYin : Success ")
						SendKeYinResult(0)   --发送刻印成功
						OnTaskCallBack(TASK_EKEYIN,1,0)
						CompleteAndActiveness(5)
						return
					end
				else
					--TalkToPlayer(2,"KeYinFaile")
					local str = MystringFormat("FAILURE")
					if str ~= nil then
					    TalkToPlayer(2,str)
					end
					rfalse("OnBeginKeYin : Faile ")
					SendKeYinResult(1)   --发送刻印失败
				end
			end
		--end
	end
end

function OnGetKeYinChangeData(btype,bindex,bPropertyIndex)
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		local level = 0
		if bPropertyIndex == 0 then
			level = equip.MaxKeYinLevel
		elseif bPropertyIndex == 1 then
			level = equip.MaxKeYinLevel2
		elseif bPropertyIndex == 2 then
			level = equip.MaxKeYinLevel3
		end

		if level > 0 then
			local KeYinProperty = GetEquiptKeYinProperty(equip.wIndex)
			local ChangeData = GetKeyinChangeData(level)
			if KeYinProperty ~= nil and ChangeData ~= nil then
				SendKeYinChangeData(KeYinProperty,ChangeData)
			end
		end
	end

end

function GetKeyinChangeData(wlevel)
	if EquipKeYingChange ~= nil then
		local ChangeData = {}
		ChangeData.moneyconst = EquipKeYingChange.moneyconst[wlevel]
		ChangeData.itemchange = EquipKeYingChange.itemchange[wlevel]
		ChangeData.itemchangenum = EquipKeYingChange.itemchangenum[wlevel]
		return ChangeData
	end
	return nil
end

function OnBeginKeYinChange(btype,bindex,bChangeType,bPropertyIndex,bTargetIndex) --装备刻印转换
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		-- if equip.MaxKeYinAttriType == 0 and equip.MaxKeYinAttriType2 == 0 and equip.MaxKeYinAttriType3 == 0 then --未初始化
		-- 	rfalse("Equipt KeYin nil")
		-- 	return
		-- end
		--OnSendEquipKeYinData(equip.wIndex)
		local level = 0
		if bPropertyIndex == 0 then
			level = equip.MaxKeYinLevel
		elseif bPropertyIndex == 1 then
			level = equip.MaxKeYinLevel2
		elseif bPropertyIndex == 2 then
			level = equip.MaxKeYinLevel3
		end

		if level == 0 then
			rfalse("OnBeginKeYinChange Error")
			return
		end

		local KeYinchangedata = GetKeyinChangeData(level)
		local KeYinProperty = GetEquiptKeYinProperty(equip.wIndex)
		if KeYinchangedata == nil  or KeYinProperty == nil then
			rfalse("GetKeyinChangeData Error")
			return
		end
		if bChangeType == 0 then --道具转换
			local maternum = GetItemNum(KeYinchangedata.itemchange)  --检测材料数量
			if maternum < KeYinchangedata.itemchangenum then
				rfalse("OnBeginKeYinChange:needmaterial no enough itemid = "..KeYinchangedata.itemchange)
				--TalkToPlayer(2,"needmaterial notenough")
				local str = MystringFormat("ITEMNOTENOUGH")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				return
			end
			local isdel = DeleteItem(KeYinchangedata.itemchange,KeYinchangedata.itemchangenum) --删除道具
			if isdel == 0 then
				rfalse("DeleteItem Error")
				return
			end
		elseif bChangeType == 1 then --银币转换
			local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
			if playermoney < KeYinchangedata.moneyconst then
				rfalse("OnBeginKeYinChange:playermoney not enough need  "..KeYinchangedata.moneyconst)
				local str = MystringFormat("NOCOIN")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"playermoney notenough")
				return
			end
			ChangeMoney(2,-KeYinchangedata.moneyconst)	 	--扣钱
		else
			return
		end

		local bTargetProperty = 0
		if KeYinProperty[bTargetIndex+1] ~= nil then
			bTargetProperty = KeYinProperty[bTargetIndex+1]
		end
		-- if bTargetIndex == 0 then
		-- 	bTargetProperty = equip.MaxKeYinAttriType
		-- elseif bTargetIndex == 1 then
		-- 	bTargetProperty = equip.MaxKeYinAttriType2
		-- elseif bTargetIndex == 2 then
		-- 	bTargetProperty = equip.MaxKeYinAttriType3
		-- end

		if bPropertyIndex == 0 then
			equip.MaxKeYinAttriType = bTargetProperty
		elseif bPropertyIndex == 1 then
			equip.MaxKeYinAttriType2 = bTargetProperty
		elseif bPropertyIndex == 2 then
			equip.MaxKeYinAttriType3 = bTargetProperty
		end

		if bChangeType == 1 then --银币转换可能掉级
			local changelevel = GetKeYinChangeLevel(level)
			if changelevel >= level then
				level = 1
			else
				level = level - changelevel
			end

			if bPropertyIndex == 0 then
				equip.MaxKeYinLevel = level
			elseif bPropertyIndex == 1 then
				equip.MaxKeYinLevel2 = level
			elseif bPropertyIndex == 2 then
				equip.MaxKeYinLevel3 = level
			end
		end
		SetEquipment(btype,bindex,equip)
		rfalse("OnBeginKeYinChange: success")
		TalkToPlayer(2,"success")
	end
end

function GetKeYinChangeLevel(wlevel)------！！！！！！！！！！！！！！！！！！掉不掉级！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
	return 0
end


function OnBeginJDing(btype,bindex,bJDingIndex,bIsLock) --开始鉴定，鉴定索引,是否加锁
	
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		if equip.bJDingAttriNum == 0 then
			equip.bJDingAttriNum = EquipJDing_OpenProPertyNum
		end

		if bJDingIndex >= EquipJDing_MaxProPertyNum then
			rfalse("OnBeginJDing:bJDingIndex = "..bJDingIndex.." Error ")
			return
		end

		
		local propertyid = 0
		local propertyvalue = 0
		propertyid,propertyvalue = GetJDingProperty(bJDingIndex,equip,propertyid,propertyvalue)
		--rfalse("id = "..propertyid.."value = "..propertyvalue.."")

		if bIsLock == 1 then --锁定检测是否已经有鉴定属性
			if propertyid == 0 and propertyvalue == 0 then
				rfalse("OnBeginJDing:LockError propertyid == 0")
				return
			end
		end

		local maternum = GetItemNum(EquipJDing_ItemID)  --检测材料数量
		if maternum < GetJDingItemNum(equip.grade) then  --鉴定道具数量
			rfalse("OnBeginJDing:needmaterial no enough itemid = "..EquipJDing_ItemID)
			local str = MystringFormat("ITEMNOTENOUGH")
			if str ~= nil then
				TalkToPlayer(2,str)
			end
			--TalkToPlayer(2,"needmaterial notenough")
			return
		end

		local isdel = DeleteItem(EquipJDing_ItemID,GetJDingItemNum(equip.grade)) --删除鉴定道具
		if isdel == 0 then
			rfalse("DeleteItem Error")
			return
		end

		if bIsLock == 1 then  --锁定随机属性以及值,检测锁定道具,需要检测是否已经有
			local lockmaternum = GetItemNum(EquipJDing_LockItemID)  --检测材料数量
			if lockmaternum < GetJDinglockItemNum(equip.grade) then   --锁定鉴定道具数量
				rfalse("OnBeginJDing:needlockmaterial no enough itemid = "..EquipJDing_ItemID)
				local str = MystringFormat("ITEMNOTENOUGH")
				if str ~= nil then
					TalkToPlayer(2,str)
				end
				--TalkToPlayer(2,"needmaterial notenough")
				return
			end
			local isdel = DeleteItem(EquipJDing_LockItemID,GetJDinglockItemNum(equip.grade)) --删除锁定道具
			if isdel == 0 then
				rfalse("DeleteItem Error")
				return
			end
		end


		if bIsLock == 0 then --随机抽取属性ID
			propertyid = GetEquiptJDingProperty(equip.wIndex)
		end
		propertyvalue = GetJDingPropertyValue(propertyid,propertyvalue,equip.grade,bIsLock)
		local jdcolor = GetJdingColor(propertyid,propertyvalue,equip.grade)
		SendJDingResult(bJDingIndex,propertyid,propertyvalue,jdcolor)
		SetJDingProperty(bJDingIndex,equip,propertyid,propertyvalue)
		SetEquipment(btype,bindex,equip)
		OnGetEquipJDingInfo(btype,bindex) --把下次鉴定所需要的信息推送到客户端
		OnTaskCallBack(TASK_EJDING,1,0)
		--rfalse("OnBeginJDing:Success")
	end
end


function SendJDingResult(bJDingIndex,bPropertyID,wvalue,color)
	--rfalse("SendJDingResult = "..bJDingIndex.." bPropertyID = "..bPropertyID.." wvalue = "..wvalue.."")
	local JDingResult = {}
	JDingResult.bPropertyIndex = bJDingIndex
	JDingResult.bPropertyID = bPropertyID
	JDingResult.wvalue = wvalue
	JDingResult.color = color
	SendEquipJDingResult(JDingResult)
end

function GetJDingItemNum(bEquipgrade) --品质 获取鉴定所需道具数量
	return bEquipgrade
end


function GetJDingItemNum(bEquipgrade) --品质 获取鉴定所需道具数量！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
	return 1
end

function GetJDinglockItemNum( bEquipgrade ) --获取鉴定锁定道具数量
	return 1
end

function GetJDingPropertyValue(bPropertyID,wcurrentvalue,bEquipgrade,bIsLock) --获取鉴定相关的值 属性ID，当前属性值,装备品质,,是否加锁
    -- local jdtotal = {959,0,160,160,160,160,83,83,83,83,83,83}
	local jdmax = (1+bEquipgrade)*bEquipgrade/2*(EquipJDingTotal[bPropertyID +1 ]/55)
	local jdmin = (1+bEquipgrade-1)*(bEquipgrade-1)/2*(EquipJDingTotal[bPropertyID + 1]/55)/2+1
	if bIsLock == 0 then
	  return LuaRandRange(jdmin,jdmax*0.8)
	else 
	  return LuaRandRange(jdmin,jdmax)
	end
end

function GetJdingColor(bPropertyID,wcurrentvalue,bEquipgrade)  --获取鉴定后的鉴定条上面颜色
	local jdpercenttemp = wcurrentvalue/((1+bEquipgrade)*bEquipgrade/2*(EquipJDingTotal[bPropertyID + 1]/55))
	local jdpercent = math.ceil(jdpercenttemp*100)
	local jdcolor = 1
	if jdpercent > 89 then
		jdcolor = 5
	elseif jdpercent > 69 and jdpercent <90 then
	    jdcolor = 4
	elseif jdpercent > 49 and jdpercent <70 then
	    jdcolor = 3
	elseif jdpercent > 29 and jdpercent <50 then
	    jdcolor = 2
	end
	return jdcolor	
end

function GetJDingProperty(bJDingIndex,equip,propertyid,propertyvalue) --获取鉴定索引相关数据
	if bJDingIndex == 0 then
		propertyid = equip.MaxJDingAttriType
		propertyvalue = equip.MaxJDingAttriValue
	elseif bJDingIndex == 1 then
		propertyid = equip.MaxJDingAttriType2
		propertyvalue = equip.MaxJDingAttriValue2
	elseif bJDingIndex == 2 then
		propertyid = equip.MaxJDingAttriType3
		propertyvalue = equip.MaxJDingAttriValue3
	elseif bJDingIndex == 3 then
		propertyid = equip.MaxJDingAttriType4
		propertyvalue = equip.MaxJDingAttriValue4
	elseif bJDingIndex == 4 then
		propertyid = equip.MaxJDingAttriType5
		propertyvalue = equip.MaxJDingAttriValue5
	elseif bJDingIndex == 5 then
		propertyid = equip.MaxJDingAttriType6
		propertyvalue = equip.MaxJDingAttriValue6
	end
	return propertyid,propertyvalue
end

function SetJDingProperty(bJDingIndex,equip,propertyid,propertyvalue) --设置鉴定索引相关数据
	if bJDingIndex == 0 then
		equip.MaxJDingAttriType = propertyid 
		equip.MaxJDingAttriValue = propertyvalue
	elseif bJDingIndex == 1 then
		equip.MaxJDingAttriType2 = propertyid 
		equip.MaxJDingAttriValue2 = propertyvalue
	elseif bJDingIndex == 2 then
	    equip.MaxJDingAttriType3 = propertyid 
		equip.MaxJDingAttriValue3 = propertyvalue
	elseif bJDingIndex == 3 then
		equip.MaxJDingAttriType4 = propertyid 
		equip.MaxJDingAttriValue4 = propertyvalue
	elseif bJDingIndex == 4 then
		equip.MaxJDingAttriType5 = propertyid 
		equip.MaxJDingAttriValue5 = propertyvalue
	elseif bJDingIndex == 5 then
		equip.MaxJDingAttriType6 = propertyid 
		equip.MaxJDingAttriValue6 = propertyvalue
	end
end

function GetEquiptJDingProperty(wIndex) --获取装备的随机鉴定属性
	local groupps = 0    					--分组ID
	if EquipJDing_Init ~= nil then
		for k,v in pairs(EquipJDing_Init) do
			for i,j in pairs(v) do
				if j == wIndex then
					groupps = k 
					break
				end
			end
		end

		if groupps > 0 then
			if EquipJDingTable[groupps] ~= nil then
				local lenth = GetTableLenth(EquipJDingTable[groupps])
				local radm = LuaRandRange(1,lenth)
				local JDingTable = EquipJDingTable[groupps]
				if JDingTable[radm] ~= nil then
					return JDingTable[radm]
				end
			end
		end
	end
	rfalse("GetEquiptJDingProperty nil wIndex = "..wIndex.."")
	return nil
end

function OnGetNewEquipInit() --新增加装备的一些属性在这里增加

end



function OnGetEquipJDingInfo(btype,bindex)  --客户端请求装备鉴定数据
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		if equip.bJDingAttriNum == 0 then
			equip.bJDingAttriNum = EquipJDing_OpenProPertyNum
			SetEquipment(btype,bindex,equip)
		end
		local EquipJDingInfo = {}
		EquipJDingInfo.dmaterialid = EquipJDing_ItemID   --鉴定材料
		EquipJDingInfo.dlockmaterialid = EquipJDing_LockItemID  --锁定鉴定材料
		EquipJDingInfo.dmaterialnum = GetJDingItemNum(equip.grade)     --鉴定材料数量
		EquipJDingInfo.dlockmaterialnum = GetJDinglockItemNum(equip.grade)   --锁定鉴定材料数量
		SendEquipJDingInfo(EquipJDingInfo)
	end
end

function OnGetEquipJDingColor(btype,bindex) --发给客户端鉴定的颜色
	local equip = GetEquipment(btype,bindex)
	if equip ~= nil and equip.wIndex ~= 0 then
		if equip.bJDingAttriNum == 0 then
			equip.bJDingAttriNum = EquipJDing_OpenProPertyNum
			SetEquipment(btype,bindex,equip)
		end
		local equipcolor = {}
		local propertyid,propertyvalue
		for i=1,6 do
			propertyid,propertyvalue = GetJDingProperty(i-1,equip,propertyid,propertyvalue)
			equipcolor[i] = GetJdingColor(propertyid,propertyvalue,equip.grade)
		end
		SendEquipJDingColor(btype,bindex,equipcolor)
	end
end

function OnGetSuitcondition(bSuittype) --请求套装信息 套装类型  1 品质条件 2 星级条件 3刻印条件
	local equiptbenough = {}
	local currentlevel = 0 --当前达到的等级
	local Isconditionenough  = false
	for i=1,EQUIP_P_MAX do
		equiptbenough[i] = 0
	end
	if bSuittype == 1 then
		if EquipSuitIntensifyTable.limitlevel ~= nil then
			for k,v in pairs(EquipSuitIntensifyTable.limitlevel) do
				if EquipSuitIntensifyTable[v] ~= nil then
					local temp = {}
					Isconditionenough ,temp = GetSuitconditionenough(bSuittype,v)
					if Isconditionenough == true then
						currentlevel = v
						equiptbenough = temp
					else
						break
					end
				end
			end
		end
	elseif bSuittype == 2 then
		if EquipSuitStarTable.limitlevel ~= nil then
			for k,v in pairs(EquipSuitStarTable.limitlevel) do
				if EquipSuitStarTable[v] ~= nil then
					Isconditionenough ,temp = GetSuitconditionenough(bSuittype,v)
					if Isconditionenough == true then
						currentlevel = v
						equiptbenough = temp
					else
						break
					end
				end
			end
		end
	elseif bSuittype == 3 then
		if EquipSuitKeYingTable.limitlevel ~= nil then
			for k,v in pairs(EquipSuitKeYingTable.limitlevel) do
				if EquipSuitKeYingTable[v] ~= nil then
					Isconditionenough ,temp = GetSuitconditionenough(bSuittype,v)
					if Isconditionenough == true then
						currentlevel = v
						equiptbenough = temp
					else
						break
					end
				end
			end
		end
	end
	local currentSuitProperty = GetCurrentSuitProperty(bSuittype,currentlevel)
	local nextchecknum,NextSuitProperty = GetNextSuitProperty(bSuittype,currentlevel)
	local temp = {1,2,3,4,5,6}
	SendSuitcondition(bSuittype,equiptbenough,currentSuitProperty,NextSuitProperty,nextchecknum)
end

function GetSuitconditionenough(bSuittype,bChecknum) --是否到达条件
	local equiptbenough = {}
	for i=1,EQUIP_P_MAX do
		equiptbenough[i] = 0
	end
	if bSuittype == 1 then
		if EquipSuitIntensifyTable[bChecknum].neetequippos ~= nil then
			for i,j in pairs(EquipSuitIntensifyTable[bChecknum].neetequippos) do
				local equip = GetEquipment(0,j)
				if equip ~= nil and equip.wIndex ~= 0 then
					if equip.grade >= bChecknum then
						equiptbenough[j+1] = 1  			--部位到达条件
					else
						return false,equiptbenough
					end
				end
			end
			return true,equiptbenough
		end
	elseif bSuittype == 2 then
		if EquipSuitStarTable[bChecknum].neetequippos ~= nil then
			for i,j in pairs(EquipSuitStarTable[bChecknum].neetequippos) do
				local equip = GetEquipment(0,j)
				if equip ~= nil and equip.wIndex ~= 0 then
					if equip.bCurrentStar >= bChecknum then
						equiptbenough[j+1] = 1  			--部位到达条件
					else
						return false,equiptbenough
					end
				end
			end
			return true,equiptbenough
		end
	elseif bSuittype == 3 then
		local allKeYingnum = 0
		if EquipSuitKeYingTable[bChecknum].neetequippos ~= nil then
			for i,j in pairs(EquipSuitKeYingTable[bChecknum].neetequippos) do
				local equip = GetEquipment(0,j)
				if equip ~= nil and equip.wIndex ~= 0 then
					allKeYingnum = allKeYingnum + equip.MaxKeYinLevel + equip.MaxKeYinLevel2 + equip.MaxKeYinLevel3
				end
			end
			if allKeYingnum >= bChecknum then
				return true,equiptbenough
			else
				return false,equiptbenough
			end
		end
	end
end

function GetCurrentSuitProperty(bSuittype,bChecknum) --当前套装属性
	local SuitProperty = {}
	if bSuittype == 1 then
		if EquipSuitIntensifyTable ~= nil then
			if EquipSuitIntensifyTable[bChecknum] ~= nil then
				SuitProperty = EquipSuitIntensifyTable[bChecknum].suitproperty
			end
		end
	elseif bSuittype == 2 then
		if EquipSuitStarTable ~= nil then
			if EquipSuitStarTable[bChecknum] ~= nil then
				SuitProperty = EquipSuitStarTable[bChecknum].suitproperty
			end
		end
	elseif bSuittype == 3 then
		if EquipSuitKeYingTable ~= nil then
			if EquipSuitKeYingTable[bChecknum] ~= nil then
				SuitProperty = EquipSuitKeYingTable[bChecknum].suitproperty
			end
		end
	end
	return SuitProperty
end


function GetNextSuitProperty(bSuittype,bChecknum) --下一阶段套装属性
	local SuitProperty = {}  	--下一阶段的属性
	local nextchecknum = 0 		--下一阶段达到的值
	if bSuittype == 1 then
		if EquipSuitIntensifyTable ~= nil then
			if EquipSuitIntensifyTable.limitlevel ~= nil then
				for k,v in pairs(EquipSuitIntensifyTable.limitlevel) do
					if bChecknum < v then
						SuitProperty = GetCurrentSuitProperty(bSuittype,v)
						nextchecknum = v
						break
					end
				end
			end
		end
	elseif bSuittype == 2 then
		if EquipSuitStarTable ~= nil then
			if EquipSuitStarTable.limitlevel ~= nil then
				for k,v in pairs(EquipSuitStarTable.limitlevel) do
					if bChecknum < v then
						SuitProperty = GetCurrentSuitProperty(bSuittype,v)
						nextchecknum = v
						break
					end
				end
			end
		end
	elseif bSuittype == 3 then
		if EquipSuitKeYingTable ~= nil then
			if EquipSuitKeYingTable.limitlevel ~= nil then
				for k,v in pairs(EquipSuitKeYingTable.limitlevel) do
					if bChecknum < v then
						SuitProperty = GetCurrentSuitProperty(bSuittype,v)
						nextchecknum = v
						break
					end
				end
			end
		end
	end
	return nextchecknum,SuitProperty
end

function OnTaskCallBack(btype,bcount,bindex)--装备强化，升阶升星完成时的任务回调
	--rfalse("OnTaskCallBack "..btype.."  "..bcount.."  "..bindex.."")
	if OnUpdateTask(btype,bcount,bindex) == 1 then
		--rfalse("OnTaskCallBack "..btype.."  "..bcount.."")
	end
	
end


function GetEquiptFightPower(btype,bindex)
	local equip = GetEquipment(btype,bindex)
	local equipfight = {}
	for i=1,EEA_UNPUNCTURE do
		equipfight[i] = 0
	end
	
	--printtable(equip)

	if equip ~= nil and equip.wIndex ~= 0 then
		if equip.bornAttriType >= EEA_MAXHP and equip.bornAttriType<= EEA_UNPUNCTURE  then
			local etype = equip.bornAttriType
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equip.bornAttriValue
		end

		if equip.starAttriType >= EEA_MAXHP and equip.starAttriType<= EEA_UNPUNCTURE  then
			local etype = equip.starAttriType
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.starAttriValue
		end

		if equip.MaxJDingAttriType >= EEA_MAXHP and equip.MaxJDingAttriType<= EEA_UNPUNCTURE  then
			local etype = equip.MaxJDingAttriType
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxJDingAttriValue
		end

		if equip.MaxJDingAttriType2 >= EEA_MAXHP and equip.MaxJDingAttriType2<= EEA_UNPUNCTURE  then
			local etype = equip.MaxJDingAttriType2
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxJDingAttriValue2
		end

		if equip.MaxJDingAttriType3 >= EEA_MAXHP and equip.MaxJDingAttriType3<= EEA_UNPUNCTURE  then
			local etype = equip.MaxJDingAttriType3
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxJDingAttriType3
		end

		if equip.MaxJDingAttriType4 >= EEA_MAXHP and equip.MaxJDingAttriType4 <= EEA_UNPUNCTURE  then
			local etype = equip.MaxJDingAttriType4
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxJDingAttriValue4
		end

		if equip.MaxJDingAttriType5 >= EEA_MAXHP and equip.MaxJDingAttriType5<= EEA_UNPUNCTURE  then
			local etype = equip.MaxJDingAttriType5
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxJDingAttriValue5
		end

		if equip.MaxJDingAttriType6 >= EEA_MAXHP and equip.MaxJDingAttriType6<= EEA_UNPUNCTURE  then
			local etype = equip.MaxJDingAttriType6
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxJDingAttriType6
		end

		if equip.MaxKeYinAttriType >= EEA_MAXHP and equip.MaxKeYinAttriType<= EEA_UNPUNCTURE  then
			local etype = equip.MaxKeYinAttriType
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxKeYinAttriValue
		end

		if equip.MaxKeYinAttriType2 >= EEA_MAXHP and equip.MaxKeYinAttriType2<= EEA_UNPUNCTURE  then
			local etype = equip.MaxKeYinAttriType2
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxKeYinAttriValue2
		end

		if equip.MaxKeYinAttriType3 >= EEA_MAXHP and equip.MaxKeYinAttriType3<= EEA_UNPUNCTURE  then
			local etype = equip.MaxKeYinAttriType3
			if etype == EEA_MAXHP then
				etype = etype + 1
			end
			equipfight[etype] = equipfight[etype] + equip.MaxKeYinAttriValue3
		end
	end
	--printtable(equip)

	--rfalse(" index = "..bindex.." xfightpower  ")
	if equip ~= nil then
		local equipfightpower = {}
		equipfightpower.MaxHp = equipfight[1]
		equipfightpower.GongJi = equipfight[EEA_GONGJI]
		equipfightpower.FangYu = equipfight[EEA_FANGYU]
		equipfightpower.Hit = equipfight[EEA_HIT]
		equipfightpower.ShanBi = equipfight[EEA_SHANBI]
		equipfightpower.BaoJi = equipfight[EEA_BAOJI]
		equipfightpower.Uncrit = equipfight[EEA_UNCRIT]
		equipfightpower.Wreck = equipfight[EEA_WRECK]
		equipfightpower.Unwreck = equipfight[EEA_UNWRECK]
		equipfightpower.Puncture = equipfight[EEA_PUNCTURE]
		equipfightpower.Unpuncture = equipfight[EEA_UNPUNCTURE]
		--printtable(equipfightpower)
		local xfightpower= Getfightpower(equipfightpower)
		--rfalse(" index = "..bindex.." xfightpower = "..xfightpower.."")
		return xfightpower
	end
	return 0
end

function GetItemIsEquip(itemid)  --获取道具是否为装备道具
	local itembase = GetItemBaseData(itemid)
	if itembase == nil then
		rfalse("GetItemIsEquip nil")
		return
	end
	if itembase.m_Type >= ITEM_T_EQUIPMENT_BEGIN and itembase.m_Type <= ITEM_T_EQUIPMENT_END then
		return true
	end
	return false
end