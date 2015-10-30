import emb, socket, select

ip = '211.154.165.17' # '220.181.31.8'
port = 20006 # 80
gameid = 50004

class mysock( socket.socket ):

 curlst = {}
 strbuf = b''

 def __init__( self ):
  socket.socket.__init__( self, socket.AF_INET, socket.SOCK_STREAM ) 
  self.setblocking( 0 )
  self.queue = queue

def OnRecv( self, buf ):
 # print( 'OnRecv (', len( buf ), ')', buf )
 if len( buf ) == 0:
  if len( self.curlst ) > 0:
   # 当前所有处理中的请求都挂掉。。。
   for v in self.curlst:
    try:
     emb.callback( v[3], v[4], [5], 0 )
    except:
     pass
   self.clear()
  return True
 else:
  # 处理返回信息串，并选择处理当前玩家
  self.strbuf += buf
  lines = self.strbuf.split( b'\n' )
  if buf[-1] != b'\n': # 如果当前行没有结束符，则继续等待。。。
   self.strbuf = lines.pop( -1 )
  for line in lines:
   result = False
   name = False
   limit = b'0'
   uid = False
   if b'<ValidateResult>' == line[:16]:
    result = line[16:].split( b'<', 1 )[0]
   sp1 = 16+len( result )
   if b'<UserName>' == line[sp1:sp1+10]:
    name = line[sp1+10:].split( b'<', 1 )[0]
   sp2 = sp1 + 10 + len( name )
   if b'<Result>' == line[sp2:sp2+8]:
    limit = line[sp2+8:sp2+9]
   sp3 = sp2 + 9
   if b'0' != limit and b'<PersonalID>' == line[sp3:sp3+12]:
    uid = line[sp3+12:].split( b'<', 1 )[0]
   print( sp1, sp2, result, name, limit, uid )
   key = str( name, 'gbk' )
   try:
    v = self.curlst[key]
    del self.curlst[key]
    emb.callback( v[3], v[4], v[5], result == b'TRUE' )
   except Exception as x:
    print( '发现一个未请求验证结果', x )
 return False

def OnSend( self ):
 global queue
 if self == sock:
  for i in range( 5 ):
   if len( self.curlst ) < 5:
    if len( queue ) > 0:
     try:
      cur = queue[0]
      queue = queue[1:]
      bstr = b'<CVC><ValidateCode>' + cur[1] + b'<UserName>' + cur[0] + b'<UserIP>' + cur[2] + b'\n'
      b = self.send( bstr )
      key = str( cur[0], 'gbk' )
      if hasattr( self.curlst, key ): # 如果已经存在之前的注册数据，则让前一个数据失败返回
       v = self.curlst[ key ]
       emb.callback( v[3], v[4], [5], 0 )
      self.curlst[ key ] = cur
      # print( 'OnSend (', b, ')', bstr )
     except Exception as x:
      print( x )

def OnClose( self ):
 global sock
 if self == sock:
  print( 'OnClose' )
  OnRecv( self, b'' )
  sock.close()
  sock = False

try:
 if queue:
  pass
except NameError:
 print( '初始化事件队列' ) 
 queue = []

def CheckAccount( account, password, ip, func, dnid, memptr ):
 queue.append( [account, password, ip, func, dnid, memptr] )

def AccountLogout( account, ip, onlineTime ):
 pass

def UpdateServerState( dword_ip, id, number, state ):
 pass

#之所以不放在最外层，是为了避免重新加载模块后导致重复初始化！
try:
 if sock:
  sock.OnRecv  = OnRecv
  sock.OnSend  = OnSend
  sock.OnClose = OnClose
except NameError:
 print( '初始化连接对象' ) 
 sock = False

def Init():
 global sock
 try:
  if not sock:
   sock = mysock()
   sock.OnRecv  = OnRecv
   sock.OnSend  = OnSend
   sock.OnClose = OnClose
   sock.connect( ( ip, port ) )
   print( "服务器已经连接\r\n" )
 except socket.error as x:
  if x.errno != 10035:
   sock = False
   print( "启动网络出现问题！\r\n", x.strerror )
  else:
   print( "10035\r\n" )
 else:
  print( "网络已经启动\r\n" )

# 消息处理主循环
def DoThings():
 try:
  global sock
  if sock:
   lst = [sock]
   r, w, e = select.select( lst, lst, lst, 0 )
   # print( "select ", len(r), len(w), len(e) )
   # 读取网络数据，并处理！
   if len( r ) > 0:
    for s in r:
     dis = False
     try:
      buf = s.recv( 1024, 0 )
      dis = s.OnRecv( s, buf )
     except Exception as e:
      dis = True
      print( "except\r\n", e )
     if dis:
      s.OnClose( s )

   # 发送网络数据！
   if len( w ) > 0:
    for s in w:
      s.OnSend( s )
  else:
   Init()

 except Exception as e:
  print( "except\r\n", e )
