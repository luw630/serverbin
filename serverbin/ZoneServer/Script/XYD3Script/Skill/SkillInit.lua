--dofile("XYD3Script\\Skill\\��������.lua")
--dofile("XYD3Script\\Skill\\��ɽ����.lua")
--dofile("XYD3Script\\Skill\\���ּ���.lua")
--dofile("XYD3Script\\Skill\\�Ⱥ�����.lua")
--dofile("XYD3Script\\Skill\\���¼���.lua")
--dofile("XYD3Script\\Skill\\���ü���.lua")
dofile("XYD3Script\\Skill\\�ķ�.lua")
dofile("XYD3Script\\Skill\\playerskill.lua")
dofile("XYD3Script\\Skill\\monsterskill.lua")
dofile("XYD3Script\\Skill\\skillhurtconfig.lua")
dofile("XYD3Script\\Skill\\HurtCalculate.lua")
dofile("XYD3Script\\Skill\\skill.lua")


function CheckAttackByClient(DefencerID,SkillID,SkillSubProperty)
  -- ���·������֤
	CheckWindMove(SkillSubProperty,DefencerID,SkillID)		
end


function InAttackBefore(DefencerID, SkillID,SkillSubProperty)
  -- ��ʼ���
	StartWindMove(SkillSubProperty,DefencerID,SkillID)		
end


function InAttackSkill(DefencerID, SkillID)
  if (2008 == SkillID) then		--��ɽ:�򽣾�
		return
	end
	
	SendAttackMsg();	
end

