Transformers_Max = 3   --最大变身
Transformers_MaxLevel = 100         --变身最高等级

function OnTransformersInfo(bTransformerIndex) --请求变身信息
    if bTransformerIndex > 0 and bTransformerIndex < Transformers_Max then
        local TransformersState = GetPlayerData(0,GPP_TRANSFORSTATE) --玩家变身状态
        local gid = GetPlayerData(0,GPP_QUANJUGID)
        --if TransformersState > 0 then
        local tlevel = GetTransformersLevel(bTransformerIndex)
        local TransformersInfo = GetTransformersInfo(bTransformerIndex,tlevel+1,gid)
        if TransformersInfo ~= nil then
            OnSendTransformersInfoMsg(TransformersInfo)
            return 
        end
        --end
    end

    rfalse("OnTransformersInfo:Error")
end

function GetTransformersInfo(bTransformerIndex,blevel,gid)
    local maxhp = GetPlayerData(gid,GPP_MAXHP)
    --rfalse("GetTransformersInfo blevel = "..blevel.."")
    if blevel > TransformersConfig_MaxSize then
        rfalse("Config_MaxSize < "..blevel.."")
        return
    end
    if TransformersConfig ~= nil and maxhp ~= nil and TransformersConfig[bTransformerIndex] ~= nil then
       -- rfalse("tablelen = "..GetTableLenth(TransformersConfig[bTransformerIndex].HpValue).."")
        local tformersConfig = {}
        tformersConfig.needmaterial = TransformersConfig[bTransformerIndex].needmaterial[blevel]
        tformersConfig.needmaterialnum = TransformersConfig[bTransformerIndex].needmaterialnum[blevel]
        tformersConfig.HpValue = TransformersConfig[bTransformerIndex].HpValue[blevel] / 10000 * maxhp
        tformersConfig.money = TransformersConfig[bTransformerIndex].money[blevel]
        if TransformersConfig[bTransformerIndex].HpValue[blevel+1] ~= nil then
            tformersConfig.HpnextValue = TransformersConfig[bTransformerIndex].HpValue[blevel+1] / 10000 * maxhp
        else
             tformersConfig.HpnextValue = TransformersConfig[bTransformerIndex].HpValue[blevel] / 10000 * maxhp
       end
        return tformersConfig
    end
    return nil
 end

function OnTransformersSwitch(bTransformerIndex) --请求变身切换
    local tlevel = GetTransformersLevel(bTransformerIndex)
    local gid = GetPlayerData(0,GPP_QUANJUGID)
     --rfalse("OnTransformersSwitch : bTransformerIndex = "..bTransformerIndex.."  tlevel = "..tlevel.."")
    if tlevel > 0 then
        local tlevelstate = GetTransformersLevel(0) --获取当前变身状态
        if tlevelstate ~= bTransformerIndex then
            if bTransformerIndex >= 0 and bTransformerIndex < Transformers_Max then
                SetTransformersLevel(0,bTransformerIndex)
                --OnTransformersProperty(bTransformerIndex,tlevel)        --变身更改属性
                SendMyState(gid)
                SendTransformersSwitch(1)           --发送变身成功
                OnTaskCallBack(TASK_TRANSFORMERS,1,0)
                return
            end
        end

    end
    SendTransformersSwitch(0)           --发送变身失败
    rfalse("OnTransformersSwitch: Faile tTransformersLevel = "..tlevel.."")
end

function OnTransformersProperty(bTransformerIndex,tlevel) --变身更改属性
    local gid = GetPlayerData(0,GPP_QUANJUGID)
    local tformersConfig = GetTransformersInfo(bTransformerIndex,tlevel ,gid)
    if tformersConfig ~= nil then
          if bTransformerIndex == 0 then  --原始
            InitPlayerProperty(gid)
          elseif bTransformerIndex == 1 or bTransformerIndex == 2 then
            InitPlayerProperty(gid)
            local TransHp = tformersConfig.HpValue
            local maxhp = GetPlayerData(gid,GPP_MAXHP)
           -- TransHp = TransHp - maxhp
            SetObjectData(gid,GPP_MAXHP,TransHp)
            SetObjectData(gid,GPP_CURHP,TransHp)
         end
    end

end

function OnTransformersInit(bTransformerIndex) --请求请求变身激活，升级
    local tlevel = GetTransformersLevel(bTransformerIndex)
    if tlevel + 1 > Transformers_MaxLevel then
        rfalse("OnTransformersInit: Top level ")
        return
    end
    rfalse("OnTransformersInit = "..tlevel.."")
    local gid = GetPlayerData(0,GPP_QUANJUGID)
    local tformersConfig = GetTransformersInfo(bTransformerIndex,tlevel + 1,gid)
    if tformersConfig ~= nil and bTransformerIndex > 0 and bTransformerIndex < Transformers_Max then
        local maternum = GetItemNum(tformersConfig.needmaterial)
        if maternum < tformersConfig.needmaterialnum then
            rfalse("OnTransformersInit:needmaterial notenough")
            return
        end

         local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
         if playermoney < tformersConfig.money then
             rfalse("OnTransformersInit:playermoney notenough")
            return
         end

         if tlevel < 1 then
            if GetBlankCell() < 1 then
                rfalse("OnTransformersInit:player bag notenough")
                return
            end
         end

        local isdel = DeleteItem(tformersConfig.needmaterial,tformersConfig.needmaterialnum) --删除道具
        if isdel == 0 then
            rfalse("DeleteItem Error")
            return
        end
        ChangeMoney(2,-tformersConfig.money)      --扣钱
        SetTransformersLevel(bTransformerIndex,tlevel + 1) --更新当前变身等级
        SendMyState(gid)
        OnTransformersInfo(bTransformerIndex)

        if tlevel < 1 then  --第一次激活变身
            local sckool = GetPlayerData(0,GPP_SCHOOL)
            if sckool ~= nil and TransformersEquipt[school] ~= nil then
                local tequipt = TransformersEquipt[school]
                if tequipt[bindex] ~= nil then
                    local itempos = AddItem(tequipt[bindex])
                    if itempos >= 0 then
                        RecvUseItem(itempos)    --装备
                    end  
                end
            end
        end

    end
end


function GetTransformersSkillInfo(bTransformerIndex) --技能变身相关信息
     local tlevel = GetTransformersLevel(bTransformerIndex)
     if tlevel > 0 and TransformersSkill[bTransformerIndex] ~= nil then
        local  Skilltable = TransformersSkill[bTransformerIndex]
        local sformersSkillInfo = {}
        local skilllevle = GetSkillLevel(Skilltable.godskillIndex)
        if skilllevle > 0 then
            sformersSkillInfo.currentSkillExp = GetSkillProficiency(Skilltable.godskillIndex)  --当前熟练度
            sformersSkillInfo.levelUpSkillExp = Skilltable.levelUpSkillExp[skilllevle]          --升级熟练度
            sformersSkillInfo.CurrentTriggerate = Skilltable.CurrentTriggerate[skilllevle]          --当前触发几率
            if skilllevle + 1 > TransformersSkill_MaxLevel then
              sformersSkillInfo.LevelUpTriggerate = Skilltable.CurrentTriggerate[skilllevle]          --升级触发几率
           else
             sformersSkillInfo.LevelUpTriggerate = Skilltable.CurrentTriggerate[skilllevle+1]          --升级触发几率
           end
            sformersSkillInfo.skillCurrentdamage = Skilltable.damage[skilllevle]          --当前伤害
            if skilllevle + 1 > TransformersSkill_MaxLevel then
                sformersSkillInfo.skillLevelUpdamage = Skilltable.damage[skilllevle]          --升级伤害
            else
                sformersSkillInfo.skillLevelUpdamage = Skilltable.damage[skilllevle+1]          --升级伤害
            end
            sformersSkillInfo.silveritem = Skilltable.silveritem          --银币道具
            sformersSkillInfo.goditem = Skilltable.goditem          --金币道具
            sformersSkillInfo.CurrentLevel = skilllevle          --当前技能等级
            sformersSkillInfo.SkillIndex = Skilltable.godskillIndex          --当前技能index
            return sformersSkillInfo
        end
     end
     return nil
end

function OnTransformersSkillInfo(bTransformerIndex)--请求技能变身相关信息
    local sformersSkillInfo = GetTransformersSkillInfo(bTransformerIndex)
    if sformersSkillInfo ~= nil then
        --printtable(sformersSkillInfo)
        SendTransformersSkillInfo(sformersSkillInfo)
    end
end