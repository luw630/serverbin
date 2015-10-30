function OpenConfirmDestroyItemWnd( itemHandle, itemName )

	wndConfirmDestroyItem = 
	{
		pos		= "0,0", 
		size	= "800,600",
		
		image_1	= "265,203,interface/okcancel/系统提示菜单.spr",

		text_2 = "314,235,[%4"..itemName.."%0]\n是否%1销毁%0此道具？,12",			-- 最后一个参数是使用的字号，可默认为12
		
		SprButton_1 = { pos = "300,300", image = "Interface/okcancel/确定", onkey = 13, action = "@rc,1,@E" },	-- 返回常量数字1后关闭窗口！
		SprButton_2 = { pos = "470,300", image = "Interface/okcancel/取消", action = "@E" },			-- 直接关闭窗口，不返回消息，即取消销毁道具
	}

	WndCustomize( wndConfirmDestroyItem, "ResultConfirmDestroyItemWnd", itemHandle, itemName )
	
end


function DaoJuDiuQi(filename, info, mode)
    handle = openfile(filename, mode)
    write(handle, info.."\n")
    closefile(handle)
end

function ResultConfirmDestroyItemWnd( itemHandle, itemName, result )
   local ID = GetPlayerData(15)
   local name = GetPlayerData(3)
   local yue = GetCurTime(1)
   local hao = GetCurTime(2)
   local hours = GetCurTime(4)
   local minutes = GetCurTime(5)
   local details = GetItemDetails( itemHandle )
	if ( result == nil ) then
		return
	end
   

    local n = GetGroupID()
    if(n == 300001 or n == 100016)then
   if( details.index == 6617 )then
      local lv = GetPlayerData(1)
      if(lv < 100)then
      return MessageBox( "82,245,%\78修为达到100级前新手礼盒不能摧毁！,16" )
      else
         AddTask(14001,0,0,0,0,1)
         SetTaskData(14001,7,1)
      end
   end

   if( details.index == 40157 )then
      AddTask(14001,0,0,0,0,1)
      SetTaskData(14001,7,2)
   end
    else
       if( details.index == 6617 )then
          return MessageBox( "114,235,%\78新手礼盒不能摧毁！,16" )
       end
    end

	if(ModifyItem( itemHandle, "X" ) == 1)then	-- 删除指定道具
		DaoJuDiuQi("记录文件\\道具丢弃.txt",ID.."帐号的"..name.."在"..yue.."月"..hao.."日"..hours.."时"..minutes.."分丢弃了"..itemName.."["..GetItemDetails( itemHandle, true, true).."]","a")
   end
end

function OpenCancelWaitingStateWnd()

	wndCancelWaitingState = 
	{
		pos		= "0,0", 
		size	= "800,600",
		
		image_1	= "265,203,interface/okcancel/系统提示菜单.spr",

		text_2 = "314,235,上次的扣点操作已经超过5分钟未返回\r是否需要直接取消等待状态？,12",			-- 最后一个参数是使用的字号，可默认为12
		
		SprButton_1 = { pos = "300,300", image = "Interface/okcancel/确定", action = "@rc,1,@E" },	-- 返回常量数字1后关闭窗口！
		SprButton_2 = { pos = "470,300", image = "Interface/okcancel/取消", action = "@E" },			-- 直接关闭窗口，不返回消息，即取消销毁道具
	}

	WndCustomize( wndCancelWaitingState, "ResultCancelWaitingStateWnd" )
end

function ResultCancelWaitingStateWnd( result )
	CancelWaitingState()
end
