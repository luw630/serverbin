--�����ķ����㹫ʽ
--��Ԫ���� һ������  ϴ�辭

--[[
ConsumeTelergy(SP, money, 1) ����˵��

��һ�����������ĵ�����
�ڶ��������� ���ĵĽ�Ǯ
������������ ��ʾ���µ����ͣ�1 ��ʾ�ķ���2 ��ʾ����
--]]
function UpdateTelergy6000(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6001(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6002(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--��Ԫ����̫����
function UpdateTelergy6003(TLevel)
	local SP	= 123 * 1.045^(TLevel - 1)
	local money	= 110 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6004(TLevel)
	local SP	= 123 * 1.045^(TLevel - 1)
	local money	= 110 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--�˲�������
function UpdateTelergy6005(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6006(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--������
function UpdateTelergy6007(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--��ɫ���ࡢ����ҽ�
function UpdateTelergy6008(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6009(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--�������С�����ж��
function UpdateTelergy6010(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6011(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--�ķ�������������ֵ
function TelergyProperty6000(TLevel)
	local value = 10

	--�����ص� ����һ���������������ͣ��ڶ�������������ֵ, ���������������������Ը��ʣ�û�еĴ���0
	--���ͱ�ţ�0�����ӹ�������1�����ӷ�������2����������ֵ��3����������ֵ��4����������ֵ��5����������ֵ��6�����ӱ���ֵ��
	--         7��������Ѫ�ٷֱȣ�8�����ӿ��ڰٷֱȣ�9�����ӿ������ٷֱȣ�10�����ӿ۹�������������11�����ӿ۷�������������
	ConsumeTelergyProperty(0, value, 0)
end

function TelergyProperty6001(TLevel)
	local value = 7
	ConsumeTelergyProperty(1, value, 0)
end

function TelergyProperty6002(TLevel)
	local value = 80
	ConsumeTelergyProperty(2, value, 0)
end

function TelergyProperty6003(TLevel)
	local value = 15
	ConsumeTelergyProperty(3, value, 0)
end

function TelergyProperty6004(TLevel)
	local value = 2
	ConsumeTelergyProperty(4, value, 0)
end

function TelergyProperty6005(TLevel)
	local value = 6
	ConsumeTelergyProperty(5, value, 0)
end

function TelergyProperty6006(TLevel)
	local value = 4
	ConsumeTelergyProperty(6, value, 0)
end

function TelergyProperty6007(TLevel)
	local value = (TLevel - 1) * 0.005 + 0.005
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(7, value, rate)
end

function TelergyProperty6008(TLevel)
	local value = (TLevel - 1) * 0.001 + 0.001
	local rate  = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(8, value, rate)
end

function TelergyProperty6009(TLevel)
	local value = (TLevel - 1) * 0.003 + 0.003
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(9, value, rate)
end

function TelergyProperty6010(TLevel)
	local value = (TLevel - 1) * 0.005 + 0.005
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(10, value, rate)
end

function TelergyProperty6011(TLevel)
	local value = (TLevel - 1) * 0.005 + 0.005
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(11, value, rate)
end
