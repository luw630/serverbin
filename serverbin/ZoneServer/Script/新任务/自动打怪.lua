CreateNpc(6,"�Զ����",1,104,149,0,0,0,10497,0,3,710)


function OnClick10497()
	--SetMessage(92288,"�Զ���֡�������������#��ʼ�Զ����#�ҵ����#",0,0)
	SetMessage(92288,"�Զ���֡�������������#�����书����#�Ṧ����#��������#�ķ�����#�ҵ����#",0,0)
end

function ClickMenu92288(index)
 ----[[
	if(index == 1) then
		PutPlayerTo(5, 40, 20, 0)
		CreateObjectIndirect( { regionId = 5,name = "���Թһ���", monsterId=8, imageId = 7,  x =40, y = 25,  deadScript = 5000, dir = 3,objectType = 0 , controlId = 11709,damage = 0})
	elseif(index == 2) then
		PutPlayerTo(2, 40, 20, 0)
	elseif(index == 3) then
		PutPlayerTo(3, 10, 105, 0)
		CreateObjectIndirect( { regionId = 3,name = "���Ի���һ���", monsterId=8, imageId = 7,  x =12, y = 106,  deadScript = 5000, dir = 3,objectType = 0 , controlId = 11780,damage = 0,wAIType = 4})
	elseif(index == 4) then 
		PutPlayerTo(4, 40, 20, 0)
	end
	--]]
	--PutPlayerTo(5, 40, 20, 0)
   -- CreateMonster(6,"���Թһ���",1,5000,0,106,153,0,0,0,0,11709,11709,6)
  
   
	--CreateObjectIndirect( { regionId = 6,name="���Թһ���",title="����",imageId = 26,  x = 102, y = 148,  clickScript = 7089, dir = 5,objectType = 0, controlId = 5020})
end

function ZidongDaguaiFun1()


end