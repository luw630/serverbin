--[[
file:	GameSysSwitch.lua
author:	Luwei,lpd
update:	2015-09-2
desc:��Ϸϵͳ���ܿ���
]]--

--[[
moudel_type = --ģ������
{
	act_moudel = 1,
	skill_moudel = 2,
	mall_moudel = 3,
}
]]--

system_switch =
{
	--[moudel_type.act_moudel] = { --�ģ��
	act_moudel = { --�ģ��
		bless_act = true --����������
	},
	--[moudel_type.skill_moudel] = { --����ģ��
	skill_moudel = { --����ģ��
		BuyPointLimit = 0 --�����ܵ�������Ʊ�� 0:������ 1:����
	},
	--[moudel_type.mall_moudel] = { --�̵�ģ��
	mall_moudel = { --�̵�ģ��
		Miracle_OpenLimit = 1, --����Ԫ��������Ե���˱�� 0:������ 1:����
		Gem_OpenLimit = 1, --����Ԫ�������䱦���˱�� 0:������ 1:����
	}
	--����ģ���������ƿ���table�ṹ
}

--��ȡģ������ϸ��
function Get_MoudelLimitDetail(moudel, part)
	look(moudel.." "..part)
	if system_switch[moudel] == nil then
		return 0
	end
	return system_switch[moudel][part]
end