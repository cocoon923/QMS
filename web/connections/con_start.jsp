<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<%@ page import="java.io.PrintStream"			%>
<%@ page import="java.net.URLEncoder"			%>
<%@ page import="javax.servlet.ServletRequest"	%>
<%@ page import="javax.servlet.http.*"			%>
<%@ page import="javax.naming.*	"				%>

<%@ page import="java.text.*	"				%>
<%@ page import="java.util.*	"				%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%@ page import="oracle.jdbc.driver.*,
		 oracle.jdbc.pool.*"
%>


<%!
	public String getStr(String str)
	{
		try
		{
			String temp_p=str;
//			byte[]temp_t=temp_p.getBytes("ISO8859-1");
			String temp=new String(temp_p.getBytes("ISO-8859-1"), "gb2312");
			return temp;
		}
		catch(Exception e)
		{
		
		}
		return "null";
	}
%>
<%!
	public String GetStrTrim(String str)
	{
		try
		{
			String temp_p=str;
		  if (temp_p!=null)
		    temp_p=temp_p.trim();
			if (temp_p==null || temp_p.compareTo("")==0)
			{
			return "&nbsp";
			}
			else
			{
			return temp_p.trim();
			}
		}
		catch(Exception e)
		{
		}
		return "null";
	}
%>
<%!
	public String GetStrTrim1(String str)
	{
		try
		{
			String temp_p=str;
			if (temp_p==null || temp_p.compareTo("")==0)
			{
			return "";
			}
			else
			{
			return temp_p.trim();
			}
		}
		catch(Exception e)
		{
		}
		return "null";
	}
%>
<%!
  /**
   * ��str��str1�滻Ϊstr2
   * @param str String   ԭʼ�ַ���
   * @param str1 String  ��Ҫ���滻���ַ���
   * @param str2 String  �滻����
   * @return String      �滻����ַ���
   */
  private static String replaceStr(String str,String str1,String str2)
  {
      if (str == null || str1 == null || str2 == null)
          return str;
      if (str1.equals(""))
          return str;

      StringBuffer sbReplaced = new StringBuffer("");
      String strSwap =  new String(str);
      while (strSwap.indexOf(str1) >= 0)
      {
          int i = strSwap.indexOf(str1);
          sbReplaced.append(strSwap.substring(0,i));
          sbReplaced.append(str2);
          strSwap = strSwap.substring(i+str1.length());
      }
      sbReplaced.append(strSwap);

      return sbReplaced.toString();
  }
  
   //��XML���תΪ������ţ���"&amp; &lt; &gt;&quot;&apos;"ת���ɡ�& < > " '��
  /**
   * ��XML���תΪ������ţ���"&amp;amp; &amp;lt; &amp;gt; &amp;quot; &amp;apos;"ת���ɡ�& < > " '��
   * @param strXML String ��Ҫת����XML���ݴ�
   * @return String
   */
  public static String unDealXMLSpecialCharacter(String strXML) {
    String strDealedXML = strXML;
    strDealedXML = replaceStr(strDealedXML, "&amp;", "&");
    strDealedXML = replaceStr(strDealedXML, "&lt;", "<");
    strDealedXML = replaceStr(strDealedXML, "&gt;", ">");
    strDealedXML = replaceStr(strDealedXML, "&quot;", "\"");
    strDealedXML = replaceStr(strDealedXML, "&apos;", "'");
    return strDealedXML;
  }


   public static String dealXMLSpecialCharacter(String strXML)
   {
       String strDealedXML = strXML;
       strDealedXML = replaceStr(strDealedXML,"&","&amp;");
       strDealedXML = replaceStr(strDealedXML,"<","&lt;");
       strDealedXML = replaceStr(strDealedXML,">","&gt;");
       strDealedXML = replaceStr(strDealedXML,"\"","&quot;");
       strDealedXML = replaceStr(strDealedXML,"'","&apos;");
       return strDealedXML;
   }
 
%>
<% // initialize oracle db connction, use dbpool

	String url = new String("jdbc:oracle:thin:@127.0.0.1:1521:ORCL");
	OracleConnectionPoolDataSource ocpds = new OracleConnectionPoolDataSource();
	ocpds.setURL(url);
	ocpds.setUser("qms");
	ocpds.setPassword("qms");	



  	PooledConnection pc = ocpds.getPooledConnection();
  	
  	Connection conn = pc.getConnection();
	String sql = new String();
	try
	{
		
%>


