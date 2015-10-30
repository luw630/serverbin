CreateNpc(6,"自动打怪",1,104,149,0,0,0,10497,0,3,710)


function OnClick10497()
	--SetMessage(92288,"自动打怪。。。。。。！#开始自动打怪#我点错了#",0,0)
	SetMessage(92288,"自动打怪。。。。。。！#基本武功修炼#轻功修炼#护体修炼#心法修炼#我点错了#",0,0)
end

function ClickMenu92288(index)
 ----[[
	if(index == 1) then
		PutPlayerTo(5, 40, 20, 0)
		CreateObjectIndirect( { regionId = 5,name = "测试挂机怪", monsterId=8, imageId = 7,  x =40, y = 25,  deadScript = 5000, dir = 3,objectType = 0 , controlId = 11709,damage = 0})
	elseif(index == 2) then
		PutPlayerTo(2, 40, 20, 0)
	elseif(index == 3) then
		PutPlayerTo(3, 10, 105, 0)
		CreateObjectIndirect( { regionId = 3,name = "测试护体挂机怪", monsterId=8, imageId = 7,  x =12, y = 106,  deadScript = 5000, dir = 3,objectType = 0 , controlId = 11780,damage = 0,wAIType = 4})
	elseif(index == 4) then 
		PutPlayerTo(4, 40, 20, 0)
	end
	--]]
	--PutPlayerTo(5, 40, 20, 0)
   -- CreateMonster(6,"测试挂机怪",1,5000,0,106,153,0,0,0,0,11709,11709,6)
  
   
	--CreateObjectIndirect( { regionId = 6,name="测试挂机怪",title="少林",imageId = 26,  x = 102, y = 148,  clickScript = 7089, dir = 5,objectType = 0, controlId = 5020})
end

function ZidongDaguaiFun1()


end