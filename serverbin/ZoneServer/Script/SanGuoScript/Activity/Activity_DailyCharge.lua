--[[
file:	Activity_DailyCharge.lua
author:	Jonson
update:	2015-07-09
desc:	������ÿ�ճ�ֵ�Ļ
]]--

--�����µĻ���͵�ʵ��
DailyChargeActivity = Activitymodule:new()
--��ʼ�������
DailyChargeActivity:Init(2)
--��ActivityManagerע�᱾�
ActivityRegister(DailyChargeActivity)
--��ȡ������ҵı���Ļ�������
DailyChargeData = DailyChargeActivity:LoadData()	--��ҵ�ÿ�ճ�ֵ����

function DailyChargeActivity:OnTrigger(actParam) --������ʱ��������,������Ҫ���ݲ�ͬ�Ĳ��������ͬ���Դ��ݲ�ͬ
	look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	self:ChargeGiveItem(100,1000)
end

