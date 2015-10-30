function renwu()
	DrawSpr("renwu.spr",672,619)
end

function beibao()
	DrawSpr("beibao.spr",596,619)
end

function xuexi()
	DrawSpr("xuexi.spr",750,262)
end

function xunlu()
	DrawSpr("xunlu.spr",621,221)
end

function qinggongzy()
	DrawSpr("qinggongzy.spr",80,384)
end

function wugongzy()
	DrawSpr("wugongzy.spr",80,384,679,338,147,26)
end

function  baguajianfa()
AutoRunScript(26)
end

function  songyuanqiao1()
ChangeNpcAction(100054, '新武当剑_远攻4', 2)
end

function yingxiongtie()
	DrawSpr("yingxiongtie.spr",45,101)
	TalkDialog_Next(5)
end

function yingxiongtieshaolin()
	DrawSpr("yingxiongtieshaolin.spr",45,101)
	TalkDialog_Next(8)
end

function  miejue1()
ChangeNpcAction(100014, '剧情_灭绝师太舞剑', 1)
end

function  chengkong1()
ChangeNpcAction(100005, '新少林杖_近攻3', 3)
end

function  azi1()
ChangeNpcAction(100041,'新星宿环_近功1', 3)
end

function  fanyao1()
ChangeNpcAction(100028,'新圣火刀_近攻1', 3)
end
