MonsterdropTable = {}

--sreset
math.randomseed(os.time())


function DropItem(monstid)
	for k, v in pairs(MonsterdropTable) do
			for i, j in pairs(v.MonsterID) do
				if(j == monstid )then			--ȡ�ù���ID
					rfalse("����IDΪ"..monstid.."��ʼ������Ʒ")
					if(v.ItemDropDate ~= 0 and v.ItemDropDate ~= os.date("%Y%m%d"))then			--ȡ�õ�����������
						rfalse(v.ItemDropDate)
						break
					end
					local t=os.time()-v.ItemDropTime;

					if( t < v.TimeInterval*60 or v.TimeInterval == 0 )then				--ȡ��ʱ�����Լ���������
						local dropcount=v.SingleDropValue		--ȡ��ÿ�ε���ĵ�������

						local num = math.random(1,10000)   --��1--10000�����ȡֵ
						local Itemnum = table.getn(v.Item) --�õ���Ʒ�ĸ���
						local randomItemIndex = math.random(1,Itemnum) --��1����Ʒ���������ȡ����ƷIndex
						local isdrop = 0
						while(dropcount>0)do
							if(v.DropValue < 0)then
								break
							end
							for m, n in pairs(v.Item) do
								if(m == randomItemIndex and n[2] > num) then	--�����ƷIndex���������Index��������Ʒ�ĵ��伸�ʴ������ֵ
									isdrop=monsterdropitem(n[1],1)		--���������Ʒ
									if(isdrop==1)then
										v.DropValue=v.DropValue-1
										-- rfalse(GetItemName(n[1]))
										rfalse("�ڵ�"..dropcount.."��ѭ���й��������Ʒ"..GetItemName(n[1]))
										break
									end
								end
							end
							if(isdrop == 0)then
								rfalse("�ڵ�"..dropcount.."��ѭ���й��������ƷNULL")
							end
							dropcount=dropcount-1
							num = math.random(1,10000)	--��1--10000�����ȡֵ���ٴ�ȡ�������
							randomItemIndex = math.random(1,Itemnum)	--��1����Ʒ���������ȡ����ƷIndex���ٴ������ƷIndex
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
--	SendBoardCastMsg(monstername.."��"..attatkername.."ɱ���ˣ��������װ����");
end



function OnDropItem1(monstid)
	DropItem(monstid)
end
