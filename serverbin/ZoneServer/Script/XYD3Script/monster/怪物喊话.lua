-- ========================
-- ���ﺰ��˵��
-- 1 ���������������һ�κ���
		-- OnMonsterBirth+����ID
	-- SendBoardCastMsg���Է���ȫ��ͨ��
	-- GetMonsterData(3)��ȡ��������
	-- getattackername()��ȡɱ��������������
	-- �ַ������ӿ�����..�����ӣ����Բ������������
-- 2  ����������������һ�κ���
		-- OnMonsterDie+����ID
	-- �÷�ͬ��
	-- ������Ҫ�Ĺ�����������,��Ҫ����ű��������Բο�������Script/functionlist.ini
-- ========================
--[[
function OnMonsterBirth329(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("���ǽ����ٶ����������һ��λ������"..myname.."����˭���������ҵİ�Ƥ�޹���������")
		--rfalse("����"..myname.."��Ū����")
		i = i + 1
	end
end

function OnMonsterDie329(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("�����ٶ����������һ��λ������"..monstername.."���书׿����"..attatkername.."�����Ķ��ӣ���Я���ı�����һ�أ�");
		i = i + 1
	end
end

---------------------------------

function OnMonsterBirth330(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("���ǽ����ٶ���������ھ�ʮ��λ������һ����"..myname.."��������Щ������������ʶ���ҵ����ʮ����������")
		--rfalse("����"..myname.."��Ū����")
		i = i + 1
	end
end

function OnMonsterDie330(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("�����ٶ���������ھ�ʮ��λ������һ����"..monstername.."���书׿����"..attatkername.."�����Ķ��ӣ���Я���ı�����һ�أ�");
		i = i + 1
	end
end



---------------------
function OnMonsterBirth331(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("�Ϸ��ǽ����ٶ���������ھ�ʮ��λ�İ�а����"..myname.."���Ϸ������ʽ�����޵У���")
		--rfalse("����"..myname.."��Ū����")
		i = i + 1
	end
end

function OnMonsterDie331(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("�����ٶ���������ھ�ʮ��λ�İ�а����"..monstername.."���书׿����"..attatkername.."�����Ķ��ӣ���Я���ı�����һ�أ�");
		i = i + 1
	end
end

-------------------------------

function OnMonsterBirth328(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("�Ϸ��ǽ����ٶ���������ھ�ʮ��λ�ĺ����ɾ�"..myname.."�������Ϸ�İ��ѱʺ�ɨ���������������˭������ս����")
		--rfalse("����"..myname.."��Ū����")
		i = i + 1
	end
end

function OnMonsterDie328(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("�����ٶ���������ھ�ʮ��λ�ĺ����ɾ�"..monstername.."���书׿����"..attatkername.."�����Ķ��ӣ���Я���ı�����һ�أ�");
		i = i + 1
	end
end


-----------------------------

function OnMonsterBirth333(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("�Ϸ��ǽ����ٶ���������ھ�ʮ��λ�ı�����"..myname.."����������Щ�������ǿ����ҵı��������֣���")
		--rfalse("����"..myname.."��Ū����")
		i = i + 1
	end
end

function OnMonsterDie333(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("�����ٶ���������ھ�ʮ��λ�ı�����"..monstername.."���书׿����"..attatkername.."�����Ķ��ӣ���Я���ı�����һ�أ�");
		i = i + 1
	end
end
--]]