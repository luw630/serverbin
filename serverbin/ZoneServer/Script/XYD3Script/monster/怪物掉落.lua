MonsterdropTable = {}

--sreset
math.randomseed(os.time())


function DropItem(monstid)
	for k, v in pairs(MonsterdropTable) do
			for i, j in pairs(v.MonsterID) do
				if(j == monstid )then			--取得怪物ID
					rfalse("怪物ID为"..monstid.."开始掉落物品")
					if(v.ItemDropDate ~= 0 and v.ItemDropDate ~= os.date("%Y%m%d"))then			--取得掉落日期限制
						rfalse(v.ItemDropDate)
						break
					end
					local t=os.time()-v.ItemDropTime;

					if( t < v.TimeInterval*60 or v.TimeInterval == 0 )then				--取得时间间隔以及掉落数量
						local dropcount=v.SingleDropValue		--取得每次掉落的掉落数量

						local num = math.random(1,10000)   --在1--10000中随机取值
						local Itemnum = table.getn(v.Item) --得到物品的个数
						local randomItemIndex = math.random(1,Itemnum) --在1到物品个数中随机取得物品Index
						local isdrop = 0
						while(dropcount>0)do
							if(v.DropValue < 0)then
								break
							end
							for m, n in pairs(v.Item) do
								if(m == randomItemIndex and n[2] > num) then	--如果物品Index等于随机的Index，并且物品的掉落几率大于随机值
									isdrop=monsterdropitem(n[1],1)		--这里掉落物品
									if(isdrop==1)then
										v.DropValue=v.DropValue-1
										-- rfalse(GetItemName(n[1]))
										rfalse("在第"..dropcount.."次循环中怪物掉落物品"..GetItemName(n[1]))
										break
									end
								end
							end
							if(isdrop == 0)then
								rfalse("在第"..dropcount.."次循环中怪物掉落物品NULL")
							end
							dropcount=dropcount-1
							num = math.random(1,10000)	--在1--10000中随机取值，再次取得随机数
							randomItemIndex = math.random(1,Itemnum)	--在1到物品个数中随机取得物品Index，再次随机物品Index
							isdrop = 0
						end
					else
						v.ItemDropTime=os.time()
						v.DropValue	= v.AllDropValue
					end
				end
			end
	end
end

function TalkToworld(monstid)
	local monstername=GetMonsterData(3);
	local attatkername=getattackername();
--	SendBoardCastMsg(monstername.."被"..attatkername.."杀死了，大家来抢装备啊");
end



function OnDropItem1(monstid)
	DropItem(monstid)
end
