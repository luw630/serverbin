--[[
file:	Act_func.lua
author:	lpd
update:	2015-05-13
desc:�����
]]--

--�����
act_type = {
	betaTestGift = 1,	--����������,
	betaLucky = 2 ,		--����-��������
	chekinHeroGift =3, 	--ǩ�����佫
	lvUpGift = 4, 		--�弶����������
	packGift = 5,       -- �һ����
	--betaDoubleExpGift = 5, --����-��������
	
	diamondEveryday=6,--������Ԫ��
	boxEveryday=7,--�����챦��
	duanwu=8, --���� 6��19�ա�20�ա�21��
	chargeSum = 10, --�ۼƳ�ֵ�
}


--����ñ�
act_conf={
	[1] = { -- ��һ������ñ����������ͣ�
			begintime = os.time({year=2015, month=5, day=14, hour=0, sec=0}),--���ʼʱ��
			endtime = os.time({year=2015, month=5, day=20, hour=0, sec=0}),--�����ʱ��
			[1] = {--��һ�콱������ 
					[1]={GoodsType.diamond, 0, 100 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 20001, 5 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20011, 2 },
				 },
			[2] ={--�ڶ��콱������
		        	[1]={GoodsType.hero, 144, 1 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 20001, 5 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20007, 2 },
				 },
			[3] ={--�����콱������
		        	[1]={GoodsType.diamond, 0, 150 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 20001, 5 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20007, 2 },
				 },
			[4] ={--�����콱������
			        [1]={GoodsType.item, 90105, 20 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 20001, 5 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20007, 2 },
				 },
			[5] ={--�����콱������
			        [1]={GoodsType.diamond, 0, 200 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 20001, 5 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20007, 2 },
				 },
			[6] ={--�����콱������
			        [1]={GoodsType.item, 90105, 20 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 20001, 5 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20007, 2 },
				 },
			[7] ={--�����콱������
			        [1]={GoodsType.diamond, 0, 500 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
					[2]={GoodsType.item, 90105, 30 },-- �ڶ��ֽ���
					[3]={GoodsType.item, 20001, 5 },
					[4]={GoodsType.item, 20007, 2 },
				 },
		  },
		  
	[2] ={ --�ڶ����������-����������
			begintime = os.time({year=2015, month=5, day=5, hour=0, sec=0}),--���ʼʱ��
			endtime = os.time({year=2015, month=5, day=20, hour=0, sec=0}),--�����ʱ��
		[1] = {--��һ�콱������ 
					[1]={GoodsType.item, 20012, 5 },--{���ͣ�itemID, ����} ��������Ͳ�����item������0��
					[2]={GoodsType.item, 20011, 10 },-- �ڶ��ֽ���
			   	 }, 
			[2] = {--�ڶ��콱������ 
					[1]={GoodsType.item, 20013, 5 },
					[2]={GoodsType.item, 20011, 10},
			   	 },
			[3] = {--�����콱������ 
					[1]={GoodsType.item, 20017, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[4] = {--�����콱������ 
					[1]={GoodsType.item, 20012, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[5] = {--�����콱������ 
					[1]={GoodsType.item, 20014, 5 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[6] = {--�����콱������ 
					[1]={GoodsType.item, 20017, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [7] = {--�����콱������ 
					[1]={GoodsType.item, 20015, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [8] = {--�ڰ��콱������ 
					[1]={GoodsType.item, 20012, 20 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[9] = {--�ھ��콱������ 
					[1]={GoodsType.item, 20017, 10 },--{���ͣ�itemID, ����} ��������Ͳ�����item������0��
					[2]={GoodsType.item, 20011, 10 },-- �ڶ��ֽ���
			   	 }, 
			[10] = {--��ʮ�콱������ 
					[1]={GoodsType.item, 20012, 5 },
					[2]={GoodsType.item, 20011, 10},
			   	 },
			[11] = {--��ʮһ�콱������ 
					[1]={GoodsType.item, 20017, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[12] = {--��ʮ���콱������ 
					[1]={GoodsType.item, 20012, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[13] = {--��ʮ���콱������ 
					[1]={GoodsType.item, 20017, 15 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[14] = {--��ʮ���콱������ 
					[1]={GoodsType.item, 20015, 5 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [15] = {--��ʮ���콱������ 
					[1]={GoodsType.item, 20012, 30 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [16] = {--��ʮ���콱������ 
					[1]={GoodsType.item, 20015, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },	 
		  },
	[3] ={ --���������ǩ���ʹ��ǣ�
			begintime = os.time({year=2015, month=5, day=5, hour=0, sec=0}),--���ʼʱ��
			endtime = os.time({year=2015, month=5, day=20, hour=0, sec=0}),--�����ʱ��
			[1] = {--��һ�콱������
					[1]={GoodsType.diamond, 0, 100 },--{���ͣ�itemID, ����} ��������Ͳ�����item������0��
				 }, 
			[2] = {--�ڶ��콱������ 
					[1]={GoodsType.hero, 144, 1  },	
			   	 },
			[3] = {--�����콱������ 
					[1]={GoodsType.diamond, 0, 200 },
				 },
			[4] = {--�����콱������ 
					[1]={GoodsType.diamond, 0, 200 },
				 },
			[5] = {--�����콱������ 
					[1]={GoodsType.diamond, 0, 200 },
				 },
			[6] = {--�����콱������ 
					[1]={GoodsType.diamond, 0, 200 },
				 },
		    [7] = {--�����콱������ 
					[1]={GoodsType.item, 90105, 70 },
				 },

		  },
	[4] ={ --��ʱ�弶����������
			begintime = os.time({year=2015, month=9, day=11, hour=0, sec=0}),--���ʼʱ��
			endtime = os.time({year=2015, month=9, day=18, hour=0, sec=0}),--�����ʱ��
			con = {5,10,15,20,25,30,37,40,41,42,43,44,45}, --��ȡ�����������
			[1] = {--����5��ʱ�Ľ���
					[1]={GoodsType.item, 90121, 5 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20001, 1 },
					[3]={GoodsType.item, 20013, 2 },
				  },
			[2] = {--����10��ʱ�Ľ���
					[1]={GoodsType.item, 90102, 5 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20001, 2 },
					[3]={GoodsType.item, 20013, 2 },
					[4]={GoodsType.item, 20007, 3 },
				  },
            [3] = {--����15��ʱ�Ľ���
					[1]={GoodsType.item, 90101, 5 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20001, 3 },
					[3]={GoodsType.item, 20013, 2 },
					[4]={GoodsType.item, 20007, 6 },
					},
			[4] = {--����20��ʱ�Ľ���
					[1]={GoodsType.money, 0, 100000 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20001, 4 },
					[3]={GoodsType.item, 20014, 2 },
					[4]={GoodsType.item, 20007, 9 },
				  },
			[5] = {--����25��ʱ�Ľ���
					[1]={GoodsType.diamond, 0, 100 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20001, 5 },
					[3]={GoodsType.item, 20014, 2 },
					[4]={GoodsType.item, 20007, 12 },
				  },
            [6] = {--����30��ʱ�Ľ���
					[1]={GoodsType.diamond, 0, 200 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20001, 10 },
					[3]={GoodsType.item, 20014, 2 },
					[4]={GoodsType.item, 20007, 15 },
				   },
		    [7] = {--����37��ʱ�Ľ���
					[1]={GoodsType.diamond, 0, 300 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20002, 5 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 5 },	
				   },
			[8] = {--����40��ʱ�Ľ���
					[1]={GoodsType.diamond, 0, 500 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [1]={GoodsType.item, 90130, 5 },
			   	    [2]={GoodsType.item, 20002, 5 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 5 },		
				   },
			[9] = {--����41��ʱ�Ľ���
					[1]={GoodsType.item, 90130, 5 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20002, 10 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 10 },
				  },
            [10] = {--����42��ʱ�Ľ���
					[1]={GoodsType.item, 90130, 10 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20002, 10 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 10 },
				   },
		    [11] = {--����43��ʱ�Ľ���
					[1]={GoodsType.item, 90130, 15 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20002, 15 },
					[3]={GoodsType.item, 20015, 5 },
					[4]={GoodsType.item, 20008, 15 },
				   },	
			[12] = {--����44��ʱ�Ľ���
					[1]={GoodsType.item, 90130, 20 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 20002, 15 },
					[3]={GoodsType.item, 20015, 5 },
					[4]={GoodsType.item, 20008, 15 },		
				   },	
			[13] = {--����45��ʱ�Ľ���
					[1]={GoodsType.diamond, 0, 6666 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [2]={GoodsType.item, 90130, 25 },--{���ͣ�itemID, ����} ��������Ͳ�����item�����
			   	    [3]={GoodsType.item, 20002, 50 },
					[4]={GoodsType.item, 20015, 5 },
					[5]={GoodsType.item, 20009, 20 },		
				   },
	   
			},
	

	[5] ={--�һ��빦��
			[1] = {
					[1]= {GoodsType.item, 20016, 1},--�˴������ر���
				  },
		 },
		 
	[6] ={--������Ԫ��,8��һ���ֻ�
			[1] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			[2] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [3] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [4] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [5] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [6] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [7] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [8] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
		 },
	[7] ={--�����챦��,8��һ���ֻ�
			[1] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [2] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
			 [3] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [4] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
			 [5] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [6] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
			 [7] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [8] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
		 },
	[8] ={--���� 6��19�ա�20�ա�21��
			[1] = {
				[1]= {GoodsType.diamond, 0, 500},
			  },
			 [2] = {
				[1]= {GoodsType.hero, 143, 1},
			  },
			 [3] = {
				[1]= {GoodsType.diamond, 0, 500},
			  },
		 },			 
}
