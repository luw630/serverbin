# 注意，在中文路径下执行会存在编码问题。。。
''' 说明：
现在使用 DoThings 进行平台检测
第一，网络部分使用非阻塞套接字！
第二，当前模块使用多线程工作模式
	独立工作线程，操作具体的平台验证网络接口 循环调用 WorkThreadEntry
	帐号主线程，接收网络消息转发进python数据队列，以及执行控制台命令！！！
'''

import emb
import imp

from platforms import dreamwork

def Main_CheckAccount( prefix, account, password, ip, func, dnid, memptr ):
	try:
		# 实际上是将数据压入事件队列（里边可以做唯一处理，同一帐号的多个请求唯一）
		platforms[prefix].CheckAccount( account, password, ip, func, dnid, memptr )
	except KeyError:
		print( 'Main_CheckAccount 找不到平台接口 [', prefix, ']' )

def Main_AccountLogout( prefix, account, ip, onlineTime ):
	try:
		platforms[prefix].AccountLogout( account, ip, onlineTime )
	except KeyError:
		print( 'Main_AccountLogout 找不到平台接口 [', prefix, ']' )

def Main_UpdateServerState( dword_ip, id, number, state, islast ):
	for k, v in platforms.items():
		try:
			v.UpdateServerState( dword_ip, id, number, state )
		except KeyError:
			print( 'Main_UpdateServerState 找不到平台接口 [', k, ']' )

def ShowAll():
	print( '---- 开始打印已装载的平台接口 ----' )
	for k, v in platforms.items():
		print( v.__name__ )
	print( '打印完毕' )

# 处理所有消息的主循环，从事件队列中获取信息并尝试进行
def WorkThreadEntry():
	for k, v in platforms.items():
		try:
			v.DoThings()
		except:
			pass
	return 1000

def reload( name ):
	imp.reload( platforms[name] )

def main():
	emb.updateopt( "title", "账号服务器" )

	dreamwork.LoadAccountList()

	# 定制帐号服务器的执行存储过程！
	#emb.updateopt( "AccountLogout",    "AccountManager.AccountLogoutNEWXYD" ) # 完全退出
	#emb.updateopt( "AccountHangup",    "AccountManager.AccountHangupNEWXYD" ) # 挂机退出
	#emb.updateopt( "AccountLogin",     "AccountManager.AccountLoginNEWXYD"  ) # 登陆游戏
	#emb.updateopt( "AccountLoginEx",   "AccountManager.AccountLoginEx"      ) # 特殊登录（存在 0x1F 前缀）
	#emb.updateopt( "OnlineNumber",     "dreamworkxyd_new_log..t_RoleOnlineNumber" ) # 在线人数的保存表

	emb.updateopt( "AccountLogout",    "AccountManager.AccountLogout"        ) # 完全退出
	emb.updateopt( "AccountHangup",    "AccountManager.AccountHangup"        ) # 挂机退出
	emb.updateopt( "AccountLogin",     "AccountManager.AccountLogin"         ) # 登陆游戏
	emb.updateopt( "AccountLoginEx",   "AccountManager.AccountLoginEx"       ) # 特殊登录（存在 0x1F 前缀）
	emb.updateopt( "OnlineNumber",     "playerlog..t_RoleOnlineNumber"       ) # 在线人数的保存表

	# 注册平台验证接口！
	global platforms
	platforms = {}
	platforms['default'] = dreamwork
