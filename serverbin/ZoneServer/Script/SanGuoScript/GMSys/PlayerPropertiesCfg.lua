function ChangePlayerProperties(gid, playerlevel, yinbi, jinbi, glorydot, sp)
    SetPlayerVipLevel(playerlevel)
    SetPlayerObject(gid)
    ChangeMoney(1, jinbi)
    ChangeMoney(2, yinbi)
    changeglorydot(gid, glorydot)
    GiveSp(sp)
end