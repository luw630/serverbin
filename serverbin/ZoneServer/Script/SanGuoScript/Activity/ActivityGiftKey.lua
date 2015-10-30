local GifKeyItem =   --激活码礼包对应的道具，数据local本地化，防止重命名是出错
{
	{
	  filename = "giftkey1",          --礼包文件名
	  gifttype = "giftcode",         --礼包类型
	  item = {20011,2,20001,5,20017,5}, --道具
	  gold = 50,   --元宝
	  money = 10000,  --游戏币
	  hero = {},  --武将
	  giftkeytime = {20150831,20171031},
	},

	{
	  filename = "giftkey2",
	  gifttype = "giftcode2",
	  item = {20011,2,20001,10,20017,10}, --道具
	  gold = 100,   --元宝
	  money = 50000,  --游戏币
	  hero = {},  --武将
	  giftkeytime = {20150831,20171031},
	},

	{
	  filename = "giftkey3",
	  gifttype = "giftcode3",
	  item = {20011,2,20002,5,20017,20}, --道具
	  gold = 300,   --元宝
	  money = 200000,  --游戏币
	  hero = {},  --武将
	  giftkeytime = {20150831,20171031},
	},

	{
	  filename = "giftkey4",
	  gifttype = "giftcode4",
	  item = {20001,500,20010,500}, --道具
	  gold = 20000,   --元宝
	  money = 1000000,  --游戏币
	  hero = {},  --武将
	  giftkeytime = {20150831,20171031},
	},

	{
	  filename = "giftkey5",
	  gifttype = "giftcode5",
	  item = {20011,3,20010,300}, --道具
	  gold = 3000,   --元宝
	  money = 300000,  --游戏币
	  hero = {},  --武将
	  giftkeytime = {20150922,20161031},
	},

	{
	  filename = "giftkey6",
	  gifttype = "giftcode6",
	  item = {20011,5,20010,500}, --道具
	  gold = 5000,   --元宝
	  money = 500000,  --游戏币
	  hero = {},  --武将
	  giftkeytime = {20150922,20161031},
	},

	-- {
	--   filename = "giftkey",
	--   item = {11304,1,11104,1,11204,1,11503,1,11403,1},
	--   giftkeytime = {20150831,20151031},
	-- },

	-- {
	--   filename = "giftkey",
	--   item = {11304,1,11104,1,11204,1,11503,1,11403,1},
	--   giftkeytime = {20150831,20151031},
	-- },

}

GiftKeyActivity =  Activitymodule:new()
GiftKeyActivity:Init(7)
ActivityRegister(GiftKeyActivity)
local GiftCodeManager = GiftKeyActivity:LoadData()	--玩家的聚宝盆数据
local giftfilename = tostring("ServerConfig\\giftcode\\")


function GiftKeyActivity:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	--self:ChargeGiveItem(100,1000)
end


function LoadGiftFile()
	--look("LoadGiftFile")
	local file = nil
	local nlinenum = 0
	for i,v in ipairs(GifKeyItem) do
		local giftstr = v.filename
		if GiftCodeManager[giftstr] == nil then
			GiftCodeManager[giftstr] = {}
		end
		v.filename = giftfilename..v.filename..".txt"
		file = io.open(v.filename,"r")
		
		if file ~= nil then
			for line in file:lines() do 
				line = string.sub(line,1,16)
				if GiftCodeManager[giftstr][line] == nil then
					GiftCodeManager[giftstr][line] = {}
					GiftCodeManager[giftstr][line] = deepcopy(v)
					-- GiftCodeManager[giftstr][line].item = v.item
					-- GiftCodeManager[giftstr][line].giftkeytime = v.giftkeytime
					GiftCodeManager[giftstr][line].Isvalid = 1
					nlinenum = nlinenum + 1
				end
			end
			io.close(file)
		end
	end
	
	if nlinenum > 0 then
		look("LoadGiftFile  Add  New num "..nlinenum)
	end

	local giftmodule = ActivityGetmodulebyIndex(1007)  --自己的活动ID，可以定义为枚举方便识别
	if giftmodule ~= nil then
		giftmodule:SaveData(GiftCodeManager)
	end
end

function ReloadGiftFile()
	g_giftInitLoad = false
	InitGiftManager()
end

function InitGiftManager( )
	if g_giftInitLoad == nil or g_giftInitLoad == false  then
		if GiftCodeManager == nil then
			GiftCodeManager = {}
		end
		LoadGiftFile()
		g_giftInitLoad = true
	end
end


function OnActivityCode( sid,strcode  )
	local nowday = tonumber(os.date("%Y%m%d",os.time()))
	local codeitem = nil
	for k,v in pairs(GiftCodeManager) do
		if v[strcode] ~= nil then
			codeitem = v[strcode]
			break
		end
	end

	if codeitem == nil then
		look("giftcode not found")
		return false,nil
	end

	if codeitem.Isvalid == 0 then
		look("ActivityCode Isvalid")
		return false,nil
	end

	if codeitem.giftkeytime[1] > nowday or nowday > codeitem.giftkeytime[2] then --判断时间有效性
		look("giftkeytime pass")
		return false,nil
	end

	if bCanGetGift(sid,codeitem.gifttype) == false then
		look("bCanGetGift == false ")
		return false,nil
	end
	return true,codeitem
end

function OnActivityGiftCode(sid,strcode )
	--look("OnActivityGiftCode  "..strcode)
	strcode = string.sub(strcode,1,16)
	--look("OnActivityGiftCode  "..strcode)
	local bresult = 0
	local bCanActivity,codeitem = OnActivityCode(sid,strcode)
	local sendlist = {}
	if bCanActivity == true and codeitem ~= nil then
		local bisgetgift = 1
		if codeitem.item ~= nil then
			local item = codeitem.item
			for i=1,#item/2 do
				local id = i *2 -1
				local num = id+1
				if CI_AddGoods_SG(3,item[id],item[num],0,sid) == nil then
					look("OnActivityGiftCode nil "..item[id].."    "..item[num])
					bisgetgift = 0
				end
				local temp = {itype = 3,inum = item[num],iindex = item[id]}   --类型s，数量, ID
				table.insert(sendlist,temp)
			end
		end

		if codeitem.gold ~= nil then
			look(" codeitem.gold  "..codeitem.gold)
			if CI_AddGoods_SG(2,0,codeitem.gold) == nil then
				look("OnActivityGiftCode gold nil")
				bisgetgift = 0
			end
			if bisgetgift > 0 then
				local temp = {itype = 2,inum = codeitem.gold,iindex = 0}   --类型s，数量, ID
				table.insert(sendlist,temp)
			end
		end

		if codeitem.money ~= nil then
			look(" codeitem.money  "..codeitem.money)
			if CI_AddGoods_SG(1,0,codeitem.money) == nil then
				look("OnActivityGiftCode money nil")
				bisgetgift = 0
			end
			if bisgetgift > 0 then
				local temp = {itype = 1,inum = codeitem.money,iindex = 0}   --类型s，数量, ID
				table.insert(sendlist,temp)
			end
		end

		if codeitem.hero ~= nil then
			local herolist = codeitem.hero
			for i=1,#herolist/2 do
				local id = i *2 -1
				local num = id+1
				if CI_AddGoods_SG(4,herolist[id],herolist[num],0,sid) == nil then
					look("OnActivityGiftCode nil "..herolist[id].."    "..herolist[num])
					bisgetgift = 0
				end
				if bisgetgift > 0 then
					local temp = {itype = 4,inum = herolist[num],iindex = herolist[id]}   --类型s，数量, ID
					table.insert(sendlist,temp)
				end
			end
		end

		if bisgetgift > 0 then
			codeitem.Isvalid = 0
			bresult = 1
			UpdataGiftData(sid,codeitem.gifttype)
			local giftmodule = ActivityGetmodulebyIndex(1007)  --自己的活动ID，可以定义为枚举方便识别
			if giftmodule ~= nil then
				giftmodule:SaveData(GiftCodeManager)
			end
		end
	end
	SendActivityCodeResult(sid,bresult,sendlist)
	if bresult > 0 then
		look(sendlist)
	end
end

function GetGiftCodeNum( giftstr)
	local num = 0
	if GiftCodeManager[giftstr] ~= nil then
		for k,v in pairs(GiftCodeManager[giftstr]) do
			num =num + 1
		end
		look(num)
	else
		look("GetGiftCodeNum nil"..giftstr)
	end
end

function bCanGetGift( sid, gifttype)
	look(sid)
	local giftdata = LoadLuaData(sid,gifttype)
	assert(giftdata ~= nil," bCanGetGift giftdata == nil")
	if giftdata ~= nil then
		if giftdata.IsGot == nil then
			giftdata.IsGot = 0 
		else
			--look("bCanGetGift == false ")
			return false
		end
	end
	
	look("bCanGetGift == true ")
	SaveLuaData(sid,gifttype,giftdata)
	return true
end

function UpdataGiftData( sid, gifttype )
	local giftdata = LoadLuaData(sid,gifttype)
	if giftdata ~= nil then
		if giftdata.IsGot ~= nil  then
			 giftdata.IsGot = 1
		else
			giftdata.IsGot = 1
		end
		SaveLuaData(sid,gifttype,giftdata)
	end
end

function PrintGift( giftstr)
	look(string.len(giftstr))
	for k,v in pairs(GiftCodeManager) do
		if v[giftstr] ~= nil then
			look(v[giftstr])
		end
	end
end

function ShowNum(  )
	local Isvalidnum = 0
	for k,v in pairs(GiftCodeManager) do
		for i,j in pairs(v) do
			Isvalidnum = Isvalidnum + 1
		end
	end
	look("ShowIsvalidNum  "..Isvalidnum)
end

function ShowIsvalidNum(  )
	local Isvalidnum = 0
	for k,v in pairs(GiftCodeManager) do
		for i,j in pairs(v) do
			if j.Isvalid > 0 then
				Isvalidnum = Isvalidnum + 1
			end
		end
	end
	look("ShowIsvalidNum  "..Isvalidnum)
end

InitGiftManager()
--Init()
--GetGiftCodeNum("giftkey")
--GetGiftCodeNum("giftkey2")


