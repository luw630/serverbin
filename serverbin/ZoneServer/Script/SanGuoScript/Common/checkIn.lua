--[[
file:	checkIn.lua
author:	wk
update:	2015-01-27
desc:ǩ������,�����շ���Ϣ��c,�߼���lua
]]--
local _ceil=math.ceil
local basemoney=20
local checkindata	 = msgh_s2c_def[1][1]
local baseturn30=120 --30��ǩ�������ֻ�
local baseturn7=14 --7��ǩ�������ֻ�
local DayTime = 24 * 60 * 60
--ȡ�������
local function checkin_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['checkin']==nil then --��ʼ��ǩ����������
		dbMgr[sid].data['checkin']={
			-- [1]=0,--��һ��ǩ��ʱ��
			-- [2]=0,--�ϴ�ǩ��ʱ��
			-- [3]=0,--����ǩ������
			-- [4]=0,--���ֲ�ǩ����
			-- [5]=1,--7�յ�½�����ڼ���
			-- [6]=0,--7�յ�½�����쵼�ڼ���(��;�ж�ʱ��ͷ��ʼ)
			
			[1]=0,--30�ֻ��ϴ�ǩ��ʱ��
			[2]=0,--30�ֻ�ǩ���ڼ���(��;�ж�ʱ����ͷ��ʼ)
			[3]=0,--7�ֻ��ϴ�ǩ��ʱ��
			[4]=0,--7�ֻ�ǩ���ڼ���(��;�ж�ʱ��ͷ��ʼ)
		}
	end
	return dbMgr[sid].data['checkin']
end
--ͬ��ǩ����Ϣ��ǰ̨ ��¼,ǩ����ǩ����
function checkin_senddata( sid )
	--look("checkin_senddata")
	local pdata=checkin_getdata( sid )
	if pdata==nil then 
		return 
	end
	CI_SendCheckinData(pdata[1],pdata[2],pdata[3],pdata[4])
end
--ͬ��ǩ����Ϣ��ǰ̨
function checkin_firstlogin(sid,dataTb,index)
	local pdata=checkin_getdata( sid )	
	for i=1,4 do
		dataTb[index+i-1]=pdata[i]
	end
	return index+4 
end

--ǩ���콱 itype=1ÿ��30ǩ��,itype=2ÿ��7ǩ��
function checkin_quest(sid,itype)
	 -- look(tostring("ǩ���콱"))
	-- look(sid)	
	 -- look(itype)	
	local pdata=checkin_getdata( sid )
	
	if pdata==nil then 
		look('pdata==nil')
		return 
	end
	local CurTime = GetServerTime()
	if itype==1 then --ÿ��30ǩ��
		if 0==pdata[1] then 
			pdata[1]=CurTime-DayTime --��ʼ��Ϊ����ǩ��ʱ��
		end
		--local  diffday= _ceil(CurTime / DayTime)-_ceil(pdata[1] / DayTime)
		local  diffday=  GetDiffDayFromTime(pdata[1])-GetDiffDayFromTime(CurTime)
		if diffday<=0 then --��ǩ��
			look('��ǩ��')
			return
		end	
		pdata[1]=CurTime
		pdata[2]=pdata[2]+1
		
		if pdata[2]>baseturn30 then 
			pdata[2]=1
		end
		-- --����c++������
		CI_GiveCheckinAwards(pdata[2],itype)--����1Ϊ30��ǩ���ڼ��콱��,����2Ϊ7��ǩ���ڼ���,����3Ϊ7��ǩ���ڼ���Ľ���
	elseif itype==2 then --7��ǩ��
		if 0==pdata[3] then 
			pdata[3]=GetServerTime()-DayTime --��ʼ��Ϊ����ǩ��ʱ��
		end
		--local  diffday= _ceil(CurTime / DayTime)-_ceil(pdata[3] / DayTime)
		local  diffday= GetDiffDayFromTime(pdata[3])-GetDiffDayFromTime(CurTime)
		if diffday<=0 then --��ǩ��
			look('��ǩ��')
			return
		elseif diffday==1 then --����ǩ��
			
		elseif diffday>1 then--����ǩ��,7��ǩ����ͷ��ʼ
			
			if pdata[4]>7 then 
				pdata[4]=7
			else
				pdata[4]=0
			end
		end	
		pdata[3]=CurTime
		pdata[4]=pdata[4]+1
		if pdata[4]>baseturn7 then 
			pdata[4]=7
		end
		-- --����c++������
		CI_GiveCheckinAwards(pdata[4],itype)--����1Ϊ30��ǩ���ڼ��콱��,����2Ϊ7��ǩ���ڼ���,����3Ϊ7��ǩ���ڼ���Ľ���
		
	end
	
	checkin_senddata( sid )
	
	--SendLuaMsg(0,{ids=checkindata,pdata[1],pdata[2],pdata[3],pdata[4]})
	--CI_TipMsg("ǩ���ɹ�!!!")
end
-- --ǩ���콱 itype=1ÿ��ǩ��,itype=2��ǩ---֮ǰ��ǩ�汾,��ʱ��һ��,�Է��߻�����!
-- function checkin_quest(sid,itype)
	-- -- look(tostring("ǩ���콱"))
	-- --look(sid)	
	-- -- look(itype)	
	-- local pdata=checkin_getdata( sid )
	
	-- if pdata==nil then 
		-- look('pdata==nil')
		-- return 
	-- end
	-- local CurTime = GetServerTime()
	-- local DayTime = 24 * 60 * 60
	-- local PreTime = pdata[2]
	-- if pdata[1]==0 then --��һ��ǩ��ʱ���ʼ��Ϊ����00:00:01
		-- local dt = os.date("*t", CurTime)
		-- dt.hour = 0
		-- dt.min = 0
		-- dt.sec =1
		-- pdata[1]=os.time(dt)
	-- end
	-- -- look(pdata[1])
	-- local maxcount=_ceil((CurTime-pdata[1])/DayTime) --�õ����վ��һ��������
	-- local nowturn=_ceil(maxcount/30) --���յڼ���
	-- local over_count=_ceil((pdata[2]-pdata[1])/DayTime) --�õ��ϴ�ǩ������һ��ǩ��������
	-- local player_turn=_ceil(over_count/30) --����ϴ�ǩ���ǵڼ���
	
	-- if player_turn~=nowturn then --������һ��,�ÿմ���һ�ֿ�ʼ
		-- pdata[3]=0
		-- pdata[4]=0
	-- end
		
	
	-- if itype==1 then --ÿ��ǩ��
		-- local  diffday= _ceil(CurTime / DayTime)-_ceil(PreTime / DayTime)
		-- if diffday<=0 then --��ǩ��
			-- --look('��ǩ��')
			-- return
		-- elseif diffday==1 then --����ǩ��
			
			-- pdata[6]=pdata[6]+1
			-- if pdata[6]>7 then--7����1��ʼ
				-- pdata[6]=1
				-- pdata[5]=pdata[5]+1 --����+1
			-- end
			
		-- elseif diffday>1 then--����ǩ��,7��ǩ����ͷ��ʼ
			-- pdata[6]=1
		-- end	
		-- pdata[2]=CurTime
		-- pdata[3]=pdata[3]+1
		-- -- --����c++������
		-- CI_GiveCheckinAwards(pdata[3],pdata[5],pdata[6])--����1Ϊ30��ǩ���ڼ��콱��,����2Ϊ7��ǩ���ڼ���,����3Ϊ7��ǩ���ڼ���Ľ���
	-- elseif itype==2 then --��ǩ
		-- local nowday=maxcount%30 --�ڼ���
		-- if nowday==0 then
			-- nowday=30 --����һ�ֵĵ�30��
		-- end
		-- if pdata[3]<nowday then --���Բ�ǩ
			
			-- --��Ǯ
			-- local needmoney=(pdata[4]+1)*basemoney
			 -- if CI_CheckGoods_SG(2,0,needmoney)~=1 then
				-- --look('money less')
				-- CI_TipMsg("money less!!!")
				-- return 
			 -- end
			 -- CI_DecGoods_SG(2,0,needmoney)
			-- pdata[3]=pdata[3]+1
			-- pdata[4]=pdata[4]+1
			-- -- --������
				-- CI_GiveCheckinAwards(pdata[3],0,0)--����1Ϊ30��ǩ���ڼ��콱��,����2Ϊ7��ǩ���ڼ���,����3Ϊ7��ǩ���ڼ���Ľ���
		-- else
			-- return
		-- end
		
	-- end
	
	-- checkin_senddata( sid )
	
	-- --SendLuaMsg(0,{ids=checkindata,pdata[1],pdata[2],pdata[3],pdata[4]})
	-- --CI_TipMsg("ǩ���ɹ�!!!")
-- end

