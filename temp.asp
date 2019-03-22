
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
    ID=request("id") 



ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath("Data.mdb")


sql2 = "select * from  [USER] where ID = '"&ID&"' "
Set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open ConnStr

set rs = Server.CreateObject("ADODB.Recordset")
rs.open sql2,objConn,1,1 '打开数据集
Template = getTemplate(Server.MapPath("template.htm"))' template.html为模板文件，通过函数getTemplate读入到字符串,模板文件中要替换的内容均以{...}括起来
    '更换头像
    if ID="25" then
    content = Replace(Template,"{imgname}","img253")
    else 
    content = Replace(Template,"{imgname}","img"&ID&"")
    end if
    '更换昵称
    content = Replace(content,"{username}",rs("NAME1"))
rs.Close()
Set rs = Nothing 
objConn.Close()
Set objConn = Nothing 



sql = "select * from  WORD where NUMB = '"&ID&"' "

Set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open ConnStr

set rs = Server.CreateObject("ADODB.Recordset")
rs.open sql,objConn,1,1 '打开数据集
Dim s1
    s1= "<tr><td><f2>"

Dim s2
    s2= "</f2></td><td><f1>"
Dim s3
    s3= "</f1></td></tr>"
    Dim str1 
    Dim ste2
If Not rs.eof Then
    rs.AbsolutePosition = 1 '从头遍历搜索结果
    str1= s1&s2&s3
    str2= s1&rs("NUMA")&":"&s2&rs("WOD")&s3
    content = Replace(content,str1,str2)
    
   ' content = Replace(Template,"{n1}",rs("NUMA")) '用字段值替换模板内容
    'content = Replace(content,"{w1}",rs("WOD")) 
    rs.movenext
    cnt = cnt + 1 '计数器加1
End if
While Not rs.eof  '500是设定一次请求生成页面的循环次数，根据实际情况修改，如果太高了，记录集很多的时候会出现超时错误
    str1=str2
    str2=str1&s1&rs("NUMA")&":"&s2&rs("WOD")&s3
    content = Replace(content,str1,str2)
  '  response.write str2&"////"
'content = Replace(content,"{n"&cnt&"}",rs("NUMA")) '用字段值替换模板内容
'content = Replace(content,"{w"&cnt&"}",rs("WOD")) 

cnt = cnt + 1 '计数器加1
start = start + 1 '指针变量递增
rs.movenext

wend
   
  '  response.write "生成HTML文件完毕！"
genHtml content,Server.MapPath("/h/test"&ID&".html") '将替换之后的Template字符串生成HTML文档，htmfiles为存储静态文件的目录,请手动建立

response.redirect "/h/test"&ID&".html?id="&ID&""

'If Not rs.eof Then '通过刷新的方式进行下一轮请求,并将指针变量start传递到下一轮
'response.write "<meta http-equiv='refresh' content='0;URL=?start="&start&"'>"
'Else

'End if

rs.Close()
Set rs = Nothing 
objConn.Close()
Set objConn = Nothing 

Function getTemplate(template)'读取模板的函数，返回字符串,template为文件名
Dim fso,f
set fso=CreateObject("Scripting.FileSystemObject")
set f = fso.OpenTextFile(template)
getTemplate=f.ReadAll
f.close
set f=nothing
set fso=Nothing
End Function 

Sub genHtml(content,filename)'将替换后的内容写入HTML文档,content为替换后的字符串,filename为生成的文件名
Dim fso,f
Set fso = Server.CreateObject("Scripting.FileSystemObject") 
Set f = fso.CreateTextFile(filename,true,True )'如果文件名重复将覆盖旧文件
f.write content
f.Close
Set f = Nothing
set fso=Nothing
End Sub
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