<%@include file="../allcheck.jsp"%>
<jsp:useBean id="Approval" scope="page" class="dbOperation.Approval" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<%@ include file= "../connections/con_start.jsp" %>
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
String sProductId="2,3,93,164,180,201,219";  
String sFlag=request.getParameter("sFlag");
if(sFlag==null) sFlag="0";

//��ȡ��ǰ��¼����Ա
  String sopId=(String)session.getValue("OpId");
//��ѯ[1]������/[3]�ٴ����е����񵥡���ѯ[6]��dev�����bug��
Vector vPendingTask=Approval.getPendingTask("1",sopId,"1,3","6");
  
Vector vVersion=QueryBaseData.querySysBaseType("APPLICATION_RECORD","VERSION");




%>

<%
	String sTemp= "";
	String sdate_s = "";
	String sDate="";
	String ssql17=""; //��ȡ������ϵͳ�µ�����ģ��
	String ssql19=""; //��ȡָ����ϵͳ
	String ssql23=""; //��ȡָ��һ����Ʒ�µ���ϵͳ
	String ssql24=""; //��ȡָ��һ����ϵͳ�µ�ģ��
	String ssql30=""; //��ȡָ�����в�Ʒ�µ�������ϵͳ
	ResultSet rs17=null;
	ResultSet rs19=null;	
	ResultSet rs23=null;
	ResultSet rs24=null;
	ResultSet rs30=null;
	Statement stmt17 = conn.createStatement();
	Statement stmt19 = conn.createStatement();	
	Statement stmt23 = conn.createStatement();
	Statement stmt24 = conn.createStatement();
	Statement stmt30 = conn.createStatement();
	
	String defProduct ="";
	String defSubsys ="";
	String defModule ="";
	String defGroup ="";
	String defOperator="";
	String Products="("+sProductId+")";
	
	try
	{		
		
		ssql17="select subsys_id as upid,module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		      +" from qcs.product_detail  where status = 1 and product_id in  "+Products+" order by upid,name";
//		out.println("ssql17="+ssql17+";\n");
		if(ssql17!="")
		{
			try
			{
				rs17 = stmt17.executeQuery(ssql17);
			}	
		    catch(Exception e)
			{
		       out.println(e.toString());
			}
		}

		  ssql19 = " select product_id id,product_name,'['||product_id||']'||product_name as name "
		      +" from qcs.product where product_id in "+Products+" order by name ";
//		  out.println("ssql17="+ssql17+";\n");
		  try
		  {
			  rs19 = stmt19.executeQuery(ssql19);
		  }
	      catch(Exception e)
		 {
	       out.println(e.toString());
		  }
		
		ssql23=" select subsys_id as id,substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn as name "
		      +" from qcs.subsys_def  where status=1 and PRJ_ID ='"+ defProduct +"' order by name";
//		out.println("ssql23="+ssql23+";\n");
		try{
			rs23 = stmt23.executeQuery(ssql23);
		}
	    catch(Exception e)
		{
	       out.println(e.toString());
		 }
		
		ssql24="select module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		      +" from qcs.product_detail  where  STATUS=1 and  SUBSYS_ID ='"+defSubsys+"' order by name";
//		out.println("ssql24="+ssql24+";\n");
		try
		{
			rs24 = stmt24.executeQuery(ssql24);
		}
	    catch(Exception e)
		{
	       out.println(e.toString());
		 }
		 
		ssql30="select prj_id as upid, subsys_id as id,"
		      +"substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn as name "
		      +"from qcs.subsys_def where status = 1 and prj_id in  "+Products+" order by upid,name";
//	   out.println("ssq30="+ssql30+";\n");
	   if (ssql30!=null)
	  	{
			try
			{
				rs30 = stmt30.executeQuery(ssql30);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}
	 	
	 			ssql30="select prj_id as upid, subsys_id as id,"
		      +"substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn as name "
		      +"from qcs.subsys_def where status = 1 and prj_id in  "+Products+" order by upid,name";
//	   out.println("ssq30="+ssql30+";\n");
	   if (ssql30!=null)
	  	{
			try
			{
				rs30 = stmt30.executeQuery(ssql30);
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
%>

<title>Requisitions</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">

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
	  //var a=form.requirement.value;
	  var checkbox = document.getElementsByName("taskid");  
	  var sVersion = document.all.versionid.options[document.all.versionid.selectedIndex].value;
	  var sProduct = document.all.PRODUCT_ID.options[document.all.PRODUCT_ID.selectedIndex].value;
      var sSubSystem =document.all.select_subsys.options[document.all.select_subsys.selectedIndex].value;
      var sModule =document.all.MODULE_ID.options[document.all.MODULE_ID.selectedIndex].value;
      var a=0;  
      
     if(checkbox.length>0)
     {
     	for (var i = 0; i < checkbox.length; i++)
     	{
	     	if (checkbox[i].checked)
	     	{
	     		a=a+1;
	     	}
     	}
     	if(a==0)
     	{
     		alert("��ѡ�� ���������� ���ٵ��<�ύ����>��ť!");
     	}
	     else if(sVersion=="")
	     {
	      	alert("��ѡ�� ����汾 ���ٵ��<�ύ����>��ť!");
	        document.all.versionid.focus();
	      }
	      else if(sProduct="")
	      {
	      	alert("��ѡ�� ��Ʒ ���ٵ��<�ύ����>��ť!");
	          document.all.PRODUCT_ID.focus();
	      }
	      
	      else if(sSubSystem=="")
	      {
	          alert("��ѡ�� ��ϵͳ ���ٵ��<�ύ����>��ť!");
	          document.all.select_subsys.focus();
	      }
	      else if(sModule=="")
	      {
	          alert("��ѡ�� ģ�� ���ٵ��<�ύ����>��ť!");
	          document.all.MODULE_ID.focus();
	      }
	    else
	    {
	    	form.submit();
	    }
    }
    else
    {
    	alert("�޴��������񣬲����ύ���뵥!");
    }
}


function onProductChange()
	{
		var value1=document.getElementById("PRODUCT_ID").value;

		//ȡģ����Ϣ
		//getSubsys();	
		getSubsysChange();	
	
	}

function getSubsysChange()
	{
		var value1=document.getElementById("PRODUCT_ID").value;
	
		//ȡ��ϵͳ��Ϣ
		document.getElementById("select_subsys").options.length=1;
		document.getElementById("MODULE_ID").options.length=1;
		var lenOption=document.getElementById("allSubsys").options.length;
		var rValue;
		for (var i=0;i<document.getElementById("allSubsys").options.length;i++)
		{
		  len = document.getElementById("allSubsys").options[i].value.indexOf("*");
		  if (document.getElementById("allSubsys").options[i].value.substring(0,len)==value1)
		  {
				//alert(document.open.allProject.options[i].value.substring(0,len)+":"+value1);
				document.getElementById("select_subsys").add(window.Option.create(document.getElementById("allSubsys").options[i].text,document.getElementById("allSubsys").options[i].value.substring(len+1),0));
		  }
		}
	}	
	
function getModuleChange()
	{
		var value1=document.getElementById("select_subsys").value;
	
		//ȡ��ϵͳ��Ϣ
		document.getElementById("MODULE_ID").length=1;
		var lenOption=document.getElementById("allModule").options.length;
		var rValue;

		for (var i=0;i<document.getElementById("allModule").options.length;i++)
		{
		  len = document.getElementById("allModule").options[i].value.indexOf("*");
		  if (document.getElementById("allModule").options[i].value.substring(0,len)==value1)
		  {
				//alert(document.open.allProject.options[i].value.substring(0,len)+":"+value1);
				document.getElementById("MODULE_ID").add(window.Option.create(document.getElementById("allModule").options[i].text,document.getElementById("allModule").options[i].value.substring(len+1),0));
		  }
		}
	}


var Flag=<%=sFlag%>
if(Flag=='1')
{
alert("�ύ�ɹ���");
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="Requisitions" method="post" action="Approval.OperRequisitionsInfo.jsp"> 
<input type="hidden" value="<%out.print("");%>" name="slips">
<input type="hidden" value="<%out.print("");%>" name="sassignment">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">       
          <td><br></br>�������뵥:
          <br></br>
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
                 <tr class="contentbg">
                  <td width="15%" class="pagetitle1">����������</td>
                  <td width="85%" class="pagetextdetails"> 
                  <%
                    String sTaskType="";
                    String sTaskName="";
                    String sTaskId="";
                    if(vPendingTask.size()>0)
				  	{
				  		for(int i=vPendingTask.size()-1;i>=0;i--)
				  		{
				  			HashMap PendingTask = (HashMap) vPendingTask.get(i);
				  			sTaskType = (String)PendingTask.get("TYPE");
				  			sTaskName = (String)PendingTask.get("NAME");
				  			sTaskId = (String)PendingTask.get("ID");
				  			if(sTaskType.equals("1"))
				  			{
				  				%>
				  				<input type="checkbox" value="<%out.print(sTaskType+'|'+sTaskId);%>" name="taskid"><font class="pagetextdetails"><%out.print("&nbsp;���񵥣�"+sTaskName);%>&nbsp;&nbsp;</font><br>
				  				<%
				  			}
				  			else if(sTaskType.equals("2"))
				  			{
				  				%>
				  				<input type="checkbox" value="<%out.print(sTaskType+'|'+sTaskId);%>" name="taskid"><font class="pagetextdetails"><%out.print("&nbsp;BUG����"+sTaskName);%>&nbsp;&nbsp;</font><br>
				  				<%
				  			}
				  		}
				 	 }
                  %>
                  </td>
                </tr>
                
                <tr>
                  <td width="15%" class="pagetitle1" style= "height: 40px; ">����汾��</td>
                  <td width="85%"><select  style= "width: 660px; " name="VERSION_ID" id="versionid" class="inputstyle" size="1">
                 <option value="" selected>-------------- ѡ������ --------------</option>
                     <%
						String sId="";
	                    String sName="";
	                    if(vVersion.size()>0)
					  	{
					  		for(int j=vVersion.size()-1;j>=0;j--)
					  		{
					  			HashMap Version = (HashMap) vVersion.get(j);
					  			sId = (String)Version.get("CODE_VALUE");
					  			sName = (String)Version.get("CNAME");
					  	%>
					  	<option value="<%=sId%>" > <%out.print("["+sId+"] "+sName);%></option>   
					  	<%
					  		}
					  	}
					 %>
                    </select>
                  
                  </td>
                </tr>
                
                <tr class="contentbg">
                  <td width="15%" class="pagetitle1" style= "height: 40px; ">��Ʒ��</td>
                  <td width="85%"><select style= "width: 660px; " name="PRODUCT_ID" class="inputstyle" id="PRODUCT_ID" onChange="onProductChange();">
                      <option value="" selected> -------------- ѡ������ -------------- </option>
                   	  <%
						while(rs19.next())
						{
					  %>
                      <option value="<%=rs19.getString("id")%>"  > <%=rs19.getString("name")%></option>
                      <%
						}
					  %>           
                    </td>
                </tr>
                    
                
                 <tr>
                  <td width="15%" class="pagetitle1" style= "height: 40px; ">��ϵͳ��</td>
                  <td width="85%"><select style= "width: 660px; " name="select_subsys" id="select_subsys" size="1"  class="inputstyle"  width="350"  onChange="getModuleChange();">
                      <option value="" selected> -------------- ѡ������ -------------- </option>
                     <%
						while(rs23.next())
						{
					 %>
                      <option value="<%=rs23.getString("id")%>" > <%=rs23.getString("name")%></option>
                     <%
						}
					 %>
                    </select>
                    <DIV align=left style="display:none">
                      <select name="allSubsys" id="allSubsys">
                        <%
							while(rs30.next())
							{
							sTemp= rs30.getString("upid")+"*"+rs30.getString("id");
						%>
						<option value="<%=sTemp%>"> <%=rs30.getString("name")%></option>
                        <%
							}
						%>
                      </select>
                    </DIV>                  
                    </td>
                </tr>
                              
                <tr class="contentbg">
                  <td width="15%" class="pagetitle1" style= "height: 40px; ">ģ�飺</td>
                  <td width="85%" class="pagetextdetails"><select  style= "width: 660px; " name="MODULE_ID" class="inputstyle" id="MODULE_ID">
                      <option value="" selected> -------------- ѡ������ -------------- </option>
                      <%
						while(rs24.next())
						{
					  %>
                      <option value="<%=rs24.getString("id")%>" ><%=rs24.getString("name")%></option>
                      <%
						}
					  %>
                    </select>
                    <DIV align=left style="display:none">
                      <select name="allModule" id="allModule">
                        <%
						  while(rs17.next())
						   {
							  sTemp= rs17.getString("upid")+"*"+rs17.getString("id");
						%>
                        <option value="<%=sTemp%>"> <%=rs17.getString("name")%></option>
                        <%
							}
						%>
                      </select>
                    </DIV>                  
                    </td>
                </tr>
                  
                <tr>
                  <td width="15%" class="pagetitle1" style= "height: 40px; ">�漰�����</td>
                  <td width="85%">
                  <input type="checkbox" name="OBD"><font class="pagetextdetails"><%out.print("�Ƿ���OBD���");%>&nbsp;&nbsp;</font>
                  <input type="checkbox" name="DB"><font class="pagetextdetails"><%out.print("�Ƿ���DB���");%>&nbsp;&nbsp;</font>
                  </td>
                </tr>
                
                <tr class="contentbg">
                  <td width="15%" class="pagetitle1" style= "height: 40px; ">����˵����</td>
                  <td width="85%">
                  <textarea style= "width: 660px; " class="inputstyle" rows="4" name="REMARK" id="remark" cols="133" ></textarea>
                  </td>
                </tr>
                  
	  			<tr> 
	          	<td class="contentbottomline"><div align="left"> 
	                <tr> 
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1"></table></td>
	             <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	             <tr> 
	                <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">�ύ����
      				<input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="commit(this.form)" ></td>
	             </tr>                
             </table></td></tr></table></td></tr></table></td></tr></table></td></tr></table></form>
</body>
<%@ include file= "../connections/con_end.jsp"%>
</html>
                
