function OpenConfirmDestroyItemWnd( itemHandle, itemName )

	wndConfirmDestroyItem = 
	{
		pos		= "0,0", 
		size	= "800,600",
		
		image_1	= "265,203,interface/okcancel/ϵͳ��ʾ�˵�.spr",

		text_2 = "314,235,[%4"..itemName.."%0]\n�Ƿ�%1����%0�˵��ߣ�,12",			-- ���һ��������ʹ�õ��ֺţ���Ĭ��Ϊ12
		
		SprButton_1 = { pos = "300,300", image = "Interface/okcancel/ȷ��", onkey = 13, action = "@rc,1,@E" },	-- ���س�������1��رմ��ڣ�
		SprButton_2 = { pos = "470,300", image = "Interface/okcancel/ȡ��", action = "@E" },			-- ֱ�ӹرմ��ڣ���������Ϣ����ȡ�����ٵ���
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
      return MessageBox( "82,245,%\78��Ϊ�ﵽ100��ǰ������в��ܴݻ٣�,16" )
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
          return MessageBox( "114,235,%\78������в��ܴݻ٣�,16" )
       end
    end

	if(ModifyItem( itemHandle, "X" ) == 1)then	-- ɾ��ָ������
		DaoJuDiuQi("��¼�ļ�\\���߶���.txt",ID.."�ʺŵ�"..name.."��"..yue.."��"..hao.."��"..hours.."ʱ"..minutes.."�ֶ�����"..itemName.."["..GetItemDetails( itemHandle, true, true).."]","a")
   end
end

function OpenCancelWaitingStateWnd()

	wndCancelWaitingState = 
	{
		pos		= "0,0", 
		size	= "800,600",
		
		image_1	= "265,203,interface/okcancel/ϵͳ��ʾ�˵�.spr",

		text_2 = "314,235,�ϴεĿ۵�����Ѿ�����5����δ����\r�Ƿ���Ҫֱ��ȡ���ȴ�״̬��,12",			-- ���һ��������ʹ�õ��ֺţ���Ĭ��Ϊ12
		
		SprButton_1 = { pos = "300,300", image = "Interface/okcancel/ȷ��", action = "@rc,1,@E" },	-- ���س�������1��رմ��ڣ�
		SprButton_2 = { pos = "470,300", image = "Interface/okcancel/ȡ��", action = "@E" },			-- ֱ�ӹرմ��ڣ���������Ϣ����ȡ�����ٵ���
	}

	WndCustomize( wndCancelWaitingState, "ResultCancelWaitingStateWnd" )
end

function ResultCancelWaitingStateWnd( result )
	CancelWaitingState()
end
