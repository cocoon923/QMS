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
   String sRMId=request.getParameter("requirement"); //��ȡԴ����id
   if(sRMId==null) sRMId="";
   out.print("<br>Դ������Ϊ��"+sRMId); 
     
   String sOpId=request.getParameter("sOpId"); //��ȡ��¼����Ա
   if(sOpId==null) sOpId="";
   out.print("<br>����Ա���Ϊ��"+sOpId);
   
   String sRemark=request.getParameter("remark"); //��ȡ��ע��Ϣ
   if(sRemark==null) sRemark="";
   out.print("<br>���ӱ�ע��Ϣ��"+sRemark);
   
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


	
   //��ȡ������radioѡ��жϲ�������
   String OperFlag="";
   OperFlag=(String)request.getParameter("operflag");
   if(OperFlag.equals("1"))
   {
   	  out.print("<br>���������ӹ���");
   }
   else if(OperFlag.equals("2"))
   {
   	  out.print("<br>������ɾ������");
   }
   else 
   {
   	  out.print("<br>������δ֪����");
   }

   
   //��ȡ����ѡ��checkbox��ֵ��ƴ���ַ���
   String[] sCheckValue =(String[])request.getParameterValues("checkbox");
   String sCheckData="";
   String sCheckDataNo="";

   if(OperFlag.equals("1")) //����
   {
   	   if(sCheckValue!=null)    //����ѡcheckbox,��ֵ��Ϊnull
	   {	
	     for(int k=0;k<sCheckValue.length;k++)
	     {
	        
	        if(sCheckValue[k].equals(sRMId)) //���ѡ���б��к���ǰԴ����id�����ύ���ݣ�������ʾ
	        {
	        	sCheckDataNo=sCheckDataNo+","+ sCheckValue[k];
	        	%>
	        	<script language="JavaScript">
					alert("���ܽ�Դ�������Դ����Դ������Ϊ:<%=sRMId%>��");
				</script> 
	            <%
	        }
	        else if(RelationDemandIdStr.indexOf(sCheckValue[k])>0) //ѡ������id���Ѿ��뵱ǰԴ������ڹ�����ϵ�����ύ����
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
							alert("������Ϊ��<%=sCheckValue[k]%>,�Ѿ��������������������������󣬲����뵱ǰԴ�������ӹ�����ϵ��");
						</script> 
	        		<%
	        	}
	        }
	      }
	       //������ύ�ɹ����ݣ��ŵ���������ʾ��������ʾ
	        if(!sCheckData.equals(""))
	        {
	        %>
	        	<script language="JavaScript">
					alert("�ɹ����ӹ���������Ϊ��<%=sCheckData%>��δ�����ɹ���������Ϊ��<%=sCheckDataNo%>��");
				</script> 
	       <%
	      	}
	    }
	   else
	   {
	   		%>
	        	<script language="JavaScript">
					alert("û��ѡ�й���������������ѡ��!");
				</script> 
	       <%        	
	   }
	   
	   %>
	      <script language="JavaScript">
	      	window.location="CaseManager.RelateDemand.jsp?requirement=<%=sRMId%>&relateflag=1&sOpId=<%=sOpId%>";
		  </script> 
	  <% 
	   
   }
   else if(OperFlag.equals("2")) //ɾ��
   {
   	   if(sCheckValue!=null)    //����ѡcheckbox,��ֵ��Ϊnull
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
	      //����д������ݣ��Ž���ɾ����������������ʾ���������
	      sCheckData=sCheckData.replaceFirst(",","");	      
	      if(!sCheckData.equals(""))
	        {
	        	CaseInfo.deleteDemandRealtion(sRMId,sCheckData,"0");
	        %>
	        	<script language="JavaScript">
					alert("�ɹ�ɾ���Ĺ���������Ϊ��<%=sCheckData%>��δɾ��������������Ϊ��<%=sCheckDataNo%>��");
				</script> 
	        <%
	        }
	   }
	   else
	   {
	   		%>
	        	<script language="JavaScript">
					alert("û��ѡ�й���������������ѡ��!");
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
			alert("δ֪��������ϵ����Ա!");
		</script> 
   <% 
   }

%>
<body>

</body>
</html>