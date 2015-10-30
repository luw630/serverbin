local GMManager = 
{
    {Name = "222", Pwd = "222",},
}


function LoginGM( UserName, UserPwd)
    for n, v in pairs(GMManager) do
        local NameSize = string.len(v.Name)
        local NameStartPos, NameEndPos = string.find(v.Name, UserName)
        if NameStartPos == 1 and  NameSize == NameEndPos then
            local PwdSize = string.len(v.Pwd)
            local PwdStartPos, PwdEndPos = string.find(v.Pwd, UserPwd)
            if PwdStartPos ~= 1 or  PwdSize ~= PwdEndPos then
                --密码不正确
              --  CI_SendLoginGMRes(SocketPoint, -2)
                return 2
            end

            if PwdStartPos == 1 and  PwdSize == PwdEndPos then
                --登陆成功
               -- CI_SendLoginGMRes(SocketPoint, 1)
                return 1
            end
        end
    end
    --用户名不正确
	return 3
    --CI_SendLoginGMRes(SocketPoint, -1)
end


-- gm取注册人数
function CALLBACK_registerNum(result)
	CI_gm_registerNum(result)
end
-- gm取30日留存
function CALLBACK_gmgetStayAll(allreg,_out_res1,_out_res2,_out_res3,_out_res4,_out_res5,_out_res6, _out_res7, _out_res14,_out_res21,_out_res30)
	CI_gm_stayAll(allreg,_out_res1,_out_res2,_out_res3,_out_res4,_out_res5,_out_res6, _out_res7, _out_res14,_out_res21,_out_res30)
end
-- gm取单日留存
function CALLBACK_gmgetStayOne(allreg,num)
	CI_gm_stayOne(allreg,num)
end
-- gm取在线玩家数量
function CALLBACK_gmgetOnline(result)
    look("CALLBACK_gmgetOnline "..result)
	if result==nil then 
		CI_gm_online({})
		return
	end
	result.rows=nil
	result.cols=nil
	result.type=nil
	CI_gm_online(result)
end
-- gm取充值数据
function CALLBACK_gmgetRecharge(result)
    look("CALLBACK_gmgetRecharge")
	look(result)
end
--gm取流失数据
function CALLBACK_gmgetleavedata(itype,num,res)
	CI_gm_leave(itype,num,res)
end
function CALLBACK_gmgetpointuse(res)
	CI_gm_pointuse(res)
end
--gm取后台功能数据
function CALLBACK_gmoperation(itype,_out_res1,_out_res2,_out_res3,_out_res4,_out_res5,_out_res6)
	CI_gm_operation(itype,_out_res1,_out_res2,_out_res3,_out_res4,_out_res5,_out_res6)
end
--取玩家时间段内充值  itype用于回调区分,例如单日充值活动=1,3日=2,历史=3等
function CALLBACK_getRecharge(sid,itype,res)
    look(" CALLBACK_getRecharge "..sid.."    "..itype.."     "..res)
end
--取玩家时间段内消费  itype用于回调区分,例如单日充值活动=1,3日=2,历史=3等
function CALLBACK_geExpense(sid,itype,res)
     look(" CALLBACK_geExpense ")
end