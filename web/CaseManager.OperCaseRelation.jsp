<jsp:useBean id="CaseInfo" scope="page" class="dbOperation.CaseInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%@ page import="com.jspsmart.upload.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>OperDemandRelation</title>
</head>
<script language="JavaScript" type="text/JavaScript">
</script>
<% 
   String sRMId=request.getParameter("requirement"); //获取源需求id
   if(sRMId==null) sRMId="";
   out.print("<br>源需求编号为："+sRMId); 
     
   String sOpId=request.getParameter("sOpId"); //获取登录操作员
   if(sOpId==null) sOpId="";
   out.print("<br>操作员编号为："+sOpId);
   
   String sRemark=request.getParameter("remark"); //获取备注信息
   if(sRemark==null) sRemark="";
   out.print("<br>增加备注信息："+sRemark);
   
   Vector vRemandRelationList=new Vector();
   String RemandRelationStr="";
   int iList=0;
   vRemandRelationList=CaseInfo.queryDemandRealtionMore(sRMId,"","0");
   iList=vRemandRelationList.size();
   String RelationDemandId="";
   String RelationDemandIdStr="";
   if(iList>0)
   {
   		for(int inum=iList-1;inum>=0;inum--)
        {
			HashMap RemandRelationListHash = (HashMap) vRemandRelationList.get(inum);
			RelationDemandId = (String) RemandRelationListHash.get("DEMAND_RELATE");
			RelationDemandIdStr=RelationDemandIdStr+","+RelationDemandId;
		}
	}


	
   //获取界面上radio选项，判断操作类型
   String OperFlag="";
   OperFlag=(String)request.getParameter("operflag");
   if(OperFlag.equals("1"))
   {
   	  out.print("<br>操作：增加关联");
   }
   else if(OperFlag.equals("2"))
   {
   	  out.print("<br>操作：删除关联");
   }
   else 
   {
   	  out.print("<br>操作：未知操作");
   }

   
   //获取界面选中checkbox的值，拼成字符串
   String[] sCheckValue =(String[])request.getParameterValues("checkbox");
   String sCheckData="";
   String sCheckDataNo="";

   if(OperFlag.equals("1")) //增加
   {
   	   if(sCheckValue!=null)    //当勾选checkbox,此值不为null
	   {	
	     for(int k=0;k<sCheckValue.length;k++)
	     {
	        
	        if(sCheckValue[k].equals(sRMId)) //如果选中列表中含当前源需求id，不提交数据，给出提示
	        {
	        	sCheckDataNo=sCheckDataNo+","+ sCheckValue[k];
	        	%>
	        	<script language="JavaScript">
					alert("不能将源需求关联源需求，源需求编号为:<%=sRMId%>。");
				</script> 
	            <%
	        }
	        else if(RelationDemandIdStr.indexOf(sCheckValue[k])>0) //选中需求id，已经与当前源需求存在关联关系，不提交数据
	        {
	        	sCheckDataNo=sCheckDataNo+","+ sCheckValue[k];
	        }
	        else
	        {
	            Vector vRemandRelationList0=new Vector();
	            Vector vRemandRelationList1=new Vector();
			    int iList0=0;
			    int iList1=0;
			    vRemandRelationList0=CaseInfo.queryDemandRealtionMore(sCheckValue[k],"","0");
			    vRemandRelationList1=CaseInfo.queryDemandRealtionMore("",sCheckValue[k],"0");
			    iList0=vRemandRelationList0.size();
			    iList1=vRemandRelationList1.size();
	        	if(iList0<=0 && iList1<=0)
	        	{
	        		CaseInfo.addDemandRealtion(sRMId,sCheckValue[k],"0",sOpId,sRemark);	
	        		sCheckData=sCheckData + "," + sCheckValue[k] ;
	        	}
	        	else
	        	{
	        	    sCheckDataNo=sCheckDataNo+","+ sCheckValue[k];
	        		%>
	        			<script language="JavaScript">
							alert("需求编号为：<%=sCheckValue[k]%>,已经被其他需求关联或关联其他需求，不能与当前源需求增加关联关系！");
						</script> 
	        		<%
	        	}
	        }
	      }
	       //如果有提交成功数据，才弹出以下提示，否则不提示
	        if(!sCheckData.equals(""))
	        {
	        %>
	        	<script language="JavaScript">
					alert("成功增加关联需求编号为：<%=sCheckData%>。未关联成功的需求编号为：<%=sCheckDataNo%>。");
				</script> 
	       <%
	      	}
	    }
	   else
	   {
	   		%>
	        	<script language="JavaScript">
					alert("没有选中关联的需求，请重新选择!");
				</script> 
	       <%        	
	   }
	   
	   %>
	      <script language="JavaScript">
	      	window.location="CaseManager.RelateDemand.jsp?requirement=<%=sRMId%>&relateflag=1&sOpId=<%=sOpId%>";
		  </script> 
	  <% 
	   
   }
   else if(OperFlag.equals("2")) //删除
   {
   	   if(sCheckValue!=null)    //当勾选checkbox,此值不为null
	   {	
	     for(int k=0;k<sCheckValue.length;k++)
	     {
			if(RelationDemandIdStr.indexOf(sCheckValue[k])>0)
	        {
	        	sCheckData=sCheckData+","+ sCheckValue[k];
	        }
	        else
	        {
	        	sCheckDataNo=sCheckDataNo + "," + sCheckValue[k] ;
	        }
	      }
	      //如果有存在数据，才进行删除，并弹出以下提示，否则操作
	      sCheckData=sCheckData.replaceFirst(",","");	      
	      if(!sCheckData.equals(""))
	        {
	        	CaseInfo.deleteDemandRealtion(sRMId,sCheckData,"0");
	        %>
	        	<script language="JavaScript">
					alert("成功删除的关联需求编号为：<%=sCheckData%>。未删除关联的需求编号为：<%=sCheckDataNo%>。");
				</script> 
	        <%
	        }
	   }
	   else
	   {
	   		%>
	        	<script language="JavaScript">
					alert("没有选中关联的需求，请重新选择!");
				</script> 
	       <%        	
	   }
	   
	   %>
	      <script language="JavaScript">
	      	window.location="CaseManager.RelateDemand.jsp?requirement=<%=sRMId%>&relateflag=1&sOpId=<%=sOpId%>";
		  </script> 
	  <% 
   }
   else
   {
   %>
	    <script language="JavaScript">
			alert("未知操作，联系管理员!");
		</script> 
   <% 
   }

%>
<body>

</body>
</html>