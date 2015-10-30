import emb

ACCOUNT_LIST = {}

def LoadAccountList():
	for acc in open('account_list.txt').readlines():
		accItem = acc.strip().split('=')
		if len(accItem) == 2:
			ACCOUNT_LIST[accItem[0]] = accItem[1]

def CheckAccount( account, password, ip, func, dnid, memptr ):
	emb.callback( func, dnid, memptr, 1, "alskdid" )

def AccountLogout( account, ip, onlineTime ):
	print( 'logout: ', account )

def UpdateServerState( dword_ip, id, number, state ):
	print( 'dreamwork update server state' )
