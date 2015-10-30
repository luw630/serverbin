SceneData_Path = tostring("Script\\Global\\SceneData.ldb")

function  AddToSceneData(sceneindex,playername,finishtime) --增加数据到关卡排行中
	if SceneBestData[sceneindex] == nil then
		SceneBestData[sceneindex] = {}
		SceneBestData[sceneindex].bestplayer = playername
		SceneBestData[sceneindex].besttime = finishtime
		SaveSceneData()
		return
	end

	if SceneBestData[sceneindex].besttime > finishtime then
		SceneBestData[sceneindex].bestplayer = playername
		SceneBestData[sceneindex].besttime = finishtime
		SaveSceneData()
	end
	
end

function GetSceneData(sceneindex) --得到最近关卡排行
	local bestdata = {}
	if SceneBestData[sceneindex] ~= nil then
		bestdata = SceneBestData[sceneindex] 
		--TalkToPlayer(2,"bestplayer "..bestdata.bestplayer.." time = "..bestdata.besttime.."")
--		rfalse("bestplayer ["..bestdata.bestplayer.."] time = "..bestdata.besttime.."")
	else
		bestdata.bestplayer = ""    --没有人空数据
		bestdata.besttime = 0
	end
	return bestdata 
end


function LoadSceneData() --读取排行数据
	SceneBestData = LoadTable(SceneData_Path)
	if SceneBestData == nil then
		rfalse("LoadSceneData Faile")
	end
end

function SaveSceneData() --保存排行数据
	if SceneBestData == nil or SceneBestData == {} then
		return
	end
	local isave = SaveTable(SceneData_Path,SceneBestData)
	 if isave == nil then
	 	rfalse("SaveSceneData Faile")
	 end
end


function SceneDataInit()
	if SceneBestData == nil then
		SceneBestData = {}
	end
	LoadSceneData()
	if SceneBestData == nil then
		SceneBestData = {}
	end
end

SceneDataInit()