<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat" />
<%@ include file= "../connections/con_start.jsp" %>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<% 
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0); 
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<%@ page contentType="text/html; charset=gb2312"%>


<%
//��ȡϵͳʱ��
java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");    
Calendar   currentTime=Calendar.getInstance();
String sdate=df.format(currentTime.getTime()); //��ȡ��ǰʱ�䲢��ʽ��


  
//��ȡ��ǰ��¼����Ա
String sopId=(String)session.getValue("OpId"); //����ʹ�ô˾�
//String  sopId = staff.getOp_id(); //qcs�ϲ���ʹ�ô˾䣬һ����Ҫ�޸Ķ���class�����á�
if(sopId==null) sopId="";
	
//��ȡͳ����id
String sstatId= request.getParameter("statid");
if(sstatId==null) sstatId="";

//��ȡ�Ƿ����Ĭ�ϲ���Ա��ѯ��Ϣ��1--��Ҫ������ѯ����Ա������ݣ�����ֵ������Ҫ
String sInitSqlWhere="";
String sIsInit=request.getParameter("isinit");
if(sIsInit==null) sIsInit="";
if(sIsInit.equals("1") && !sopId.equals(""))
{
	sInitSqlWhere = " and op_id="+sopId;
}

    
//��ȡͳ����Ļ���������Ϣ
String sStatType="";
String sStatTable="";
String sStatWhere="";
Vector vStatdef=Stat.getStatDef(sstatId);
if(vStatdef.size()>0)
{
	HashMap vStatdefhash = (HashMap) vStatdef.get(0);
	sStatType = (String ) vStatdefhash.get("STAT_TYPE");
	sStatTable = (String ) vStatdefhash.get("STAT_TABLE");
	sStatWhere = (String ) vStatdefhash.get("STAT_WHERE");
	if(sStatWhere==null)
	{
		sStatWhere="";
	}	 	 
}
    

//��ȡ�����ѯ��ͳ�����ݹ�ѡ��Ϣ���� �����ʾ�ֶ�
String sIsChkShowField= request.getParameter("selectfield");
if(sIsChkShowField==null)
{
	sIsChkShowField="";
}

Vector vStatSelectfield=Stat.getStatfield(sstatId,"1");
String sIsChk[];
sIsChk = new String[vStatSelectfield.size()];
String sIsChkTemp="";
int c;
for(c=0;c<vStatSelectfield.size();c++)
{
	if(sIsChkShowField.indexOf("|")>=0)
	{
		sIsChkTemp=sIsChkShowField.substring(0,sIsChkShowField.indexOf("|"));
		sIsChk[c]=sIsChkTemp;
		sIsChkShowField=sIsChkShowField.substring(sIsChkShowField.indexOf("|")+1,sIsChkShowField.length());
	}
	else //�򿪽���ʱ����ѯ��ͳ������Ĭ�϶���ѡ��
	{
		sIsChk[c]="1"; 
	}
}
out.print(sIsChkShowField);

//��ȡ��ѯ��ͳ������
String salias="";
String saliasstr="";
String selectfield="";
String selectfieldstr="";
String selectfieldname="";
String selectfieldnamestr="";

String[] ALIAS;
ALIAS= new String[vStatSelectfield.size()];
int b=0;
if(vStatSelectfield.size()>0)
{
	for(int a=vStatSelectfield.size()-1;a>=0;a--)
	{		
		b++;
		HashMap StatSelectfieldhash = (HashMap) vStatSelectfield.get(a);
		saliasstr=(String) StatSelectfieldhash.get("ALIAS");
		selectfieldstr=(String) StatSelectfieldhash.get("FIELD_SN");
		selectfieldname=(String) StatSelectfieldhash.get("FIELD_NAME");
		ALIAS[b-1]=saliasstr.toUpperCase().replaceFirst("AS","").replaceAll(" ","");
		if(sIsChk[b-1].equals("1"))
		{
			selectfield=selectfield+","+selectfieldstr+" "+saliasstr; //ƴװselect���
			if(selectfieldname!=null && !selectfieldname.equals(""))
			{
				selectfieldnamestr=selectfieldnamestr+","+selectfieldname;
			}
		}
	}
}
selectfield="select " + selectfield.replaceFirst(",",""); //ȥ����һ��","�ţ�����ƴװsql���
selectfieldnamestr=selectfieldnamestr.replaceFirst(",",""); //ȥ����һ��",",����ƴװorder by����group by


 
//��ȡ��ѯͳ������
String swherefieldsn="";
String swherefielddisplaytype="";
String swherefieldstr="";
int ifield=0;
Vector vStatWherefield=Stat.getStatfield(sstatId,"2");
if(vStatWherefield.size()>0)
{
	for(ifield=vStatWherefield.size()-1;ifield>=0;ifield--)
    {
    	HashMap StatWherefieldhash = (HashMap) vStatWherefield.get(ifield);
        swherefieldsn=(String) StatWherefieldhash.get("FIELD_SN");
        swherefielddisplaytype=(String) StatWherefieldhash.get("DISPLAY_TYPE");
        swherefieldstr=swherefieldstr+"&&"+swherefieldsn+"|"+swherefielddisplaytype;
     }
}

//��ȡ��ѡ�Ĳ�ѯ������ֵ��ƴװsql����where����
Vector vResult= new Vector();
String wherefiledstr=new String( request.getParameter("wherefiled").getBytes("iso8859-1"), "gb2312"); 
String wherefiledstrtemp="";
String wherefield="";
String wherefieldtemp="";
String wherefiledname="";
String wherefiledtype="";
String wherefiledvalue="";
String sSql="";

int iwhere=0;

//out.print("wherefiledstr="+wherefiledstr);
if(!wherefiledstr.equals("index")||(wherefiledstr.equals("index")&& sIsInit.equals("1"))) //"index"��ʼֵ��Stat.Index.jspҳ����ת���ݹ���������ƴװsql���;�˴��ж�ֵ��Ϊ"index"
{
	for(iwhere=0;iwhere<vStatSelectfield.size()+1;iwhere++)
	{
		wherefieldtemp="";
		if(wherefiledstr.indexOf("^^")>0)
		{
			wherefiledstrtemp=wherefiledstr.substring(0,wherefiledstr.indexOf("^^"));
			wherefiledstr=wherefiledstr.substring(wherefiledstr.indexOf("^^")+2,wherefiledstr.length());
			//out.print("<br>wherefiledstrtemp="+wherefiledstrtemp);
			//out.print("<br>wherefiledstr="+wherefiledstr);
			if(wherefiledstrtemp.indexOf("|")>0)
			{
				wherefiledname=wherefiledstrtemp.substring(0,wherefiledstrtemp.indexOf("|"));
				wherefiledstrtemp=wherefiledstrtemp.substring(wherefiledstrtemp.indexOf("|")+1,wherefiledstrtemp.length());
				wherefiledtype=wherefiledstrtemp.substring(0,wherefiledstrtemp.indexOf("|"));
				wherefiledvalue=wherefiledstrtemp.substring(wherefiledstrtemp.indexOf("|")+1,wherefiledstrtemp.length());
				if(wherefiledtype.equals("1")) //text�����
				{
					wherefieldtemp=" and "+ wherefiledname+" like '%"+ wherefiledvalue+"%'";
				}
				else if(wherefiledtype.equals("2")) //select��list�򣬵�ѡ��ֵΪid��
				{
					wherefieldtemp=" and "+ wherefiledname+" = "+ wherefiledvalue ;
				}
				else if(wherefiledtype.equals("3")) //checkbox����ѡ��ֵΪid��
				{
					wherefieldtemp=" and "+ wherefiledname+" in ("+ wherefiledvalue+")";
				}
				else if(wherefiledtype.equals("4")) //select��list�򣬵�ѡ��ֵΪname
				{
					wherefieldtemp=" and "+ wherefiledname+" = '"+ wherefiledvalue+"'";
				}
				else if(wherefiledtype.equals("5")) //��ʼʱ��
				{
					wherefieldtemp=" and to_char("+wherefiledname+",'yyyymmddhh24miss')>="+ wherefiledvalue;
				}
				else if(wherefiledtype.equals("6")) //����ʱ��
				{
					wherefieldtemp=" and to_char("+wherefiledname+",'yyyymmddhh24miss')<="+ wherefiledvalue;
				}
				else
				{
					wherefieldtemp="";
				}
			}
		}				
		
		wherefield=wherefield+" "+wherefieldtemp;
	}
	wherefield=" where 1=1" + wherefield + sInitSqlWhere +sStatWhere ;
}


//�������Ϊͳ�ƣ�����select��Ĭ�����������Ͱٷֱ������ֶ�
if(sStatType.equals("1"))
{
   selectfield=selectfield+",count(*) as count ,trim(to_char(count(*)/(select count(*) "+ sStatTable+wherefield+" )*100.0,'999999999990.99'))||'%' as percent";
}

String sStatOrderby="";
String sStatGroupby="";
if(!selectfieldnamestr.equals(""))
{
	sStatOrderby=" order by "+selectfieldnamestr;
	sStatGroupby=" group by "+selectfieldnamestr;
}

//if(!wherefiledstr.equals("index")) //����Ĭ�ϲ����Ա�Ĺ���
if(!wherefiledstr.equals("index")||(wherefiledstr.equals("index")&& sIsInit.equals("1")))
{
	if(sStatType.equals("1")) //ͳ��
	{
		sSql=selectfield+" "+sStatTable+" "+wherefield+" "+sStatGroupby+" "+sStatOrderby;
	}
	else//��ѯ
	{
		sSql=selectfield+" "+sStatTable+" "+wherefield+" "+sStatOrderby;
	}
	vResult=Stat.returnResult(sSql);
	Stat.InertLog(sstatId,sSql,sopId);
}
//out.print("<br>sSql="+sSql);

%>

<title>StatIntf</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<script language="JavaScript" type="text/JavaScript">

function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}

function loadPage(url) 
{
		window.location = url;
}

function commit(form)
{   
   var opertype=form.opertype.value;
   form.submit();
}

function openNewWindow(sid)
{
    if(sid!="")
    {
       var type="";
       var value="";
       type=sid.substr(0,1);
       value=sid.substr(1,sid.length);
   	   
       if(type=="R") //����
       {
          window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+value);
       }
       else if(type=="F")     //����
       {
          window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+value);
       }
       else
       {
       		alert("idֵ����ȷ�����飡");
       }
     }
}

function goToURL(url)
{
   var selectfiled="";
   var fromtable="<%=sStatTable%>";
   var orderby="<%=sStatOrderby%>";
   var groupby="<%=sStatGroupby%>";
   var wherefiled="";
   var wherefiled1="";
   var wherefiledtemp="";   
   var stattype="<%=sStatType%>";
   var wherefiledstr="<%=swherefieldstr%>" 
   var wherefieldname="";
   var wherefieldtype="";
   var wherefiledtempid="";
   var showfiledstr="";
   var showfieldtemp="";
   var statid="<%=sstatId%>"
   var sql="";
   var i=0;
   var whereArray = new Array();

   
   //��ȡ��ѯ��ͳ�����ݣ�ƴ��select+�ֶ���
   var checkbox = document.getElementsByName("selectfield");     
   for (var i = 0; i < checkbox.length; i++)   
    {   
	    var selectfiledTemp="";
	    if (checkbox[i].checked)   
	    {   
			//selectfiledTemp=',' + checkbox[i].value ;  
			//selectfiled = selectfiled + selectfiledTemp; 
			showfieldtemp="1"; //���ѡ�񣬱��Ϊ1
	    }
	    else
	    {
	       showfieldtemp="0" //δѡ�У����Ϊ0
	    }
	       showfiledstr=showfiledstr+showfieldtemp+"|";
    }
    //selectfiled = "select " + selectfiled.replace(',',''); //ȥ����һλ����,����ƴsql��



	//����where�����ֶε����ֺ����ͣ���ȡ�����ֵ��ƴװwhere����
	if(wherefiledstr!="")
	{
		wherefiledstr=wherefiledstr.substring(2,wherefiledstr.length)
		whereArray=wherefiledstr.split("&&");
		for(i=0;i<whereArray.length;i++)
		{
			wherefieldname="";
   			wherefieldtype="";
   			wherefieldname=whereArray[i].substring(0,whereArray[i].indexOf("|")); //��ȡ����ؼ�����
   			wherefieldtype=whereArray[i].substring(whereArray[i].indexOf("|")+1,whereArray[i].length);//��ȡ�ؼ�����
   			
   			if(wherefieldtype==1)  //text��
   			{
   				wherefiledtempid="";
   				wherefiledtempid=wherefieldname+"text"; //ƴtext�������
   				if(document.getElementById(wherefieldname).checked==true)
   				{
   					wherefiledtemp=document.getElementById(wherefiledtempid).value;
   					if(wherefiledtemp!="")
   					{
   						//wherefiled1=" and "+wherefieldname+" like '%"+wherefiledtemp+"%'";
   						wherefiled1=wherefieldname+"|"+wherefieldtype+"|"+wherefiledtemp+"^^";
   					}
   					else
   					{
   						wherefiled1="0^^";
   					}
   				}	
   				else
   				{
   					wherefiled1="0^^";
   				}
   			}
   			if(wherefieldtype==2) //select��,valueֵΪidֵ
   			{
   				wherefiledtempid="";
   				wherefiledtempid=wherefieldname+"select"; //ƴselect�������
   				if(document.getElementById(wherefieldname).checked==true)
   				{
   					wherefiledtemp=document.getElementById(wherefiledtempid).value;
   					if(wherefiledtemp!="" && wherefiledtemp!=null)
   					{
   						wherefiledtemp=document.getElementById(wherefiledtempid).value;
   						//wherefiled1=" and "+wherefieldname+"="+wherefiledtemp;
   						wherefiled1=wherefieldname+"|"+wherefieldtype+"|"+wherefiledtemp+"^^";
   					}
   					else
   					{
   						wherefiled1="0^^";
   					}
   				}
   				else
   				{
   					wherefiled1="0^^";
   				}
   			}
   			if(wherefieldtype==4) //select��,valueֵΪnameֵ
   			{
   				wherefiledtempid="";
   				wherefiledtempid=wherefieldname+"select"; //ƴselect�������
   				if(document.getElementById(wherefieldname).checked==true)
   				{
   					wherefiledtemp=document.getElementById(wherefiledtempid).value;
   					if(wherefiledtemp!="" && wherefiledtemp!=null)
   					{
   						wherefiledtemp=document.getElementById(wherefiledtempid).value;
   						//wherefiled1=" and "+wherefieldname+"='"+wherefiledtemp+",'";
   						wherefiled1=wherefieldname+"|"+wherefieldtype+"|"+wherefiledtemp+','+"^^";
   					}
   					else
   					{
   						wherefiled1="0^^";
   					}
   				}
   				else
   				{
   					wherefiled1="0^^";
   				}
   			}
   			if(wherefieldtype==3) //�ɶ�ѡ��checkbox
   			{
   				var wherefiledtemp1="";
   				wherefiledtemp="";
   				var checkbox = document.getElementsByName(wherefieldname);   
			    for (var k = 0; k < checkbox.length; k++)   
			    {   
				    wherefiledtemp1="";
				    if (checkbox[k].checked)   
				    {   
						wherefiledtemp1 = ',' + checkbox[k].value;
				    }
				    wherefiledtemp = wherefiledtemp+wherefiledtemp1;
			    }
			     wherefiledtemp = wherefiledtemp.replace(',',''); //ȥ����һλ����,����ƴsql��
			     if(wherefiledtemp=="")
			     {
			     	wherefiled1="0^^";
			     }
			     else
			     {
			     	//wherefiled1=" and "+wherefieldname+" in ("+wherefiledtemp+")";
			     	wherefiled1=wherefieldname+"|"+wherefieldtype+"|"+wherefiledtemp+"^^";
			     }
   			}
   			if(wherefieldtype==5)  //����ʱ��
   			{
   				wherefiledtempid="";
   				wherefiledtempid=wherefieldname+"start"; //ƴtext�������
   				if(document.getElementById(wherefieldname).checked==true)
   				{
   					wherefiledtemp=document.getElementById(wherefiledtempid).value;
   					if(wherefiledtemp!="")
   					{
   						//����ʱ���ʽ����ʼʱ��
   						if((wherefiledtemp!=null)&&(wherefiledtemp!=""))
						{
						  	var time=wherefiledtemp.replace("-","");
						   	time=time.replace("-","");
						   	wherefiledtemp=time+"000000";
						}
						wherefiled1=wherefieldname+"|"+wherefieldtype+"|"+wherefiledtemp+"^^";
   					}
   					else
   					{
   						wherefiled1="0^^";
   					}
   				}	
   				else
   				{
   					wherefiled1="0^^";
   				}
   			}
   			if(wherefieldtype==6)  //����ʱ��
   			{
   				wherefiledtempid="";
   				wherefiledtempid=wherefieldname+"end"; //ƴtext�������
   				if(document.getElementById(wherefieldname).checked==true)
   				{
   					wherefiledtemp=document.getElementById(wherefiledtempid).value;
   					if(wherefiledtemp!="")
   					{
   						//����ʱ���ʽ������
   						if((wherefiledtemp!=null)&&(wherefiledtemp!=""))
						{
						  	var time1=wherefiledtemp.replace("-","");
						    time1=time1.replace("-","");
						    wherefiledtemp=time1+"235959";
						}
						wherefiled1=wherefieldname+"|"+wherefieldtype+"|"+wherefiledtemp+"^^";
   					}
   					else
   					{
   						wherefiled1="0^^";
   					}
   				}	
   				else
   				{
   					wherefiled1="0^^";
   				}
   			}
   			
   			wherefiled=wherefiled+wherefiled1;
		//wherefiled=" where 1=1" + wherefiled;
	}    
    
    
   //�ж�sql�����select��from��Ϊ�գ���Ϊ�գ�sql���Ϊ�գ���֮ƴsql���
    if((selectfiled+fromtable)=="")
    {
    	sql="";
    }
    else
    {
    	sql= selectfiled+fromtable+wherefiled+groupby+orderby;
    }
  }  
  window.location=url+"?statid="+statid+"&selectfield="+showfiledstr+"&wherefiled="+wherefiled;
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StatIntf" method="post" onSubmit="">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>��ѯ��ͳ������:<br>
          </td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="contentbottomline">
            <table width="100%" border="0" cellspacing="0" cellpadding="1">
            <tr  class="contentbg1">&nbsp;</tr>
            
            <tr class="contentbg" >
            <%
                int i=0;
                int a1=0;
                String sSelectFieldSN="";
                String sSelectFieldCN="";
                String sAlias="";
                if(vStatSelectfield.size()>0)
                {
                	for(i=vStatSelectfield.size()-1;i>=0;i--)
                	{
                		HashMap StatSelectfieldhash = (HashMap) vStatSelectfield.get(i);
						sSelectFieldSN=(String) StatSelectfieldhash.get("FIELD_SN");
						sSelectFieldCN=(String) StatSelectfieldhash.get("FIELD_CN");
              			sAlias=(String) StatSelectfieldhash.get("ALIAS");
              			ALIAS[b-1]=saliasstr.toUpperCase().replaceFirst("AS","").replaceAll(" ","");
              			if(sIsChk[a1].equals("1"))
              			{	  	
			%>
			
			<input type="checkbox" name="selectfield" value="<%out.print(sSelectFieldSN+" "+sAlias); %>"  checked><font class="pagetextdetails"><%=sSelectFieldCN%>&nbsp;&nbsp;&nbsp;&nbsp;
            
            <%				
                	    }
                	    else
                	    {
            %>
			<input type="checkbox" name="selectfield" value="<%out.print(sSelectFieldSN+" "+sAlias); %>" ><font class="pagetextdetails"><%=sSelectFieldCN%>&nbsp;&nbsp;&nbsp;&nbsp;            
            <%    	    
                	    }
                	    a1++;
                	 }
                 }
                
            %>
            </tr>            
                
            <tr  class="contentbg1">&nbsp;</tr>
            </table></td></tr></table></td></tr></table></td></tr></table>
                                

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>��ѯ��ͳ��������<br>
          </td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
             <%
              	int k=0;
              	int k1=0;
              	String sWhereFieldSN="";
              	String sWhereFieldCN="";
              	String sWhereDisplayType="";
              	String sDataSource="";
              	
              	String ssql="";
             	ResultSet rs=null;
             	Statement stmt = conn.createStatement();
              	if(vStatWherefield.size()>0)
              	{
              		for(k=vStatWherefield.size()-1;k>=0;k--)
              		{
              			HashMap StatWherefieldhash = (HashMap) vStatWherefield.get(k);
              			k1++;
              			sWhereFieldSN=(String) StatWherefieldhash.get("FIELD_SN");
              			sWhereFieldCN=(String) StatWherefieldhash.get("FIELD_CN");
              			sWhereDisplayType=(String) StatWherefieldhash.get("DISPLAY_TYPE");
              			sDataSource=(String) StatWherefieldhash.get("DATA_SOURCE");
						if(sWhereDisplayType.equals("1"))
						{						  	
			 %>
			<tr class=<%if(k1%2!=0) out.print("contentbg"); if(k1%2==0) out.print("contentbg1");%> >
			<td width="10%" class="pagetitle1" style= "width: 550px; "><%=sWhereFieldCN %>:</td>
            <td width="90%" class="pagetextdetails">
            <input  type="checkbox" name="<%=sWhereFieldSN %>" id="<%=sWhereFieldSN %>" >
            <input  type="text" class="inputstyle" name="<%out.print(sWhereFieldSN+"text"); %>" id="<%out.print(sWhereFieldSN+"text");%>"   size="35">
            </td>
            </tr>
            <%				
                		}
                		else if(sWhereDisplayType.equals("2") || sWhereDisplayType.equals("4"))
                		{	
                
            %>
                
             <tr class=<%if(k1%2!=0) out.print("contentbg"); if(k1%2==0) out.print("contentbg1");%>>
             <td width="10%" class="pagetitle1" style= "width: 550px; "><%=sWhereFieldCN %>:</td>
             <td width="90%" class="pagetextdetails">
             <input  type="checkbox" name="<%=sWhereFieldSN %>" id="<%=sWhereFieldSN %>" >
             <select class="inputstyle"  style= "width: 550px; " name="<%out.print(sWhereFieldSN+"select"); %>" id="<%out.print(sWhereFieldSN+"select"); %>">
             <option value="" selected> -------------- ѡ������ -------------- </option>
             <%
             				if(!sDataSource.equals(""))	
             				{
             					
             					try
             					{
             						ssql=sDataSource;
             						if(ssql!="")
									{
										try
										{
											rs= stmt.executeQuery(ssql);
										}	
									    catch(Exception e)
										{
									       out.println(e.toString());
										}
									}
							    }
             					finally
             					{
             					}

             				}
             				if(sWhereDisplayType.equals("2"))
             				{
             					while(rs.next())
             					{
             %>
             <option value="<%=rs.getString("id")%>"  > <%=rs.getString("idname")%></option>
             <%				
             					}
             				}
             				else if(sWhereDisplayType.equals("4"))
             				{
             					while(rs.next())
             					{
             %>
             <option value="<%=rs.getString("name")%>"  > <%=rs.getString("idname")%></option>
             <%				
             					}
             				}
             %>
             </select>
             </td>
             </tr>
                
             <%
                	   	}
                	   	else if(sWhereDisplayType.equals("3"))
                	   	{
             %>
             <tr class=<%if(k1%2!=0) out.print("contentbg"); if(k1%2==0) out.print("contentbg1");%>>
             <td width="10%" class="pagetitle1" style= "width: 550px; "><%=sWhereFieldCN %>:</td>
             <td width="90%" class="pagetextdetails" >
             <%
             				if(!sDataSource.equals(""))	
             				{
             					
             					try
             					{
             						ssql=sDataSource;
									if(ssql!="")
									{
										try
										{
											rs = stmt.executeQuery(ssql);
										}	
									    catch(Exception e)
										{
									       out.println(e.toString());
										}
									}
							    }
             					finally
             					{
             					}

             				}
             				while(rs.next())
             				{
             %>
             <input  type="checkbox" name="<%=sWhereFieldSN %>" id="<%=sWhereFieldSN %>" value="<%=rs.getString("id")%>">
             <font class="pagetextdetails"><%=rs.getString("name")%>&nbsp;&nbsp;&nbsp;&nbsp;
             <%
             				}
             %>
             </td>
             </tr>
             <%  	   	
                	   	}
                	   	else if(sWhereDisplayType.equals("5"))
                	   	{
             %>
            <tr class=<%if(k1%2!=0) out.print("contentbg"); if(k1%2==0) out.print("contentbg1");%> >
			<td width="10%" class="pagetitle1" style= "width: 550px; "><%=sWhereFieldCN %>:</td>
            <td width="90%" class="pagetextdetails">
            <input  type="checkbox" name="<%=sWhereFieldSN %>" id="<%=sWhereFieldSN %>" >
            <input type="text" class="inputstyle" name="<%out.print(sWhereFieldSN+"start"); %>" id="<%out.print(sWhereFieldSN+"text");%>"  onClick="JSCalendar(this);"  value="<%=sdate%>" size="10">
            </td>
            </tr>
             <%   	   	
                	   	}
                	   	else if(sWhereDisplayType.equals("6"))
                	   	{
             %>
            <tr class=<%if(k1%2!=0) out.print("contentbg"); if(k1%2==0) out.print("contentbg1");%> >
			<td width="10%" class="pagetitle1" style= "width: 550px; "><%=sWhereFieldCN %>:</td>
            <td width="90%" class="pagetextdetails">
            <input  type="checkbox" name="<%=sWhereFieldSN %>" id="<%=sWhereFieldSN %>" >
            <input type="text" class="inputstyle" name="<%out.print(sWhereFieldSN+"end"); %>" id="<%out.print(sWhereFieldSN+"text");%>"  onClick="JSCalendar(this);"  value="<%=sdate%>" size="10">
            </td>
            </tr>
             <%   	   	
                	   	}
                	   	else
                	   	{
                	   		out.print("δ֪���ͣ������������ã�");
                	   	}
                	   }
              		}			
             %>                 
                
                <tr  class="contentbg">
                  <td class="pagetitle1" style= "width: 550px; ">&nbsp;</td>
                  <td>&nbsp;</td>
              	</tr>

	  			<tr> 
	          	<td class="contentbottomline"><div align="left"> 
	                <tr> 
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
				  </table></td>
	             <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	             <tr> 
	             <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="goToURL(/*href*/'Stat.Interface.jsp')">��ѯ</td>
	             </tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>
	             
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  		<tr class="title"> 
	  		<td>
	  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr class="title"> 
          	<td>��ѯ��ͳ�ƽ��:<%if(sIsInit.equals("1")) out.print(" (Ĭ�ϲ����ǰ��¼����Ա�����δ��������/�������)"); %><br>
         	</td>
          	<td width="24"> <div align="right"><br></div></td>
        	</tr>
      		</table></td>
  			</tr>
  			
   			<td>
          	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="resultlist">
          	<tr>
          	<%
          		//�����ѯͳ������Ϊ��2����ѯ�࣬ϵͳĬ������"���"�С�
          		if(sStatType.equals("2"))
          		{
          	%>
          	<td width="5%" class="pagecontenttitle">���<br></td>         	 
            <%	
            	}
            	int ilist=0;
            	int ashow=0;
            	String sSelectFieldSNforlist;
            	String sSelectFieldCNforlist;
            	String sSelectDisplayLengthforlist;
            	if(vStatSelectfield.size()>0)
                {
                	for(ilist=vStatSelectfield.size()-1;ilist>=0;ilist--)
                	{
                		HashMap StatSelectfieldforlisthash = (HashMap) vStatSelectfield.get(ilist);
						sSelectFieldCNforlist=(String) StatSelectfieldforlisthash.get("FIELD_CN");
						sSelectDisplayLengthforlist = (String) StatSelectfieldforlisthash.get("DISPLAY_LENGTH");
						if(sIsChk[ashow].equals("1"))
						{            	
            %>
            <td width="<%=sSelectDisplayLengthforlist %>" class="pagecontenttitle"><%=sSelectFieldCNforlist %><br></td>
			<%
						}
						ashow++;
					}
				}
				//�����ѯͳ������Ϊ��1��ͳ���࣬ϵͳĬ������"����"��"�ٷֱ�"�С�
				if(sStatType.equals("1"))
				{
			%>
			<td width="5%" class="pagecontenttitle">����<br></td>
			<td width="10%" class="pagecontenttitle">�ٷֱ�<br></td>
			<%
				}
			%>
            </tr>
            
            <%
            	int ishow=0;
            	int jshow=0;
            	int seq=0;
            	String ALIASValue[];
            	ALIASValue=new String[ALIAS.length];
            	String count="";
            	String percent="";
            	if(vResult.size()>0)
                {
                	for(ishow=vResult.size()-1;ishow>=0;ishow--)
                	{ 
            %>
            <tr>
            <%    	
                		if(sStatType.equals("2"))
                		{
                			seq++;
            %>
            <td width="10%" class="coltext"><%=seq %><br></td>
            <%    		
                		}
                		HashMap StatResulthash = (HashMap) vResult.get(ishow);
                		for(jshow=0;jshow<ALIAS.length;jshow++)
                		{
                			ALIASValue[jshow]=(String) StatResulthash.get(ALIAS[jshow]);
                			if(ALIASValue[jshow]==null)
                			{
                				ALIASValue[jshow]="";
                			}
                			if(sIsChk[jshow].equals("1"))
                			{
                				if(ALIAS[jshow].equals("DEMANDID"))
                				{
             %>
             <td class="coltext" ><a href="
             <%
             	if(!ALIASValue[jshow].equals(""))
             	{
             		String stype=ALIASValue[jshow].substring(0,1);
             		if(stype.equals("R"))
             		{
             			out.print("http://aiqcs.asiainfo-linkage.com/demand/query/demd_query_detail.jsp?op_id="+ALIASValue[jshow].substring(1,ALIASValue[jshow].length()));
             		}
             		else if(stype.equals("F"))
             		{
             			out.print("http://aiqcs.asiainfo-linkage.com/project/query/proj_query_result.jsp?op_id="+ALIASValue[jshow].substring(1,ALIASValue[jshow].length()));
             		}
             		else
             		{
             			out.print("#");
             		}
             	} 
             %>"  target="_blank"><%if(ALIASValue[jshow]!=null&&!ALIASValue[jshow].equals("")) out.print(ALIASValue[jshow]);else out.print("&nbsp;");%></a></td>
             <%     				
                				}
                	else if(ALIAS[jshow].equals("TASKID"))
                	{
             %>
             <td class="coltext" ><a href="
             <%
             	if(!ALIASValue[jshow].equals(""))
             	{
             		String stype=ALIASValue[jshow].substring(0,1);
             		if(stype.equals("T"))
             		{
             			out.print("http://aiqcs.asiainfo-linkage.com/task/query/task_query_detail.jsp?op_id="+ALIASValue[jshow].substring(1,ALIASValue[jshow].length()));
             		}
             		else
             		{
             			out.print("#");
             		}
             	} 
             %>"  target="_blank"><%if(ALIASValue[jshow]!=null&&!ALIASValue[jshow].equals("")) out.print(ALIASValue[jshow]);else out.print("&nbsp;");%></a></td>
             <%     				
                				}
                				
                	else
                	{
           %>
           <td class="coltext" ><%if(ALIASValue[jshow]!=null)out.print(ALIASValue[jshow]+ "&nbsp;");else out.print("&nbsp;");%></td>
           <%
                		    	}
                		    }
                		}
                			count=(String) StatResulthash.get("COUNT");
                			percent=(String) StatResulthash.get("PERCENT");
                		if(sStatType.equals("1"))
                		{	
           %>
           <td width="10%" class="coltext"><%=count %><br></td>
		   <td width="10%" class="coltext"><%=percent %><br></td>
		   </tr>
           <%     		
                		}
                	}
                }
            %>
            <tr>
          	<%
          		//�����ѯͳ������Ϊ��2����ѯ�࣬ϵͳĬ������"���"�С�
          		if(sStatType.equals("2"))
          		{
          	%>
          	<td width="5%" class="pagecontenttitle">���<br></td>         	 
            <%	
            	}
            	int ilist1=0;
            	int ashow1=0;
            	String sSelectFieldSNforlist1;
            	String sSelectFieldCNforlist1;
            	String sSelectDisplayLengthforlist1;
            	if(vStatSelectfield.size()>0)
                {
                	for(ilist=vStatSelectfield.size()-1;ilist>=0;ilist--)
                	{
                		HashMap StatSelectfieldforlisthash = (HashMap) vStatSelectfield.get(ilist);
						sSelectFieldCNforlist1=(String) StatSelectfieldforlisthash.get("FIELD_CN");
						sSelectDisplayLengthforlist1 = (String) StatSelectfieldforlisthash.get("DISPLAY_LENGTH");
						if(sIsChk[ashow1].equals("1"))
						{            	
            %>
            <td width="<%=sSelectDisplayLengthforlist1 %>" class="pagecontenttitle"><%=sSelectFieldCNforlist1 %><br></td>
			<%
						}
						ashow1++;
					}
				}
				//�����ѯͳ������Ϊ��1��ͳ���࣬ϵͳĬ������"����"��"�ٷֱ�"�С�
				if(sStatType.equals("1"))
				{
			%>
			<td width="5%" class="pagecontenttitle">����<br></td>
			<td width="10%" class="pagecontenttitle">�ٷֱ�<br></td>
			<%
				}
			%>
            </tr>
        
</table>
</td>
</table>
            <tr>&nbsp;</tr>
</form>	             
</body>
<%@ include file= "../connections/con_end.jsp" %>
</html>
                
