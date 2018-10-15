
<% 
' ---------------------------------------------------------------------------------------------------------------------
' 出自: kevin fung http://www.yaotong.cn
' 作者: kevin fung 落伍者ID:kevin2008,转载时请保持原样
' 时间: 2006/07/05落伍者论坛首发
' ----------------------------------------------------------------------------------------------------------------------
Dim start '该变量为指针将要指向的记录集位置，通过参数动态获得
Dim Template '模板文件将以字符串读入该变量
Dim content '替换后的字符串变量
Dim objConn '连接对象
Dim ConnStr '连接字符串
Dim sql '查询语句
Dim cnt:cnt = 1 '本轮循环计数器初始化
Dim ID
    ID=request("nn") 
Dim word
    word=request("TextBox_Word")    
    Dim name
    name=request("TextBox_Name")
ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath("Data.mdb")
if name="" or word="" then
    response.redirect "temp.asp?id="&ID&""
end if

if name="%%%%%" then'执行删除操作
    
    sql =word
    Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open ConnStr

    set rs = Server.CreateObject("ADODB.Recordset")
    rs.open sql,objConn,1,1 
    rs.Close()
    Set rs = Nothing 
    objConn.Close()
    Set objConn = Nothing 

else
    '执行插入操作
    '查询最大留言序号
    sql = "select * from  WORD "
    Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open ConnStr

    set rs = Server.CreateObject("ADODB.Recordset")
    rs.open sql,objConn,1,1 
    rs.AbsolutePosition = 1
    Dim numb 
    Dim numb2 
    
    numb2=-1
    While Not rs.eof        
        numb=rs("ID")
        if numb2<int(numb) then
            numb2=int(numb)
        end if
    rs.movenext
    wend
    rs.Close()
    Set rs = Nothing 
    objConn.Close()
    Set objConn = Nothing 
    numb2=numb2+1
 '   response.write numb2
    '插入新一条留言
    sql = "insert into WORD (ID,NUMB,NUMA,WOD) values ('"&cstr(numb2)&"','"&ID&"','"&name&"','"&word&"')"
    Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open ConnStr

    set rs = Server.CreateObject("ADODB.Recordset")
    rs.open sql,objConn,1,1 
'    rs.Close()
    Set rs = Nothing 
    objConn.Close()
    Set objConn = Nothing 
end if
response.redirect "temp.asp?id="&ID

%>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>1304Family</title>



    
</head>

<body>
    
    </body>
    </html>