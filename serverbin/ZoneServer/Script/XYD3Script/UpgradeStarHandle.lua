--��������������ĺ�������ҵ��������
function ConsumeAndAddPlayerProperty(XingXiuID, UpgradeStarNum, MoneyType, PlayerVipLevel)
	if PlayerVipLevel > 0 then
		AddPlayerXinYangProperty(XingXiuID, UpgradeStarNum, MoneyType, 0)	--������ҵĸ����޵�����, -1��ʾ��������ʧ�ܣ�������һ���ĸ����ԡ�Vip���û�и����ԣ�100%�ɹ�����1��ʾ�ɹ����ڶ���������ʾ�Ƿ��и���
	else
		AddPlayerXinYangProperty(XingXiuID, UpgradeStarNum, MoneyType, 1)	--û�и���
	end
end
