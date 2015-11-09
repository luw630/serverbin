--[[
file:	BlessActivity.lua
author:	lpd
update:	2015-11-03
desc:�������߼�
]]--

BlessActivity =  Activitymodule:new()
BlessActivity:Init(ActIndex.bless)
ActivityRegister(BlessActivity)
BlessActData = BlessActivity:LoadData()	--��ҵľ۱�������
local _blessConfig =  BlessActConfig
local _bless_msg = msgh_s2c_def[s2c_msg.act][4] --����Ϣͷ
function BlessActivity:GetBlessData (sid) --��ȡ���������
	-- look("BlessActivity:GetBlessData")
	-- look(sid)
	if BlessActData ~= nil then
		if BlessActData[sid] == nil then
			BlessActData[sid] = 
			{
				[1] = 0, --�ۼ�������
				[2] = {}
			}
		end
	end
	return BlessActData[sid]
end

function OnBlessOver(sid,blessType, blessCount) --����Ϻ�Ļص����� blessType�����ͣ�blessCount������
	look("OnBlessOver")
	look(sid)
	look(blessType)
	look(blessCount)
	local  blessData = BlessActivity:GetBlessData(sid) 

	if blessData ~= nil then
		blessData[1] = blessData[1] + blessCount
	end
end 

function GetBlessActReward(sid, rewardIndex) --��ȡ������� sid���Ψһ��ʶ��rewardIndex��Ʒ�±�
	if BlessActivity:GetActivityEnable() == false then
		return
	end
	local  blessData = BlessActivity:GetBlessData(sid) 
	-- look("GetBlessActReward" )
	-- look(sid)
	-- look(rewardIndex)
	-- look(blessData)
	if _blessConfig[rewardIndex] ~= nil and blessData ~= nil then 
		local condition = _blessConfig[rewardIndex].blessCount
		if blessData[1] >= condition and  blessData[2][rewardIndex] == nil then --�������� �� δ��ȡ��
			blessData[2][rewardIndex] = 1 --���Ϊ����ȡ
			for k, v in pairs(_blessConfig[rewardIndex].reward) do 
				CI_AddGoods_SG(v[1], v[2], v[3], GoodsWay.exchangeACT)
			end
			SendBlessActData(sid) 
		end
	end  

end


function SendBlessActData(sid)--�������״̬
	if BlessActivity:GetActivityEnable() == false then
		return
	end

	local  blessData = BlessActivity:GetBlessData(sid) 
	if blessData ~= nil then
		-- look("SendBlessActData1111111111111")
		-- look("_bless_msg")
		-- look(_bless_msg)
		-- look("blessData")
		-- look(blessData)
		SendLuaMsg(sid, { ids = _bless_msg, blessData[1] , blessData[2] })
	end
end

function BlessActivity:OnActivityClosed(actParam)
 	-- body
 	--BlessActData = {}
end 




