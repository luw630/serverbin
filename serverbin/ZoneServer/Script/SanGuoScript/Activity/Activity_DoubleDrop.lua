--[[
file:	Activity_DoubleDrop.lua
author:	lpd
update:	2015-11-06
desc:�ӱ�����
]]--

DropActivity =  Activitymodule:new()
DropActivity:Init(ActIndex.doubleDrop)
ActivityRegister(DropActivity)
DropActData = DropActivity:LoadData()	--��Ҽӱ���������

local DropActConfig = --��������
{
	rate = 2,--���� Ŀǰ����Ϊ2��
}

function GetDropActRate()--��ȡ���䱶��
 	if not DropActivity.ActivityEnable then
		return 1
	end

	return DropActConfig.rate 
 end 



