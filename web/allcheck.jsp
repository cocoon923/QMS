<%
  String sEntityFlagValue=(String)session.getValue("EntityFlag");
  if(sEntityFlagValue==null) sEntityFlagValue="";
  if(!sEntityFlagValue.equals("1"))
   {
     out.print("<script language='javascript'>history.go(-1);</script>");
  	}
  	
  //133pc add
  String sopIdlogin=(String)session.getValue("OpId");
  StringBuffer hosturlogin=request.getRequestURL();  
  String hosturllogin=hosturlogin.toString();
  hosturllogin=hosturllogin.substring(0,hosturllogin.indexOf("QMS"));
  if(sopIdlogin==null || sopIdlogin=="")
  {
  	response.sendRedirect(hosturllogin+"/QMS");
  }
%>