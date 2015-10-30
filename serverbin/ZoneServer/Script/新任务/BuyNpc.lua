-- this is a sample script file 
-- 主要处理玩家和NPC的交易
-------------------------------------------------------------------------------------

YGoods = {
           21, 22,  23,  92,24, 
           25, 26,91, 27,  28,
           29,8176,8177,8178,8179,8180,8181,8182,6576
         } 

ZGoods = {

         }

WGoods = {
   
         }
           

RGoods = { 0 }
RGoods1 = { 0 }
RGoods2 = { 0 }
GGoods1 = { 0 }
GGoods2 = { 0 }
BGoods1 = { 0 }
BGoods2 = { 0 }
EGoods1 = { 0 }
EGoods2 = { 0 }
MGoods1 = { 0 }
MGoods2 = { 0 }
-- initialize the npc's goodspackage --------------------------
function InitGoodsPackage(table1, table2, table3, who)
        Zero(who)
        for k, v in ipairs(table1) do
            LoadItem(v,1, who)
        end  
        for k, v in ipairs(table2) do
            LoadItem(v,2, who)
        end
        for k, v in ipairs(table3) do
            LoadItem(v,3, who)
        end
end

-- exchange --------------------------------------------------
         

-- out message -----------------------------------------------------------
rfalse("load BuyNpc.lua OK!")
