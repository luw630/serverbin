function AttackMonsterScript()
	--local mon_type = GetMonsterData(8)
	--local boss_type = GetMonsterData(5)
	--local conf = 怪物事件配置表[mon_type ]
	--if nil~=conf then
		--AttackMonsterHpEvent(conf)
		--AttackMonsterBuffEvent(conf)
	--end
	--rfalse(boss_type)
--	if (2 == boss_type) then
	--	rfalse("boss_type")
		--local monstername=GetMonsterData(3);
		--SendBoardCastMsg("老子是"..monstername..":阿弥陀佛！你不入地狱，谁入地狱！！")
	--end
end

function AttackMonsterHpEvent( conf )
	if type({})==type(conf.hp) then
		for _, v in pairs(conf.hp) do
			if type(v)==type({}) and #v==2 then
				MonsterAddHpEvent(v[1], v[2])
			end
		end
	end
end

function AttackMonsterBuffEvent( conf )
	if type({})==type(conf.buff) then
		for _, v in pairs(conf.buff) do
			MonsterAddBuffEvent(v[1], v[2])
		end
	end
end

function hpevt_test()
	rfalse("+++         hpevt_test +++++++++++++")
end

function buffevt_test()
	rfalse("+++++++++  buffevt_test    +++++++++++")
end