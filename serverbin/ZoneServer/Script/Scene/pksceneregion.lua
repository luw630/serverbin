function InitPkScene()
	if PkSceneMapTable ~= nil then
		--for o,p in pairs(PkSceneMapTable) do
			for k,v in pairs(PkSceneMapTable) do
				if v.Monster ~= nil then
					for i, mCreate in pairs(v.Monster) do
						mCreate.x = mCreate.x * Postionamend 		--怪物出生坐标修正
						mCreate.y = mCreate.y * Postionamend
						--rfalse("Monster x = "..mCreate.x.." y = "..mCreate.y.."")
					end
				elseif v.BatchMonster ~= nil then
					for i,j in pairs(v.BatchMonster) do
						if type(j) == "table" then
							for m,n in pairs(j.monsterlist) do
								n.x = n.x * Postionamend 			--怪物出生坐标修正
								n.y = n.y * Postionamend
								--rfalse("Monster x = "..n.x.." y = "..n.y.."")
							end
						end
					end
					if v.BatchMonster.bornType == REFRSHTYPE_REGIONRANDOM then  --随机刷怪
						for i,j in pairs(v.BatchMonster) do
							if type(j) == "table" then
								if  j.randradius ~= nil then
									local lenth = GetTableLenth(j.monsterlist)
									for m=1,lenth do
										local monsterlist = deepcopy(j.monsterlist[m])
										local num = j.monsternum[m]
										for n=1,num - 1 do
											local radius = LuaRandRange(1,j.randradius)
											local radian = LuaRandRange(0,2*3.14)
											monsterlist.x = j.monsterlist[1].x + radius * math.cos(radian)
											monsterlist.y = j.monsterlist[1].y + radius * math.sin(radian)
											table.insert(j.monsterlist,monsterlist)
											monsterlist = deepcopy(j.monsterlist[m])
										end
									end
								end	
							end
						end
					end
				end

				if v.RefreshMonster ~= nil then
					for i,j in pairs(v.RefreshMonster) do
						if j.refreshtype == REFRSHTYPE_REGION then
							for m,n in pairs(j.monsterlist) do
								n.x = n.x * Postionamend 			--怪物出生坐标修正
								n.y = n.y * Postionamend
							end
							if j.regionPosition ~= nil then
								local region = j.regionPosition
								-- region.upleft[1] = region.upleft[1] *Postionamend
								-- region.upleft[2] = region.upleft[2] *Postionamend
								-- region.lowleft[1] = region.lowleft[1] *Postionamend
								-- region.lowleft[2] = region.lowleft[2] *Postionamend
								-- region.upright[1] = region.upright[1] *Postionamend
								-- region.upright[2] = region.upright[2] *Postionamend
								-- region.lowright[1] = region.lowright[1] *Postionamend
								-- region.lowright[2] = region.lowright[2] *Postionamend
								region.left = region.left *Postionamend
								region.low = region.low *Postionamend
								region.right = region.right *Postionamend
								region.top = region.top *Postionamend
							end

						elseif j.refreshtype == REFRSHTYPE_REGIONRANDOM then
							if j.srcPosition ~= nil then
								j.srcPosition[1] = j.srcPosition[1] * Postionamend
								j.srcPosition[2] = j.srcPosition[2] * Postionamend
							end
						end
					end
				end

				if v.bornPostion ~= nil then
					v.bornPostion[1] = v.bornPostion[1] * Postionamend     --复活以及死亡复活坐标修正
					v.bornPostion[2] = v.bornPostion[2] * Postionamend
				end

				if v.relivePostion ~= nil then
					v.relivePostion[1] = v.relivePostion[1] * Postionamend
					v.relivePostion[2] = v.relivePostion[2] * Postionamend
				end
			end
		end

	--end
end

function PutPlayerToPkSceneMap(sceneindex)	
	if PkSceneMapTable ~= nil and PkSceneMapTable[sceneindex] ~= nil then
		local PkSceneMapIndex = 0
		local pkmap = PkSceneMapTable[sceneindex]
		if PkSceneManager ~= nil then
			if PkSceneManager[sceneindex] ~= nil then
				PkSceneMapIndex = PkSceneManager[sceneindex].PkSceneMapIndex
			else
				local regionID = pkmap.MapID * 10000 + sceneindex
				local mapid = pkmap.MapID
				local scenepktye = 0
				if pkmap.ScenePkType ~= nil then
					scenepktye = pkmap.ScenePkType
				end
				PkSceneMapIndex = CreateScene(regionID, mapid, 0, scenepktye, 0, 0)
				if (nil == PkSceneMapIndex) then
					return
				end	
				PkSceneManager[sceneindex] = {}
				PkSceneManager[sceneindex].PkSceneMapIndex = PkSceneMapIndex
				PkSceneManager[sceneindex].PlayerNum = 0
				PkSceneManager[sceneindex].PlayerList = {}
			end

			if PkSceneMapIndex == 0 then
				rfalse("PutPlayerToPkSceneMap Faile")
				return
			end

			if pkmap.bornPostion ~= nil then
				local x = pkmap.bornPostion[1] 
				local y = pkmap.bornPostion[2] 
				PutPlayerTo(0, x, y, PkSceneMapIndex,0)
				rfalse("PutPlayerToPkSceneMap x = "..x.." y = "..y.."")
				PkSceneManager[sceneindex].PlayerNum = PkSceneManager[sceneindex].PlayerNum + 1
				local playergid = GetPlayerGID(0)
				table.insert(PkSceneManager[sceneindex].PlayerList,playergid)
			end
		end
	end
end

function  PlayerLeavePkScene()
	local playergid = GetPlayerGID(0)
	if PkSceneManager ~= nil then
		for k,v in pairs(PkSceneManager) do
			if v.PlayerNum > 0 then
				for i,j in pairs(v.PlayerList) do
					if j == playergid then
						if GetPlayerData(playergid,GPP_ACTION) == EA_DEAD or GetPlayerData(playergid,GPP_CURHP) == 0 then
							rfalse("PlayerLeavePkScene  "..playergid.."")
							PlayerQuestRelive(0,playergid)
						end
						PutPlayerFromDynamic(1,v.PkSceneMapIndex,0,0,0)						--把玩家从场景从移动
						--DestroyDynamicScene(reginid,scmanager.Monsterlist)
						RemoveFromTable(v.PlayerList,playergid)
						v.PlayerNum = v.PlayerNum - 1
						if v.PlayerNum == 0 then
							DestroyScene(v.PkSceneMapIndex)
							RemoveFromTable(PkSceneManager,k)
							rfalse("DestroyPkScene")
						end
						rfalse("PlayerLeavePkScene gid = "..playergid.."")
							break
					end
				end
			end
		end
	end
end


function PkSceneManagerInit()
	if PkSceneManager == nil then
		PkSceneManager = {}
	end
end

PkSceneManagerInit()
InitPkScene()