<!-- <%@ Page Language="C#" %> -->


<!DOCTYPE html>

<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>

<script runat="server">

    public string num;
    public string numimg;
    void Page_Load()
    {
        num = Request.QueryString["id"];
        numimg = Request.QueryString["id"];
        if (num == "25")
            numimg = "251";
    }
    void showword()
    {
        string db=@"Data.mdb";
        string connStr="PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA Source="+Server.MapPath(db)+";";
        string SQLcmd="select * from WORD where NUMB = '"+num+"'";
        //    string SQLcmd = "insert into WORD (ID,NUMB,NUMA,WOD) values ('6','0','X5','数据库测试')";
        OleDbConnection conn=new OleDbConnection(connStr);
        conn.Open();
        OleDbCommand OleCmd=new OleDbCommand(SQLcmd,conn);
        //    OleCmd.ExecuteNonQuery();

        OleDbDataReader reader =OleCmd.ExecuteReader() ;
        while (reader.Read())
        {
            Response.Write("<tr><td><f2>"  + reader["NUMA"]+":</f2></td>");
            Response.Write("<td><f1>" + reader["WOD"]+"</f1></td></tr>");

        }


        conn.Close();
        conn=null;
        OleCmd=null;
    }
    void addword(string name,string word)
    {//select max(Age) from Student
        string db=@"Data.mdb";
        string connStr="PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA Source="+Server.MapPath(db)+";";

        string SQLcmd2="select * from WORD";
        //    string SQLcmd = "insert into WORD (ID,NUMB,NUMA,WOD) values ('6','0','X5','数据库测试')";
        OleDbConnection conn2=new OleDbConnection(connStr);
        conn2.Open();
        OleDbCommand OleCmd2=new OleDbCommand(SQLcmd2,conn2);
        //    OleCmd.ExecuteNonQuery();

        OleDbDataReader reader2 =OleCmd2.ExecuteReader() ;
        int temp = -1;
        while (reader2.Read())
        {
        
            if (temp < int.Parse(reader2["ID"].ToString()))
            {
                temp = int.Parse(reader2["ID"].ToString());
            }
        }
       
        temp++;


        conn2.Close();
        conn2=null;
        OleCmd2=null;

        //delete from WORD where NUMB='25' and NUMA='12' and Wod='12'
        string SQLcmd = "insert into WORD (ID,NUMB,NUMA,WOD) values ('"+temp.ToString()+"','"+num+"','"+name+"','"+word+"')";
        OleDbConnection conn=new OleDbConnection(connStr);
        conn.Open();
        OleDbCommand OleCmd=new OleDbCommand(SQLcmd,conn);
        //OleCmd.ExecuteNonQuery();

        OleDbDataReader reader =OleCmd.ExecuteReader();
        while (reader.Read())
        {
            string dlg = "<tr><td><f2>" + reader["NUMA"] + ":</f2></td>";
            string dlg2 = "<td><f1>" + reader["WOD"]+"</f1></td></tr>";
            ClientScript.RegisterStartupScript(typeof(string), "print", dlg);
            ClientScript.RegisterStartupScript(typeof(string), "print", dlg2);

        }
        string msg = "<script>alert('留言添加成功!')<"+"/script>";
        ClientScript.RegisterStartupScript(typeof(string), "print", msg);

        conn.Close();
        conn=null;
        OleCmd=null;

    }
    void deleteword(string cmd)
    {
        string db=@"Data.mdb";
        string connStr="PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA Source="+Server.MapPath(db)+";";
        string SQLcmd = cmd;
        OleDbConnection conn=new OleDbConnection(connStr);
        conn.Open();
        OleDbCommand OleCmd=new OleDbCommand(SQLcmd,conn);
        OleDbDataReader reader =OleCmd.ExecuteReader();
        while (reader.Read())
        {
            string dlg = "<tr><td><f2>" + reader["NUMA"] + ":</f2></td>";
            string dlg2 = "<td><f1>" + reader["WOD"]+"</f1></td></tr>";
            ClientScript.RegisterStartupScript(typeof(string), "print", dlg);
            ClientScript.RegisterStartupScript(typeof(string), "print", dlg2);
            //    Response.Write("<tr><td><f2>"  + reader["NUMA"]+":</f2></td>");
            //   Response.Write("<td><f1>" + reader["WOD"]+"</f1></td></tr>");
        }
        string msg = "<script>alert('留言删除成功!')<"+"/script>";
        ClientScript.RegisterStartupScript(typeof(string), "print", msg);
        conn.Close();
        conn=null;
        OleCmd=null;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string word = TextBox_Word.Value;// TextBox_Word.Text.Trim();
        string name = TextBox_Name.Value;// TextBox_Name.Text.Trim();
        //    ClientScript.RegisterStartupScript(typeof(string), "print", "<script alert(\"弹出对话框方法2\")/>"); 
        if(name=="%%%%%")//删除数据
        {
            if(word.Length>20)
                deleteword(word);
        }
        else
        {
            if(word=="")
            {
                string msg = "<script>alert('留言不能为空!')<"+"/script>";
                ClientScript.RegisterStartupScript(typeof(string), "print", msg);
            }
            if(name=="")
            {
                string msg = "<script>alert('留言人不能为空!')<"+"/script>";
                ClientScript.RegisterStartupScript(typeof(string), "print", msg);
            }
            addword(name, word);
        }


        //    Response.Write(dlg);
        //window.location.reload();
        //       Response.Redirect("index.html");
        //    Response.Redirect( Request.Url.ToString()); 
    }


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <style type="text/css">

body { background-image: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497707984033&di=32ec7057fa0c26a8fc352652fd67adb8&imgtype=0&src=http%3A%2F%2Fbpic.ooopic.com%2F15%2F46%2F89%2F15468942-295d7438c8d3d52070ef31c57bf55386-0.jpg);background-size:100%;
}
f1{ margin: 0; padding: 0; line-height: 0px; font-family: 华文行楷; font-size: 24px; }
f2{ margin: 0; padding: 0; line-height: 0px; font-family: 宋体; font-size: 20px; }
</style>
</head>
<body >
   <form id="form1" runat="server">
     <div style="position:absolute; left:50px; top:60px">
        <img src="Image/img<%=numimg%>.jpg" width="150" high="200"> 
       
    </div>
    <div style="position:absolute; left:60px; top:230px">
        <h1><%=num%></h1>
    </div>
    <div style="position:absolute; left:300px; top:30px;width:721px; height:668px; overflow:auto;" >
        <table border="0" cellspacing="0" >
            <tbody>
            <%showword(); %>
           </tbody>
        </table>
        
    </div>
    <div  style="position:absolute; left:30px; top:330px">
       
       <textarea type="text" id="TextBox_Word" name="TextBox_Word1" maxlength="100" runat="server" size="15" style="width:200px;height:150px;" /></br>
       <input type="text" id="TextBox_Name" name="TextBox_Name1" maxlength="100" runat="server" size="7" style="width:200px;height:20px;" /></br>
       
       <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="添加" />
        <% %>
    </div>
       
    </form>
</body>
</html>
