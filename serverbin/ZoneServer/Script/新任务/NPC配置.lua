-- NPC��controlIdʵ����100000+���
-- NPC��clickScriptʵ����30000+���
--

����NPC���ñ� = {}

����NPC���ñ� = {
	[1] = {
			NpcCreate = { regionId = 1 , name = "����" , title = '�����·���' , npcimg="spr/ͷ��/10.spr", imageId = 6 , x = 116 , y = 139 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���ҷ��ţ����������ճ��������ն�������', },
			},
	[2] = {
			NpcCreate = { regionId = 106 , name = "����" , title = '����Ժ����' , npcimg="spr/ͷ��/11.spr", imageId = 7 , x = 37 , y = 103 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ΡΡ��ɽ���������֣����ȵ���Ī��Ҫ�����������⼸�����������', },
			},
	[3] = {
			NpcCreate = { regionId = 1 , name = "�ι�" , title = '�ؾ�������' , npcimg="spr/ͷ��/12.spr", imageId = 8 , x = 60 , y = 136 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = ' һ��һ���磬һҶһ������', },
			},
	[4] = {
			NpcCreate = { regionId = 1 , name = "����" , title = '�޺�������' , npcimg="spr/ͷ��/13.spr", imageId = 9 , x = 27 , y = 58 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��Ħ��ʦ����������ѧ��Ϊǿ���壬ȴ��֪�ж������������ҷ��ű�������Ը��', },
			},
	[5] = {
			NpcCreate = { regionId = 1 , name = "�ο�" , title = '����������' , npcimg="spr/ͷ��/14.spr", imageId = 10 , x = 70 , y = 90 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���������������������ƣ�', },
			},
	[6] = {
			NpcCreate = { regionId = 104 , name = "����" , title = 'ľ�������' , npcimg="spr/ͷ��/15.spr", imageId = 11 , x = 26 , y = 101 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'Ҫ��ͨ���˴����ȵ�ͨ������ľ��׮��������', },
			},
   [7] = {
			NpcCreate = { regionId = 108 , name = "�޶�" , title = 'ľ�������' , npcimg="spr/ͷ��/16.spr", imageId = 31 , x = 37 , y = 103 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���̵ģ�����ط�������ӬҲ�ɲ����������Ǽ�į������', },
			},
   [8] = {
			NpcCreate = { regionId = 1 , name = "��ͷʦ��" , title = '' , npcimg="spr/ͷ��/17.spr", imageId = 32 , x = 7 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '˭Ҫ��͵��������͸�����һ��Ĳ񡢵�һ���ˮȥ�������ֻ����˵���㡣', },
			},
   [11] = {
			NpcCreate = { regionId = 100 , name = "ֹ��" , title = 'ľ���￴��' , imageId = 14 , x = 63 , y = 39 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���ֵ��Ӳ��÷��ɷ��ͣ������ô�ľ���', },
			},
   [12] = {
			NpcCreate = { regionId = 102 , name = "ֹտ" , title = '��������ʦ' , imageId = 15 , x = 32 , y = 84 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ʮ��ĥһ����û����ʵ�Ļ��������������������ѧ��', },
			},
   [13] = {
			NpcCreate = { regionId = 109 , name = "ֹԨ" , title = '���ؿ���' , imageId = 33 , x = 9 , y = 80 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ǰ����ľ������أ�����ֻ�з��ɿ��Խ��룬����֮���κ��˲���̤��벽��', },
			},
  	[14] = {
			NpcCreate = { regionId = 2 , name = "���ʦ̫" , title = '��ü������' , npcimg="spr/ͷ��/2.spr", imageId = 2 , x = 57, y = 61 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ħ�����ˣ��������ս�թ�������ˣ��г�һ�գ��Ҷ�Ҫ����նɱ������', },
			},
   [15] = {
			NpcCreate = { regionId = 7 , name = "����ʦ̫" , title = '' , npcimg="spr/ͷ��/1.spr", imageId = 1 , x = 143 , y = 77 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��ü�����Ŵ����£���������ǿ��', },
			},
   [16] = {
			NpcCreate = { regionId = 2 , name = "����ʦ̫" , title = '' , npcimg="spr/ͷ��/1.spr", imageId = 1 , x = 16 , y = 125 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��ü�����Ŵ����£���������ǿ��', },
			},
	[18] = {
			NpcCreate = { regionId = 7 , name = "÷��" , title = '�𶥹���' , npcimg="spr/ͷ��/4.spr", imageId =53  , x = 12 , y = 165 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�Ҷ�ü�����书׿Ȼ��Ⱥ��������ǹھ����¡�', },
			},
	[19] = {
			NpcCreate = { regionId = 2 , name = "������" , title = '��ϯ�����' , npcimg="spr/ͷ��/3.spr", imageId = 3 , x = 73 , y = 135 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'һ���꣬��֪�޼ɸ���Ƿ�һ�а���', },
			},
	[20] = {
			NpcCreate = { regionId = 2 , name = "����ܽ" , title = '' , npcimg="spr/ͷ��/5.spr", imageId = 5 , x = 102 , y = 82, dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������������ǽ��', },
			},
	[21] = {
			NpcCreate = { regionId = 2 , name = "������" , title = '' , npcimg="spr/ͷ��/9.spr", imageId = 57 , x = 97 , y =142 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ʦ������ƫ̻����ܽ�����������ҵö������㣬�������֮λ�����Ƕ���֮��', },
			},
   [23] = {
			NpcCreate = { regionId = 2 , name = "÷��" , title = '�ֿ��ܹ�' , imageId = 54 , x = 6 , y = 100 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [24] = {
			NpcCreate = { regionId = 2 , name = "÷��" , title = '�ӻ��ܹ�' , imageId = 55 , x = 9 , y = 96 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [25] = {
			NpcCreate = { regionId = 2 , name = "÷��" , title = 'װ���ܹ�' , imageId = 56 , x = 10 , y = 102 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[27] = {
			NpcCreate = { regionId = 4 , name = "����" , title = '������ʹ' , npcimg="spr/ͷ��/28.spr", imageId = 18 , x = 109 , y = 64 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����λ�������οࣿ', },
			},
   [28] = {
			NpcCreate = { regionId = 4 , name = "��ң" , title = '������ʹ' , npcimg="spr/ͷ��/29.spr", imageId = 19 , x = 74 , y = 77 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����ʥ�𣬷��Ҳ�����', },
			},
   [29] = {
			NpcCreate = { regionId = 9 , name = "лѷ" , title = '��ëʨ��' , npcimg="spr/ͷ��/24.spr", imageId = 17 , x = 58 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�������𣬱����������г�һ�գ��Ҷ�Ҫ�����������г����Ǹ�������', },
			},
	[30] = {
			NpcCreate = { regionId = 4 , name = "���˿" , title = '��������' , npcimg="spr/ͷ��/25.spr", imageId = 34 , x = 77 , y = 47 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ˮ������磬��֪�δ����������', },
			},
   [31] = {
			NpcCreate = { regionId = 4 , name = "������" , title = '��üӥ��' , npcimg="spr/ͷ��/26.spr", imageId = 35 ,  x = 73 , y = 48 , dir = 3 ,objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���������޼ɣ��������г�Ϣ', },
			},
	[32] = {
			NpcCreate = { regionId = 4 , name = "ΤһЦ" , title = '��������' , npcimg="spr/ͷ��/27.spr", imageId = 52 , x = 76 , y = 51 , dir = 7 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����������ζ�ģ��ٺ٣�Ī������Ѫ��', },
			},
	[33] = {
			NpcCreate = { regionId = 9 , name = "˵����" , title = '��������' , npcimg="spr/ͷ��/30.spr", imageId = 20 , x = 132 , y = 196 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����˵����֮�£����ǲ�˵��', },
			},
	[36] = {
			NpcCreate = { regionId = 4 , name = "С��" , title = '' , npcimg="spr/ͷ��/31.spr", imageId = 21 , x = 97 , y = 17 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��ֻ����һ��һ�����̹��ӣ���������', },
			},
   [38] = {
			NpcCreate = { regionId = 4 , name = "������" , title = '�ֿ��ܹ�' , imageId = 36 , x = 82 , y = 14 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [39] = {
			NpcCreate = { regionId = 4 , name = "Ǯͨ" , title = '�ӻ��ܹ�' , imageId = 37 , x = 84 , y = 12 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [40] = {
			NpcCreate = { regionId = 4 , name = "����" , title = 'װ���ܹ�' , imageId = 38 , x = 86 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [41] = {
			NpcCreate = { regionId = 5 , name = "����" , title = 'Сʦ��' , npcimg="spr/ͷ��/45.spr", imageId = 49 , x = 36 , y = 111 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���Ұѻ����������ˣ���ʦ�����Ǿ͵øĿڹ��ҽд�ʦ���ˣ�������', },
			},
   [42] = {
			NpcCreate = { regionId = 5 , name = "������" , title = '����������' , npcimg="spr/ͷ��/44.spr", imageId = 43 , x = 11 , y = 19 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������Դ����ɽ��ңһ�ɣ���ʦ����ң�ӣ������������Ѳ������ᡣ', },
			},
	[43] = {
			NpcCreate = { regionId = 5 , name = "������" , title = '��ʦ��' , imageId = 50 , x = 29 , y = 39 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ʦ�����˼������ص����书��ߵ��ˣ�������Ʒ�ᣬ��..��..��Ҫ�ŵ����ȥ�ˡ�', },
			},
   [44] = {
			NpcCreate = { regionId = 10 , name = "������" , title = '��ʦ��' , npcimg="spr/ͷ��/47.spr", imageId = 44 , x = 154 , y = 192 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��Ҫ�˲�֪�����Ǽ�ĪΪ���ٺ١�', },
			},
   [45] = {
			NpcCreate = { regionId = 5 , name = "������" , title = '��ʦ��' , imageId = 4 , x = 46 , y = 13 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[46] = {
			NpcCreate = { regionId = 5 , name = "ժ����" , title = '��ϯ�����' , npcimg="spr/ͷ��/49.spr", imageId = 44 , x = 50 , y = 20 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'Ҫ������������վ�����ʦ�ֵ�λ�ã�����Ҫ�и�����书֮�⣬�����������ͷ�ԡ�', },
			},
	[47] = {
			NpcCreate = { regionId = 10 , name = "�ɻ���" , title = '�������' , npcimg="spr/ͷ��/48.spr", imageId = 25 , x = 158 , y = 50 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�⸽�����˼Ҷ��챻�ҹ����ˣ������ҵ����������ˡ�', },
			},
	[48] = {
			NpcCreate = { regionId = 10 , name = "��̹֮" , title = '����' , npcimg="spr/ͷ��/46.spr", imageId = 24 , x = 49 , y = 157 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�����ܳ��õİ�������ߣ���ʹÿ��ֻ������һ����Ҳ���������ˡ�', },
			},
	[50] = {
			NpcCreate = { regionId = 5 , name = "��˾��" , title = '�ֿ��ܹ�' , imageId = 50 , x = 112 , y = 116 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[51] = {
			NpcCreate = { regionId = 5 , name = "����ͼ" , title = '�ӻ��ܹ�' , imageId = 26 , x = 112 , y = 120 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [52] = {
			NpcCreate = { regionId = 5 , name = "�͵���" , title = 'װ���ܹ�' , imageId = 51 , x = 112 , y = 124 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[53] = {
			NpcCreate = { regionId = 3 , name = "������" , title = '�䵱������' , npcimg="spr/ͷ��/35.spr", imageId = 22 , x = 10 , y = 70 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�䵱֮�ˣ�������������ɡ�����Ϊ������ʱʱΪ�һ��Ϊ�', },
			},
   [54] = {
			NpcCreate = { regionId = 3 , name = "��Զ��" , title = '�䵱����' , npcimg="spr/ͷ��/36.spr", imageId = 39 , x = 53 , y = 108 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��һ����ͽ��������û���Լ��ĺ������̺ã����ǿɱ���Ц����', },
			},
   [55] = {
			NpcCreate = { regionId = 3 , name = "������" , title = '�䵱����' , imageId = 4 , x = 6 , y = 66 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [56] = {
			NpcCreate = { regionId = 3 , name = "�����" , title = '�䵱����' , imageId = 4 , x = 6 , y = 47 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [57] = {
			NpcCreate = { regionId = 3 , name = "����Ϫ" , title = '�䵱����' , npcimg="spr/ͷ��/37.spr", imageId = 40 , x = 9 , y = 63 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [58] = {
			NpcCreate = { regionId = 3 , name = "����ͤ" , title = '�䵱����' , imageId = 3 , x = 3 , y = 69 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[59] = {
			NpcCreate = { regionId = 3 , name = "�������" , title = '��������' , npcimg="spr/ͷ��/40.spr", imageId = 42 , x = 72 , y = 76 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�䵱ɽ�������ƣ�����ͦ�Σ�����Ǳ����ϰ�ĺõط���', },
			},
	[60] = {
			NpcCreate = { regionId = 8 , name = "��诵���" , title = '��������' , imageId = 42 , x = 147 , y = 177 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�������֮���������������֮�˵������С�Ĳ���', },
			},
	[61] = {
			NpcCreate = { regionId = 8 , name = "��Ȩ����" , title = '��������' , imageId = 42 , x = 125, y = 155 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�Ϸ���������������֮�ж��꣬�Ӳ������£�һ��Ǳϰ���������ܵý��յ��컯��', },
			},
	[62] = {
			NpcCreate = { regionId = 3 , name = "������" , title = '��ϯ�����' , npcimg="spr/ͷ��/38.spr", imageId = 41 , x = 32 , y = 22 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����������ǰ�ˣ�����������Щ����ſ�һչ������ʱ���ˡ�', },
			},
	[64] = {
			NpcCreate = { regionId = 3 , name = "������" , title = '�ֿ��ܹ�' , imageId = 46 , x = 54 , y = 18 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[65] = {
			NpcCreate = { regionId = 3 , name = "������" , title = '�ӻ��ܹ�' , imageId = 47, x = 57 , y = 21 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[66] = {
			NpcCreate = { regionId = 3 , name = "��ɽ��" , title = 'װ���ܹ�' , imageId = 48 , x = 60 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[67] = {
			NpcCreate = { regionId = 999 , name = "��Զ��" , title = '�䵱����' , npcimg="spr/ͷ��/36.spr", imageId = 39 , x = 58 , y = 21 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�����⺢�ӣ��Ϸ�ָ�������ܼ̳��ҵ��²��������������ϣ��ʵ����ã��', },
			},
	[68] = {
			NpcCreate = { regionId = 7 , name = "��ή�Ĳ���" , title = '' , imageId = 62 , x = 143 , y = 87 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��Ϊ����ȱ�����֣��Ѿ�����һϢ�Ĳ���', },
			action = { 995, 3},
				
			condition = {
					completed = {2010}
				},
          
			},
	[69] = {
			NpcCreate = { regionId = 7 , name = "��ή�Ĳ���" , title = '' , imageId = 62 , x = 145 , y = 89 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��Ϊ����ȱ�����֣��Ѿ�����һϢ�Ĳ���', },
			action = { 995, 3},
				
			condition = {
					completed = {2010}
				},
			 
			},
	[70] = {
			NpcCreate = { regionId = 7 , name = "��ή�Ĳ���" , title = '' , imageId = 62 , x = 147 , y = 91 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��Ϊ����ȱ�����֣��Ѿ�����һϢ�Ĳ���', },
			action = { 995, 3},
			 
			condition = {
					completed = {2010}
				},
			 
			},
	[71] = {
			NpcCreate = { regionId = 0 , name = "�䵱����" , title = '������Ȩ' , imageId = 22 , x = 14 , y = 102 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��̤���ǣ���ָ������', },
			},
	[72] = {
			NpcCreate = { regionId = 0 , name = "�䵱����" , title = '�������' , imageId = 5 , x = 6 , y = 18 , dir = 7 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��̤���ǣ���ָ������', },
			},
	[73] = {
			NpcCreate = { regionId = 0 , name = "�䵱����" , title = '��������' , imageId = 5 , x = 4 , y = 16 , dir = 7 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��̤���ǣ���ָ������', },
			},
   [76] = {
			NpcCreate = { regionId = 7 , name = "�����Ĳ���" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 62 , x = 145 , y = 84 , dir = 3 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
                        action = { 995,3},
				
			product = { {4033, 1,99}},
			condition = {
			                completed = {2010}
				},
			},		
   [77] = {
			NpcCreate = { regionId = 7 , name = "�����Ĳ���" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 62 , x = 145 , y = 84 , dir = 3 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
                        action = {995,3},
				
			product = { {4033, 1,99}},
			condition = {
			                completed = {2010}
				},
			},
	[400000] = {
			NpcCreate = { name = "���ɻ���" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 63 , x = 80 , y = 102, dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '... ...', },
			action = { 995, 3},
				
			product = { {4001,1}},
			condition = {
					completed = {1012}
				},
			 ����¼� = { "GiveSP"},
			},
   [400001] = {
			NpcCreate = { name = "��ʯ" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 60 , x = 73 , y = 17, dir = 5 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995,3},
				
			product = { {4029,1}},
			condition = {
					completed = {5004}
				},
			 ����¼� = { "GiveSP"},
			},
   [400002] = {
			NpcCreate = {name = "���Ĳ�" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 61 , x = 102 , y = 7, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				
		        product = { {4019,1}},
			condition = {
					completed = {2005}
				},
			 ����¼� = { "GiveSP"},
			},
   [400003] = {
			NpcCreate = { name = "�Ե���" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 61 , x = 40 , y = 136, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				
		        product = { {4020,1}},
			condition = {
					completed = {4016}
				},
			 ����¼� = { "GiveSP"},
			},
   [400004] = {
			NpcCreate = {name = "������" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 61 , x = 118 , y = 30, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				
		        product = { {4003,1}},
			condition = {
					completed = {3007}
				},
			 ����¼� = { "GiveSP"},
			},
   [400005] = {
			NpcCreate = {name = "��Զ��" , title = '�䵱����' , npcimg="spr/ͷ��/36.spr", imageId = 39 , x = 58 , y = 21 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���������䵱��һ�������еĺ��֣�����ѧϰ�����񹦺���֮���ֲŸ��а��ա�', },
			},
	[82] = {
			NpcCreate = { regionId = 9 , name = "˵����" , title = '����Ҽ��' , npcimg="spr/ͷ��/30.spr", imageId = 20 , x = 85 , y = 138 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����˵����֮�£����ǲ�˵��', },
			},
	[83] = {
			NpcCreate = { regionId = 9 , name = "˵����" , title = '������' , npcimg="spr/ͷ��/30.spr", imageId = 20 , x = 53 , y = 197 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����˵����֮�£����ǲ�˵��', },
			},
	[84] = {
			NpcCreate = { regionId = 9 , name = "˵����" , title = '��������' , npcimg="spr/ͷ��/30.spr", imageId = 20 , x = 50 , y = 32 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����˵����֮�£����ǲ�˵��', },
			},
   [85] = {
			NpcCreate = { regionId = 9 , name = "��������" , title = '' , npcimg="spr/ͷ��/10.spr", imageId = 60 , x = 31 , y = 163, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				 
		        product = { {4026,1}},
			condition = {
					completed = {3012}
				},
           
			},
	[86] = {
			NpcCreate = { regionId = 17 , name = "������ʹ��" , title = '���ǽ���' , npcimg="spr/ͷ��/36.spr", imageId = 51 , x = 32 , y = 136 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ʢ��������·���ܣ�ǰ����ɽһ�ۡ�', },
			},
	[87] = {
			NpcCreate = { regionId = 73 , name = "������ʹ��" , title = '��ɽ����' , npcimg="spr/ͷ��/36.spr", imageId = 51 , x = 13 , y = 204 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ʢ��������·���ܣ�ǰ����ɽһ�ۡ�', },
			},
	[88] = {
			NpcCreate = { regionId = 73 , name = "������ʹ��" , title = '��ɽ����' , npcimg="spr/ͷ��/36.spr", imageId = 51 , x = 19 , y = 204 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ʢ��������·���ܣ�ǰ����ɽһ�ۡ�', },
			},
	[89] = {
			NpcCreate = { regionId = 1 , name = "���ɴ���" , title = '��վ' , npcimg="spr/ͷ��/36.spr", imageId = 26 , x = 35 , y = 155 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���ֵ������������ǰ�����ǡ�', },
		   NpcFunction = {
									{10000, "��վ����",{school = 0}},
							},
			},
	[90] = {
			NpcCreate = { regionId = 2 , name = "���ɴ���" , title = '��վ' , npcimg="spr/ͷ��/36.spr", imageId = 26 , x = 5 , y = 149 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��ü�������������ǰ�����ǡ�', },
		   NpcFunction = {
									{10001, "��վ����",{school = 1}},
							},
			},
	[91] = {
			NpcCreate = { regionId = 3 , name = "���ɴ���" , title = '��վ' , npcimg="spr/ͷ��/36.spr", imageId = 26 , x = 5 , y = 103 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '�䵱�������������ǰ�����ǡ�', },
		   NpcFunction = {
									{10002, "��վ����",{school = 2}},
							},
			},
	[92] = {
			NpcCreate = { regionId = 4 , name = "���ɴ���" , title = '��վ' , npcimg="spr/ͷ��/36.spr", imageId = 26 , x = 42 , y = 116 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ʥ��������������ǰ�����ǡ�', },
		   NpcFunction = {
									{10003, "��վ����",{school = 3}},
							},
			},
	[93] = {
			NpcCreate = { regionId = 5 , name = "���ɴ���" , title = '��վ' , npcimg="spr/ͷ��/36.spr", imageId = 26 , x = 14 , y = 158 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���޵������������ǰ�����ǡ�', },
		   NpcFunction = {
									{10004, "��վ����",{school = 4}},
							},
			},
	[100] = {
			NpcCreate = { regionId = 17 , name = "��վ����" , title = '' , npcimg="spr/ͷ��/36.spr", imageId = 26 , x = 24 , y = 14 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��������ɷ������ɡ�', },
		   NpcFunction = {
									{10005, "��վ����"},
							},
			},
	[94] = {
			NpcCreate = { regionId = 73 , name = "�����ɵ���" , title = '' , npcimg="spr/ͷ��/36.spr", imageId = 68 , x = 12 , y = 176 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '������ѧ�Գ����֣��⻪ɽ�۽�����������˵����������ֻ���Ǽ������ˡ�', },
			},
	[95] = {
			NpcCreate = { regionId = 73 , name = "�����ɵ���" , title = '' , npcimg="spr/ͷ��/36.spr", imageId = 69 , x = 10 , y = 136 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��ü���������Ů��֮������֮��ȴ�Ӳ���������ӡ�', },
			},
	[96] = {
			NpcCreate = { regionId = 73 , name = "�䵱�ɵ���" , title = '' , npcimg="spr/ͷ��/36.spr", imageId = 70 , x = 12 , y = 114 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '��ɽ�۽�֮��ʮ�귽��һ�����ұ�ͬ�˶���ǰȥһ�ø�λ����ǰ���ķ�ɡ�', },
			},
	[97] = {
			NpcCreate = { regionId = 73 , name = "ʥ��̵���" , title = '' , npcimg="spr/ͷ��/36.spr", imageId = 72 , x = 20 , y = 84 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = 'ʥ�������Ϊ��������⣬�˴����ý軪ɽ�۽�ʢ����������ͬ�������ҽ��ɵ�������Ҳ�������ǽ��տڡ�', },
			},
	[98] = {
			NpcCreate = { regionId = 73 , name = "�����ɵ���" , title = '' , npcimg="spr/ͷ��/36.spr", imageId = 71 , x = 10 , y = 70 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '���ǧ���ѷ�Ļ��ᣬ���������������ɵ�λ�á�', },
			},
	[99] = {
			NpcCreate = { regionId = 73 , name = "������ʹ��" , title = '��ɽ����' , npcimg="spr/ͷ��/36.spr", imageId = 51 , x = 14 , y = 60 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '����ǰ�߼���������Ӣ�ۻ�ɽ�۽��ĵط��ˡ�', },
			},

}