NPC���������б� = {
	[1] = {1},
}
--�����ֿ�ʹ�õĵ���ר��id�Ŷ�
�������߱� = {{10002,10002},{10182,10182},{10362,10362},{10542,10542},{10722,10722},{30006,30006}}
�������� = {
	[1] = {
		�������� = '��ɽ�۽�',
		���� ='��ɽ�۽���ʮ��֮�ڵ������������������ֻ���������׷��յ�������Ӣ����������ʮ��ʮ�ջ�ɽ�嶥���Խ���������ѧ�ߵͣ��ڸ�����ۻ�ɽ��ֻΪ���ǵ�����һ���ֵ����ţ�ȴ��֪���������Ѱ��������ֻ���������㣬����׽���ʱ��ɽ����һ��ɽҡ�ض����ۿ���������ı�óѣ�ɽ�������Ѱ��಻ס�ĸ����ɵ��������һ��ӿ�ϻ�ɽ�嶥��',
		������� = '��ϲ���³ɹ����ػ�ɽ�۽���������',
		
		��ʾ�ȼ����� = 10,		
		ÿ�������� = 300,
		�������= 5,
		����ʱ�� = {
			��ʼ = { hour = 00, min = 00, sec = 0 }, 
			���� = { hour = 23, min = 59, sec = 59 },
			},
		ʱ������=60,
		��ͼ�� = {
			{
				��ͼ��� = 73,
				��ת�� = {					
				},
				NPC�б� = {
					[1]={regionId = 73,name="���ϴ�",title="�ֿ�С��", imageId = 26,  x = 10, y = 19, dir = 5, objectType = 1, controlId = 400005,clickScript=30000},
					[2]={regionId = 73,name="���˵���",title="", imageId = 26,  x = 12, y = 24, dir = 5, objectType = 1, controlId = 400006,clickScript=30000},
				},
				�����б� = {
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 14, y = 175,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 12, y = 167,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 13, y = 159,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 12, y = 149,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 10, y = 119,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 12, y = 119,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 14, y = 119,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 18, y = 120,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�������̴�', monsterId = 41, imageId = 1,  x = 21, y = 121,  deadScript = 1, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�����˻���', monsterId = 42, imageId = 1,  x = 15, y = 60,  deadScript = 2, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '�����˻���', monsterId = 42, imageId = 1,  x = 20, y = 60,  deadScript = 2, refreshTime = -1, dir = 3, objectType = 0, aiType=4 },
					{ name = '������', monsterId = 43, imageId = 1,  x = 15, y = 25,  deadScript = 3, refreshTime = -1, dir = 3, objectType = 0 },
				},
				����� = {regionId=73,x=15,y=22},
			},
		},
		�ֿ� = {
			NPC=1,
			����={{10002,1},{10182,1}, {10362,1},{10542,1},{10722,1},{30006,1}},
		},
		��ʼλ���б� = {
			{ ��ͼ��� = 73, x = 14, y = 209 },
			{ ��ͼ��� = 73, x = 15, y = 209 },
			{ ��ͼ��� = 73, x = 16, y = 209 },
			{ ��ͼ��� = 73, x = 17, y = 209 },
			{ ��ͼ��� = 73, x = 18, y = 209 },
		},

		׼������ = {
			�ȼ� = 10,	--����ȼ�����
			��Ǯ = 0,
			���� = {{id=4024,num=1,name='Ӣ����'},
				},
		},
		
		���Ŀ�� = "���������˱�����ı: %\031������",
		������� = {
			�������� = { 
				[2]={name="�����˻���",id=2,num=2},
				[3]={name="������",id=3,num=1},
			},
		},
			
		���� = {
			Exp = 1000,
			Money = 10000,
			ItemList = {
				{ ���� = { 0, 20 }, ��ƷID = 10010, ���� = { 1, 1 } },
				{ ���� = { 20,40 }, ��ƷID = 10190, ���� = { 1, 1 } },
				{ ���� = { 40,60 }, ��ƷID = 10370, ���� = { 1, 1 } },
				{ ���� = { 60,80 }, ��ƷID = 10550, ���� = { 1, 1 } },
				{ ���� = { 80,100 }, ��ƷID = 10730, ���� = { 1, 1 } },
			}
		},
	},
}

����NPC = ����NPC or {
	--[id] : controlId - 400000
	[5]={ talk='����������֮�����ڴ����λ���������ṩ�����������ı���Ʒ����ҩ�������װ����ͭ��Ӧ�о��У�����ѡ�á�#�򿪲ֿ⡣#��ʱû����Ҫ��#', 		
			ClickMenu=function(index)
				if index==1 then
					local sid = GetPlayerData(17)		
					local csTemp = CS_GetPlayerTemp(sid)	
					local copySceneGID = csTemp.CopySceneGID
					local copyScene = CS_GetData(copySceneGID)
					local storyhome = copyScene.Storage
					--����Ϣ���ͻ���,��ʼ�������ֿ�
					SendLuaMsg(0, { ids = {4,100}, data = storyhome }, 9 )
				end
			end,
		},
	[6]={ talk='���ȥ��? ��-��-��-��-��, ����10000��! #���͸���#��û��Ǯ��#',
			ClickMenu=function(index) 
				if index==1 then
					local teamInfo = GetTeamInfo()
					if teamInfo ~= nil then
						local teamID = GetPlayerData(12)
						local playerSID = GetPlayerData(17)
						DeleteTeamMember(teamID, playerSID)
					end	
					CS_DoExit()
					CS_Back( playerSID )
					return
				end
			end,
		},
} 