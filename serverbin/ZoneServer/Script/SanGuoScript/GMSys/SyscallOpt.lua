Syscall_Path = tostring("Script\\Global\\SyscallData.ldb")      --用于保存系统公告数据。

--获取系统公告列表最后一个数据
function GetSyscallTailData()
    local NextSyscall = SyscallListDataHeader[4]
    if NextSyscall ~= nil then
        while NextSyscall[9] ~= nill do
            NextSyscall = NextSyscall[9]
        end
    end
    return NextSyscall
end

function InitSyscall()
    SyscallListDataHeaderHeader = LoadTable(Syscall_Path)
    if SyscallListDataHeader == nil then
        SyscallListDataHeader = {}  --系统公告表头，记录链表的大小等
        SyscallListDataHeader[1] = 0  --当前链表大小
        SyscallListDataHeader[2] = 1000  --公告最小ID
        SyscallListDataHeader[3] = 1001  --新增公告的ID

        SyscallListDataHeader[4] = nil  --指向第一个有效的公告数据
    end
    SyscallListDataHeaderTail = GetSyscallTailData()
end

InitSyscall()

--检测系统公告是否可以发送
function JudgeCanSendSyscallLoop()
    local CurSyscallData = SyscallListDataHeader[4]
    local CurTime = os.time()
    while CurSyscallData ~= nil do
        if CurTime <= CurSyscallData[6] and CurTime >= CurSyscallData[5] then
            --rfalse(tostring(CurSyscallData[10]) .. "   " .. tostring(CurSyscallData[5]) .. tostring(CurSyscallData[8]))
            local IsCanSendTime = math.mod(CurTime - CurSyscallData[5], CurSyscallData[8]) + 1
            if IsCanSendTime >= CurSyscallData[8] - 3 and IsCanSendTime <= CurSyscallData[8] then
                if CurSyscallData[10] == 0 then
                    CurSyscallData[10] = 1
                    SendSysCall(CurSyscallData[7], CurSyscallData[3], 0)
                end
            else
                if CurSyscallData[10] == 1 then
                    CurSyscallData[10] = 0
                end
            end
        end
        CurSyscallData = CurSyscallData[9]
    end
end

--向公告列表的末尾插入一个数据
function InsertDataByTail(OneSyscallInf)
    if OneSyscallInf ~= nil then
        if SyscallListDataHeaderTail ~= nil then
            SyscallListDataHeaderTail[9] = OneSyscallInf
            SyscallListDataHeaderTail = OneSyscallInf
        else
            SyscallListDataHeader[4] = OneSyscallInf
            SyscallListDataHeaderTail = OneSyscallInf
        end
        SyscallListDataHeader[1] = SyscallListDataHeader[1] + 1
        SyscallListDataHeader[3] = SyscallListDataHeader[3] + 1
    end
end

--更新一条公告数据
function UpdateOneSyscall(SyscallID, Theme, Data, RecordTime, StartTime, EndTime, TimesPerTimes, Interval)
    local CurSyscall = SyscallListDataHeader[4]
    while CurSyscall ~= nil do
        --找到并删除
        if CurSyscall[1] == SyscallID then
            OneSyscallInf[2] = Theme    --当前公告主题
            OneSyscallInf[3] = Data    --当前公告的内容
            OneSyscallInf[4] = RecordTime    --当前公告的记录时间
            OneSyscallInf[5] = StartTime    --当前公告的开始时间
            OneSyscallInf[6] = EndTime    --当前公告的结束时间
            OneSyscallInf[7] = TimesPerTimes    --当前公告每次发送的次数
            OneSyscallInf[8] = Interval    --当前公告发送间隔时间s
            return 1
        end
        PreSyscall = CurSyscall
        CurSyscall = CurSyscall[9]
    end
    return 0
end

--删除一条公告数据并调整列表
function DelDataBySyscallID(SyscallID)
    local PreSyscall = nil
    local CurSyscall = SyscallListDataHeader[4]
    while CurSyscall ~= nil do
        --找到并删除
        if CurSyscall[1] == SyscallID then
            if PreSyscall == nil then
                SyscallListDataHeader[4] = CurSyscall[9]
            else
                PreSyscall[9] = CurSyscall[9]
            end
            CurSyscall = nil
            SyscallListDataHeader[1] = SyscallListDataHeader[1] - 1
            return 1
        end
        PreSyscall = CurSyscall
        CurSyscall = CurSyscall[9]
    end
    return 0
end

function ExitSaveSyscallData()
    SaveTable(Syscall_Path, SyscallListDataHeader)
end


--创建公告信息
function CreateOneSyscall(Theme, Data, RecordTime, StartTime, EndTime, TimesPerTimes, Interval)
    local OneSyscallInf = {}
    OneSyscallInf[1] = SyscallListDataHeader[3]  --当前的系统公告ID
    OneSyscallInf[2] = Theme    --当前公告主题
    OneSyscallInf[3] = Data    --当前公告的内容
    OneSyscallInf[4] = RecordTime    --当前公告的记录时间
    OneSyscallInf[5] = StartTime    --当前公告的开始时间
    OneSyscallInf[6] = EndTime    --当前公告的结束时间
    OneSyscallInf[7] = TimesPerTimes    --当前公告每次发送的次数
    OneSyscallInf[8] = Interval    --当前公告发送间隔时间s
    OneSyscallInf[9] = nil   --指向下一条公告
    OneSyscallInf[10] = 0   --记录公告发送了几次
    InsertDataByTail(OneSyscallInf)
    return OneSyscallInf[1]
end

--获取系统公告数据
function GetSyscallMsgRecord(SocketPoint)
    SendSyscallList(SocketPoint, SyscallListDataHeader)
end

--增加系统公告数据
function AddSyscallMsg(SocketPoint, Theme, Data, TimesPerTimes, Interval, RecordTime, StartTime, EndTime)
    local SyscallID = CreateOneSyscall(Theme, Data, RecordTime, StartTime, EndTime, TimesPerTimes, Interval)
    if SyscallID ~= 0 then
        SendAddSyscallRes(SocketPoint, 1, SyscallID)
    else
        SendAddSyscallRes(SocketPoint, 0, 0)
    end
end

--更新公告数据
function UptSyscallMsg(SocketPoint, Theme, Data, TimesPerTimes, Interval, SyscallID, RecordTime, StartTime, EndTime)
    local iRet = UpdateOneSyscall(SyscallID, Theme, Data, RecordTime, StartTime, EndTime, TimesPerTimes, Interval)
    if iRet == 1 then
        SendUptSyscallRes(SocketPoint, 1)
    else
        SendUptSyscallRes(SocketPoint, 0)
    end
end

--删除公告数据
function DelSyscallMsg(SocketPoint, SyscallID)
    local iRet = DelDataBySyscallID(SyscallID)
    if iRet == 1 then
        SendDelSyscallRes(SocketPoint, 1)
    else
        SendDelSyscallRes(SocketPoint, 0)
    end
end

--通过公告ID获取公告内容
function GetSyscallContentByID(SocketPoint, SyscallID)
    local CurSyscall = SyscallListDataHeader[4]
    while CurSyscall ~= nil do
        --找到
        if CurSyscall[1] == SyscallID then
            SendSpecContent(SocketPoint, CurSyscall[3])
            return 1
        end
        PreSyscall = CurSyscall
        CurSyscall = CurSyscall[9]
    end

    SendSpecContent(SocketPoint, "")
end
