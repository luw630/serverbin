function ClickNpcCallBack(NpcID)	
	
	--rfalse("IP:"..GetPlayerIP().."")
	
	--ActiveSkill(107)
	rfalse("ClickNpcCallBack = "..NpcID.."")
	if NpcID  >=  1 and NpcID  <=  20000  then
		CommonNpcClick(NpcID)
	end
	if NpcID >= 20051 and NpcID <= 20070 then
		DailyClickNpc(NpcID)
	end

	if   NpcID  >=  20001 and NpcID  <=  200020 and GetTaskStatus(5) == 2 then	--ζ­’θ‘θ?
		CollectIt(NpcID)
	end
	if   NpcID  >=  20021 and NpcID  <=  20026 and GetTaskStatus(107) == 2 then	--ηΎεθ?
		CollectIt(NpcID)
	end
	if   NpcID  >=  20031 and NpcID  <=  20036 and GetTaskStatus(111) == 2 then	--ηιη?
		CollectIt(NpcID)
	end
	if   NpcID  >=  20041 and NpcID  <=  20046 and GetTaskStatus(114) == 2 then	--ηιη?
		CollectIt(NpcID)
	end
end

