--[[
file:	Act_func.lua
author:	lpd
update:	2015-05-13
desc:�����
]]--
local _date=os.date
local _time=os.time
local _ceil = math.ceil
local _fmod = math.fmod
local _pow = math.pow
local _floor = math.floor
local openTime=0
local actConf = act_conf
local _get_digitnum = get_digitnum
local _set_digitnum = set_digitnum
local testDay = 1 --ȡ����ĳ���������̶�+1������Ҫ��ֵ


-- ��ȡ��һ������
local function get_actdata(sid) 
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['act']==nil then 
		dbMgr[sid].data['act']={ -- key 1-8:0������ȡ������ 1��ʾ��¼��û����ȡ����,  2��ʾ����ڻ����û�е�¼��
									--���λ��¼Ϊ�ڰ�����ȡ״̬����λ��һ��,ʮλ�ڶ��죬�Դ����ơ�����
			ctime = 0, --�˺Ŵ���ʱ��
			loginday = 0, --��¼����
			[1]=22222222,--����������,1-8
			[2]=22222222,--����������,9-16
			[3]=22222222,--����-�������� 1-8
			[4]=22222222,--����-�������� 9-16
			[5]=22222222,--ǩ�����佫 1-8
			[6]=22222222,--ǩ�����佫 9-16
			[7]=11111111,--�弶���������� 1-8
			[8]=11111111,--�弶���������� 9-16
			[9]=1, -- �һ���
			
			[10]=0,--������Ԫ��,����ϴ���ȡʱ��
			[11]=0,--�����챦��,����ϴ���ȡʱ��
			[12]=0,--����,����ϴ���ȡʱ��  6��19�ա�20�ա�21��
		}
	end
	return dbMgr[sid].data['act']
end

--��һ�ȡ������ӿ�  
--[[
	actType=1 ����������, 2 ����, 3ǩ�����佫 ,4 �弶����������,5 �һ��빦��,6,--������Ԫ�� 	7,--�����챦��	8, --����
	indexOri=��Ӧ�������õ��±�
]]--
function act_get_reward(sid, actType, indexOri)
	
	--look("=========���������==========")
	look("���ID:"..sid.."  �����:"..actType.."  ��������:"..indexOri)
	
	if actType == act_type.chargeSum then --������ۼƳ�ֵ������������Ӧ�߼�
		GetChargeSumReward(sid, indexOri) --���û�ȡ�ۼƳ�ֵ�����ӿ�
		return
	end
	
	local actData = get_actdata(sid) -- ��ȡ��Ӧ�����
	if actData == nil then --������������ �򷵻�
		--look("���������")	
		return
	end
	
	local curActconf = actConf[actType] --��ȡ��Ӧ�����
	local index = indexOri  --��Ӧ������ݵڼ�λ�ı�ʶ
	local result = 1 -- 0Ϊ��ȡ����ʧ�ܣ�1Ϊ��ȡ�����ɹ�
	local rewardIndex = actType *2 -1 -- ������Ӧ�����������
	
	--�õ� index,result,rewardIndex
	if actType == act_type.betaTestGift then --��������
		-- local createTime = actData.ctime
		-- local actDay = GetDiffDayFromTime(createTime) + testDay--���㵱ǰʱ���ǿ����ĵڼ���
		-- if actDay > 8  and indexOri > 8 then--�������8��
		-- 	rewardIndex = rewardIndex + 1 
		-- 	index = index - 8
		-- end
	elseif actType == act_type.betaLucky or actType == act_type.chekinHeroGift  then --���ǳ�������
		local createTime = actData.ctime
		local actDay = GetDiffDayFromTime(createTime) + testDay--���㵱ǰʱ���ǿ����ĵڼ���
		if(index > actDay)then --�ж������������Ƿ�Ϊ����
			result = 0
		end 
		if(actDay > 8) and (index > 8) then--�������8��
			rewardIndex = rewardIndex + 1 
			index = index - 8
		end
	elseif actType == act_type.lvUpGift then--��������

		--if curActcon.con[index] <= CI_GetPlayerDataSG(sid, 3) then--����ȼ� 
		--end
		if(index > 8) then --���������������8
			rewardIndex = rewardIndex + 1
			index = index - 8
		end
		
	elseif actType == act_type.packGift then --�һ��
		--look("�һ��")
		rewardIndex = 9 --�һ���Ľ�����Ӧ��������±���9
		
	elseif actType == act_type.diamondEveryday or  actType == act_type.boxEveryday then  --6,--������Ԫ�� 	7,--�����챦��
		local actDay = GetDiffDayFromTime(actData.ctime) + testDay--���㵱ǰʱ���ǿ����ĵڼ���
		if actDay<17 then
			--look(222)
			result=0
		end
		if (actDay-16)%8 ~=indexOri then--������Ӧ����,8��һ�ֻ�
			--look(111)
			result = 0
		end
		rewardIndex=actType+4
	elseif  actType == act_type.duanwu then  --8, -- ���� 6��19�ա�20�ա�21��
		rewardIndex=actType+4
		local nowday = _date("*t", GetServerTime())
		local day=indexOri+18
		if nowday.month~=6 or nowday.day ~=day then 
			--look(333)
			result = 0
		end
	end

	--�ж���ȡ��û 
	if result==1 then
		if rewardIndex>0 and rewardIndex<=9 then --1-9��Ӧkey�Ļ
			
		--�������Ƿ�δ��ȡ����� 
			if _get_digitnum(actData[rewardIndex] ,index) == 1 then 
				actData[rewardIndex] = _set_digitnum(actData[rewardIndex],index ,0 )
			else
				look("�Ѿ�����ȡ��")
				result = 0
			end
		
		elseif rewardIndex>=10 and rewardIndex<=12 then 
			local now=GetServerTime()
			local actDay = GetDiffDayFromTime(now) + testDay--���㵱ǰʱ���ǿ����ĵڼ���
			local lastday= GetDiffDayFromTime(actData[rewardIndex]) + testDay--�����ϴ��콱�ǿ����ĵڼ���
			if lastday == actDay then
				look("�Ѿ�����ȡ��")
				result = 0
			end
			actData[rewardIndex]=now --���������콱ʱ��
		
		end
	end

	
	--�жϽ���������뷢�ͽ������� 
	if result == 1 then  
		for key, value in pairs(curActconf[indexOri]) do      
			CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
			--look("��ȡ������" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
		end  
	end
	
	--look("=========��ɻ����==========")
	CI_ActResult(actType,indexOri,result) --�����ͻ���
end


function set_Ctime(sid) --���ÿ���ʱ��
	look("set_Ctime")
	local actData =	get_actdata(sid)
	if actData ~= nil then
		if actData.ctime == 0 then
			actData.ctime = GetServerTime()
		end
	end
end

--�����˺� ���ÿ���ʱ��
function set_createTime(sig , retTime) 
	local actData =	get_actdata(sig)
	if(actData == nil) then
		return 
	end
	if retTime ~= nil then
		actData.ctime = retTime
	else
		actData.ctime = GetServerTime()--���ÿ���ʱ��
	end
	--look("���ÿ���ʱ��:"..actData.ctime)
end

--��½ͬ������
function act_firstLogin(sid,dataTb,index)
	local pdata = get_actdata(sid)
	dataTb[index] = pdata.ctime
	index = index+1
	for i=1,12 do
		dataTb[index+i-1]=pdata[i]
	end
	return index+12 
end

--���½���Զ���������ֵ
function act_login(sid) 

	local actData =get_actdata(sid)
	local actDay = GetDiffDayFromTime(actData.ctime) + testDay--���㵱ǰʱ���ǿ����ĵڼ���
	look("��¼��������ã���ǰ�ǵ�"..actDay.."��")

	for i=1,8 do--�ۼƵ�¼���޸Ľ����¼״̬
	    if actDay > actData.loginday and _get_digitnum(actData[1], i) == 2 then
			actData[1] = _set_digitnum(actData[1], i, 1)
			break
		end
	end
	if(actDay > 16)  then
		return
	elseif(actDay > 8)  then --�޸�8�����ϵ�����
		if _get_digitnum(actData[4], actDay-8) == 2 then --��¼ʱ��������δ��¼״̬2�����޸�Ϊ��¼����ȡ״̬ 1
			actData[4]=_set_digitnum(actData[4], actDay-8,1) 
		end
		if _get_digitnum(actData[6], actDay-8) == 2 then --��¼ʱ��������δ��¼״̬2�����޸�Ϊ��¼����ȡ״̬ 1
			actData[6]=_set_digitnum(actData[6], actDay-8,1) 
		end
		for i=1,8 do --�ۼƵ�¼���޸Ľ����¼״̬
			if actDay > actData.loginday and _get_digitnum(actData[2], i) == 2 then
				actData[2] = _set_digitnum(actData[2], i, 1)
				break
			end
		end
	else --8������
		if (_get_digitnum(actData[3],  actDay) ==2) then--��¼ʱ��������δ��¼״̬2�����޸�Ϊ��¼����ȡ״̬ 1
			actData[3]=_set_digitnum(actData[3], actDay,1) 
		end
		if (_get_digitnum(actData[5],  actDay) ==2) then --��¼ʱ��������δ��¼״̬2�����޸�Ϊ��¼����ȡ״̬ 1
			actData[5]=_set_digitnum(actData[5], actDay,1) 
		end

	end

	actData.loginday = actDay --��¼ʱ�丳ֵ

end

--��Ԫ��������
--function act_testCase()
	--local result = set_digitnum(111111111, 2, 0) 
	--look (result)
	-- set_digitnum(19998854, 2, 7) 
	-- set_digitnum(19998854, 3, 7) 
	-- set_digitnum(19998854, 4, 7) 
	-- set_digitnum(19998854, 5, 7) 
	-- set_digitnum(19998854, 6, 7) 
	-- set_digitnum(19998854, 7, 7) 
	-- set_digitnum(19998854, 8, 7) 
	-- set_digitnum(19998854, 9, 7) 
	--[[get_digitnum(19998854, 1)
	get_digitnum(19998854, 2)
	get_digitnum(19998854, 3)
	get_digitnum(19998854, 4)
	get_digitnum(19998854, 5)
	get_digitnum(19998854, 6)
	get_digitnum(19998854, 7)
	get_digitnum(19998854, 8)
	get_digitnum(19998854, 9)
	]]--
	--local rwardIndex = CI_GetStartTime()
	--look (rwardIndex)
	--look(CI_GetPlayLevel())
	--get_reward(1000100003, 1) --���Ի�ȡ����
	
	-- tempStr = mutstring("sssssssssss")
	-- look(tempStr[2])
	-- tempStr[2] = "f"
	-- a = "string:"
	-- look(a..tostring(s))
	--act_get_reward(1000100004,1,15)
--end
--act_testCase()
