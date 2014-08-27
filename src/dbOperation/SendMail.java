package dbOperation;
import java.net.URLEncoder;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.io.*;
import java.util.Date;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;



public class SendMail {

     /**
     * 获取日期，格式为“2000-10-10”
     */
    public static String getDate(java.util.Date date) {
        if (date == null) {
            date = new Date();
        }
        SimpleDateFormat formatter = null;
        formatter = new SimpleDateFormat("yyyy-MM-dd");

        String dateString = formatter.format(date);
        return dateString;
    }

     /**
     * 将字符串的内容作为文件存入给定的文件中
     *
     * @return完成操作时返回true
     */
    static public boolean saveStrToFile(String filename, String contents) {
         try {
            File file = new File(filename);
            if (file.getParent() != null) {
                new File(file.getParent()).mkdirs();
            }
            Writer wtr = new FileWriter(file);

            //char[] ch = contents.toCharArray();
            for(int iPos=0; iPos < contents.length(); ) {
                int iEnd = iPos + 8000;
                if(iEnd>contents.length()) iEnd = contents.length();

                wtr.write(contents.substring(iPos, iEnd));

                wtr.flush();

                iPos = iEnd;
            }
            wtr.close();
            return true;
        }
        catch (IOException ioe) {
            return false;
        }
    }


	public String getStr(String str) {
		try {
			String temp_p = str;
			String temp = new String(temp_p.getBytes("ISO-8859-1"), "gb2312");
			return temp;
		} catch (Exception e) {

		}
		return "null";
	}

	public String GetStrTrim(String str) {
		try {
			String temp_p = str;
			if (temp_p != null)
				temp_p = temp_p.trim();
			if (temp_p == null || temp_p.compareTo("") == 0) {
				return "&nbsp";
			} else {
				return temp_p.trim();
			}
		} catch (Exception e) {
		}
		return "null";
	}

	public String GetStrTrim1(String str) {
		try {
			String temp_p = str;
			if (temp_p == null || temp_p.compareTo("") == 0) {
				return "";
			} else {
				return temp_p.trim();
			}
		} catch (Exception e) {
		}
		return "null";
	}

	/**
	 * 将str中str1替换为str2
	 *
	 * @param str
	 *            String 原始字符串
	 * @param str1
	 *            String 需要被替换的字符串
	 * @param str2
	 *            String 替换内容
	 * @return String 替换后的字符串
	 */
	private static String replaceStr(String str, String str1, String str2) {
		if (str == null || str1 == null || str2 == null)
			return str;
		if (str1.equals(""))
			return str;

		StringBuffer sbReplaced = new StringBuffer("");
		String strSwap = new String(str);
		while (strSwap.indexOf(str1) >= 0) {
			int i = strSwap.indexOf(str1);
			sbReplaced.append(strSwap.substring(0, i));
			sbReplaced.append(str2);
			strSwap = strSwap.substring(i + str1.length());
		}
		sbReplaced.append(strSwap);

		return sbReplaced.toString();
	}

	// 把XML标记转为特殊符号，把"&amp; &lt; &gt;&quot;&apos;"转换成“& < > " '”
	/**
	 * 把XML标记转为特殊符号，把"&amp;amp; &amp;lt; &amp;gt; &amp;quot; &amp;apos;"转换成“& < > " '”
	 *
	 * @param strXML
	 *            String 需要转换的XML数据串
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

	// XML中有些特殊字符需要转换，否则XML不能正确显示，把“& < > " '”转换成“&amp; &lt; &gt; &quot; &apos;”
	/**
	 * XML中有些特殊字符需要转换，否则XML不能正确显示，把“& < > " '”转换成“&amp;amp; &amp;lt; &amp;gt;
	 * &amp;quot; &amp;apos;”
	 *
	 * @param strXML
	 *            String
	 * @return String
	 */
	public static String dealXMLSpecialCharacter(String strXML) {
		String strDealedXML = strXML;
		strDealedXML = replaceStr(strDealedXML, "&", "&amp;");
		strDealedXML = replaceStr(strDealedXML, "<", "&lt;");
		strDealedXML = replaceStr(strDealedXML, ">", "&gt;");
		strDealedXML = replaceStr(strDealedXML, "\"", "&quot;");
		strDealedXML = replaceStr(strDealedXML, "'", "&apos;");
		return strDealedXML;
	}

	
	public static void main(String[] args) throws Exception 
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:yanwg","AICMS","AICMS");
		try {
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement stmt6 = conn.createStatement();
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			ResultSet rs3 = null;
			ResultSet rs4 = null;
			ResultSet rs5 = null;
			ResultSet rs6 = null;
			String sSql1 = "";
			String sSql2 = "";
			String sSql3 = "";
			String sSql4 = "";
			String sSql5 = "";
			String sSql6 = "";
			
			String Syslog = "debug";

			java.util.Date date = new java.util.Date();// 默认取当前时间
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");// 年月日时分秒格式

			//String sSMTPserver = "10.1.1.117";
			String sSMTPserver = "mail.asiainfo-linkage.com";
			
			String sFromMail = "yanwg@asiainfo-linkage.com";
			String sToMail = "";
			String sCcMail = "";
			String sSubject = "";
			String sMailText = "";

			String Item_Name = "";
			String sLink = "";

			String OPTOR = "yanwg";
			String op_mail = "yanwg@asiainfo-linkage.com";

			String V_err_code = "00";
			String V_err_desc = "";
			String product_id = "";
			String product_name = "";
			String CC_MAIL = "";
			//sSql = "select distinct a.product_id,b.product_name from remind_product a,product b where a.product_id=b.product_id and b.product_id=3 order by product_id ";
			// System.out.println(sSql);
			//获取开发提交时间到期数据
			sSql1="select  b.product as product,b.demand_prov as prov,b.name as name,b.state as state,b.tester_name as tester,b.dev_name as dev,"
				 +" to_char(b.plan_dev_time,'YYYY-MM-DD') as dev_time,to_char(b.plan_test_time,'YYYY-MM-DD') as test_time,to_char(b.plan_release_time,'YYYY-MM-DD') as release_time,a.notice_content as link,"
				 +" decode(b.type,1,(select sta_name from qcs.demand_status where sta_id=b.state),2,(select name from qcs.proj_status where id=b.state),b.state) as state_name,a.demand_value"
				 +" from aicms.demand_reminder_notice a,aicms.especial_demand b "
				 +" where a.demand_seq=b.seq and a.type='PLAN_DEV_TIME' "
				 +" order by b.product,b.type,b.value";
			sSql2="select  b.product as product,b.demand_prov as prov,b.name as name,b.state as state,b.tester_name as tester,b.dev_name as dev,"
				 +"  to_char(b.plan_dev_time,'YYYY-MM-DD') as dev_time,to_char(b.plan_test_time,'YYYY-MM-DD') as test_time,to_char(b.plan_release_time,'YYYY-MM-DD') as release_time,a.notice_content as link,"
				 +" decode(b.type,1,(select sta_name from qcs.demand_status where sta_id=b.state),2,(select name from qcs.proj_status where id=b.state),b.state) as state_name,a.demand_value"
				 +" from aicms.demand_reminder_notice a,aicms.especial_demand b "
				 +" where a.demand_seq=b.seq and a.type='PLAN_TEST_TIME' "
				 +" order by b.product,b.type,b.value";
			sSql3="select  b.product as product,b.demand_prov as prov,b.name as name,b.state as state,b.tester_name as tester,b.dev_name as dev,"
				 +"  to_char(b.plan_dev_time,'YYYY-MM-DD') as dev_time,to_char(b.plan_test_time,'YYYY-MM-DD') as test_time,to_char(b.plan_release_time,'YYYY-MM-DD') as release_time,a.notice_content as link,"
				 +" decode(b.type,1,(select sta_name from qcs.demand_status where sta_id=b.state),2,(select name from qcs.proj_status where id=b.state),b.state) as state_name,a.demand_value"
				 +" from aicms.demand_reminder_notice a,aicms.especial_demand b "
				 +" where a.demand_seq=b.seq and a.type='PLAN_RELEASE_TIME' "
				 +" order by b.product,b.type,b.value";
			sSql4="select notice_receiver from aicms.demand_reminder_notice";
			sSql5="insert into aicms.demand_reminder_notice_his value"
				 +"(select demand_seq,demand_type,demand_value,notice_id,notice_topic,notice_content,notice_receiver,notice_create_time,sysdate,type from aicms.demand_reminder_notice)";
			sSql6="delete aicms.demand_reminder_notice";
			try 
			{
				rs1 = stmt1.executeQuery(sSql1);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

			try 
			{
				rs2 = stmt2.executeQuery(sSql2);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

			try 
			{
				rs3 = stmt3.executeQuery(sSql3);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			try 
			{
				rs4 = stmt4.executeQuery(sSql4);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

//////获取收件人//////////////////////////////////////////////////////////////////////////////////////////////////////
		String receiver="";
		while (rs4.next())
		{
			String[] receiverArray=rs4.getString("notice_receiver").split(";");
			for(int i = 0; i < receiverArray.length; i++)
			{
				if (receiverArray[i].trim().length() < 1 || receiverArray[i].equals("null")) 
				{
					continue;
				}
				receiver = receiver + "," + receiverArray[i];
			}

		}
			
/////发邮件////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if(!receiver.equals(""))
		{	
			sSubject = "重点需求/故障 提醒!(" + getDate(new java.util.Date())+ ")";
			sMailText = "<table width=100% border=0 > ";
			sMailText = sMailText + " <tr>	";
			sMailText = sMailText
						+ "   <td colspan='11'><div align='center' class='style1 style2'><font size=5><strong>重点需求/故障提醒"
                        + "(" + getDate(new java.util.Date())+")"
						+ "</strong></font> </div></td>";
			sMailText = sMailText + "</tr>";
			sMailText = sMailText + "</table>";
			sMailText = sMailText + "<table class=textfont cellSpacing=0 cellPadding=1 width='100%' align=center   border=1 ><TBODY>    ";
			sMailText = sMailText + "<tr bgColor=#666699> ";
			sMailText = sMailText + "<td colspan='9' ><div align='left'><font color=#E4E4E4><strong>"
								  + "开发到期需求、故障"
								  + "</strong></font></div></td>";
			sMailText = sMailText + "</tr>";
			sMailText = sMailText + "<tr>";
			sMailText = sMailText + "   <td width='15%' bgColor=#c0c0c0><div align='center'><font size=2><strong>产品</font></div></td>";
			sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>地区</font></div></td>";
			sMailText = sMailText + "   <td width='23%' bgColor=#c0c0c0><div align='center'><font size=2><strong>名称</font></div></td>";
			sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>状态</font></div></td>   ";
			sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>测试</font></div></td> ";
			sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>开发</font></div></td>";
			sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'> <font size=2><strong>计划提交</font></div></td>";
			sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>计划测试</font></div></td>";
			sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><align='center'><font size=2><strong>计划发布</font></div></td> ";

			sMailText = sMailText + " </tr>";
			while (rs1.next())
			{	
				sMailText = sMailText + "<tr>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("product")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("prov")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><font color='#0000FF'><div align='center'>"
				  					  +"<a href='" + rs1.getString("link") + "'>"
									  + rs1.getString("name")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("state_name")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("tester")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("dev")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("dev_time")
									  + "</a></div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
									  + rs1.getString("test_time")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
									  + rs1.getString("release_time")
									  + "</div></font></td>";
				sMailText = sMailText + "</tr> ";
			}

				sMailText = sMailText + "</table> ";
				
				sMailText = sMailText + "<table class=textfont cellSpacing=0 cellPadding=1 width='100%' align=center border=1> ";		
				sMailText = sMailText + "<tr bgColor=#666699> ";
				sMailText = sMailText + "<td colspan='9' ><div align='left'><font color=#E4E4E4><strong>"
									  + "测试到期需求、故障"
									  + "</strong></font></div></td>";
				sMailText = sMailText + "</tr>";
				sMailText = sMailText + "<tr>";
				sMailText = sMailText + "   <td width='15%' bgColor=#c0c0c0><div align='center'><font size=2><strong>产品</font></div></td>";
				sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>省份</font></div></td>";
				sMailText = sMailText + "   <td width='23%' bgColor=#c0c0c0><div align='center'><font size=2><strong>名称</font></div></td>";
				sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>状态</font></div></td>   ";
				sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>测试</font></div></td> ";
				sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>开发</font></div></td>";
				sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'> <font size=2><strong>计划提交</font></div></td>";
				sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>计划测试</font></div></td>";
				sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><align='center'><font size=2><strong>计划发布</font></div></td> ";
				sMailText = sMailText + " </tr>";

				while (rs2.next()) 
				{					
					sMailText = sMailText + "<tr>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("product")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("prov")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><font color='#0000FF'><div align='center'>"
					  					  +"<a href='" + rs2.getString("link") + "'>"
										  + rs2.getString("name")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("state_name")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("tester")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("dev")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("dev_time")
										  + "</a></div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
										  + rs2.getString("test_time")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
										  + rs2.getString("release_time")
										  + "</div></font></td>";
					sMailText = sMailText + "</tr> ";
				}

					sMailText = sMailText + "</table> ";
					
					sMailText = sMailText + "<table class=textfont cellSpacing=0 cellPadding=1 width='100%' align=center border=1> ";
					sMailText = sMailText + "<tr bgColor=#666699> ";
					sMailText = sMailText + "<td colspan='9' ><div align='left'><font color=#E4E4E4><strong>"
										  + "发布到期需求、故障"
										  + "</strong></font></div></td>";
					sMailText = sMailText + "</tr>";
					sMailText = sMailText + "<tr>";
					sMailText = sMailText + "   <td width='15%' bgColor=#c0c0c0><div align='center'><font size=2><strong>产品</font></div></td>";
					sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>省份</font></div></td>";
					sMailText = sMailText + "   <td width='23%' bgColor=#c0c0c0><div align='center'><font size=2><strong>名称</font></div></td>";
					sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>状态</font></div></td>   ";
					sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>测试</font></div></td> ";
					sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>开发</font></div></td>";
					sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'> <font size=2><strong>计划提交</font></div></td>";
					sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>计划测试</font></div></td>";
					sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><align='center'><font size=2><strong>计划发布</font></div></td> ";

					sMailText = sMailText + " </tr>";
					
					while (rs3.next()) 
					{						
						sMailText = sMailText + "<tr>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("product")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("prov")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><font color='#0000FF'><div align='center'>"
						  					  +"<a href='" + rs3.getString("link") + "'>"
											  + rs3.getString("name")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("state_name")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("tester")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("dev")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("dev_time")
											  + "</a></div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
											  + rs3.getString("test_time")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
											  + rs3.getString("release_time")
											  + "</div></td>";
						sMailText = sMailText + "</tr> ";
					}

						sMailText = sMailText + "</table> ";
					

			sMailText = sMailText + " </TBODY></table>";
			
			String str = sMailText;
			//String str = new String(sMailText.getBytes("GB2312"), "8859_1");
			//str = URLEncoder.encode(str,"utf8");   
            System.out.println(str);

			sToMail = receiver;
			sCcMail = "yanwg@asiainfo-linkage.com";
			
			System.out.println(sFromMail);

			if (Syslog.equals("debug")) 
			{
				System.out.println("-------------debug begin--------------");
				System.out.println(format.format(date));// 格式
				System.out.println("sSMTPserver:" + sSMTPserver);
				System.out.println("sFromMail:" + sFromMail);
				System.out.println("sToMail:" + sToMail);
				System.out.println("sCcMail:" + sCcMail);
				System.out.println("sSubject:" + sSubject);
				System.out.println("-------------debug end----------------");
			}
           boolean lei;
           String filename="d:/"+product_name+".html";
           lei=saveStrToFile(filename,sMailText);


           //mymail.mail.HTML.send(sSMTPserver,sFromMail, sToMail, sCcMail, "",sSubject, str); 
           
           boolean sessionDebug = false;   
           try {   
        	      
               // 设定所要用的Mail 服务器和所使用的传输协议    
               java.util.Properties props = System.getProperties();   
               props.put("mail.host", sSMTPserver);   
               props.put("mail.transport.protocol", "smtp");   
               props.put("mail.smtp.auth", "true");//指定是否需要SMTP验证    

               // 产生新的Session 服务    
               javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props, null);   
               mailSession.setDebug(sessionDebug);   
               Message msg = new MimeMessage(mailSession);   

               // 设定发邮件的人    
               msg.setFrom(new InternetAddress(sFromMail));   

               // 设定收信人的信箱
               InternetAddress[] address = null;   
               address = InternetAddress.parse(sToMail, false);   
               msg.setRecipients(Message.RecipientType.TO, address);   

               // 设定信中的主题    
               msg.setSubject(sSubject);
               msg.setText(str);

               // 设定送信的时间    
               msg.setSentDate(new Date());   

               Multipart mp = new MimeMultipart();   
               MimeBodyPart mbp = new MimeBodyPart();   

               
               //str = MimeUtility.encodeText(new String(str.getBytes(), "GB2312"), "GB2312", "B");
               String type = "text/html";//发送邮件格式为html   
               // 设定邮件内容的类型为 text/plain 或 text/html    

               mbp.setContent(str, type + ";charset=gb2312");   
               mp.addBodyPart(mbp); 	  
               msg.setContent(mp);   

               Transport transport = mailSession.getTransport("smtp");   
               ////请填入你的邮箱用户名和密码,千万别用我的^_^    
               transport.connect(sSMTPserver, "yanwg", "729%yxy19");//设发出邮箱的用户名、密码   
               transport.sendMessage(msg, msg.getAllRecipients());   
               transport.close();   
               //Transport.send(msg);    
               System.out.println("邮件已顺利发送");   

         } catch (MessagingException mex) {   
               mex.printStackTrace();   
               System.out.println(mex);   
         }   
           
           
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//发送完邮件后，处理通知表中数据
			try 
			{
				rs5 = stmt5.executeQuery(sSql5);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			
/*			try 
			{
				rs6 = stmt6.executeQuery(sSql6);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}*/

		} 
		else
		{
			System.out.print("无接收人，不发送邮件！");
		}
		}
		finally 
		{
			conn.close();
		}	
	}

	
	/* 重点需求发邮件通知函数
	public static void main(String[] args) throws Exception 
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@10.3.18.133:1521:autotest","AICMS","AICMS");
		try {
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement stmt6 = conn.createStatement();
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			ResultSet rs3 = null;
			ResultSet rs4 = null;
			ResultSet rs5 = null;
			ResultSet rs6 = null;
			String sSql1 = "";
			String sSql2 = "";
			String sSql3 = "";
			String sSql4 = "";
			String sSql5 = "";
			String sSql6 = "";
			
			String Syslog = "debug";

			java.util.Date date = new java.util.Date();// 默认取当前时间
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");// 年月日时分秒格式

			String sSMTPserver = "10.1.1.117";
			String sFromMail = "liyf@asiainfo.com";
			String sToMail = "";
			String sCcMail = "";
			String sSubject = "";
			String sMailText = "";

			String Item_Name = "";
			String sLink = "";

			String OPTOR = "liyf";
			String op_mail = "liyf@asiainfo.com";

			String V_err_code = "00";
			String V_err_desc = "";
			String product_id = "";
			String product_name = "";
			String CC_MAIL = "";
			//sSql = "select distinct a.product_id,b.product_name from remind_product a,product b where a.product_id=b.product_id and b.product_id=3 order by product_id ";
			// System.out.println(sSql);
			//获取开发提交时间到期数据
			sSql1="select  b.product as product,b.demand_prov as prov,b.name as name,b.state as state,b.tester_name as tester,b.dev_name as dev,"
				 +" to_char(b.plan_dev_time,'YYYY-MM-DD') as dev_time,to_char(b.plan_test_time,'YYYY-MM-DD') as test_time,to_char(b.plan_release_time,'YYYY-MM-DD') as release_time,a.notice_content as link,"
				 +" decode(b.type,1,(select sta_name from qcs.demand_status where sta_id=b.state),2,(select name from qcs.proj_status where id=b.state),b.state) as state_name,a.demand_value"
				 +" from aicms.demand_reminder_notice a,aicms.especial_demand b "
				 +" where a.demand_seq=b.seq and a.type='PLAN_DEV_TIME' "
				 +" order by b.product,b.type,b.value";
			sSql2="select  b.product as product,b.demand_prov as prov,b.name as name,b.state as state,b.tester_name as tester,b.dev_name as dev,"
				 +"  to_char(b.plan_dev_time,'YYYY-MM-DD') as dev_time,to_char(b.plan_test_time,'YYYY-MM-DD') as test_time,to_char(b.plan_release_time,'YYYY-MM-DD') as release_time,a.notice_content as link,"
				 +" decode(b.type,1,(select sta_name from qcs.demand_status where sta_id=b.state),2,(select name from qcs.proj_status where id=b.state),b.state) as state_name,a.demand_value"
				 +" from aicms.demand_reminder_notice a,aicms.especial_demand b "
				 +" where a.demand_seq=b.seq and a.type='PLAN_TEST_TIME' "
				 +" order by b.product,b.type,b.value";
			sSql3="select  b.product as product,b.demand_prov as prov,b.name as name,b.state as state,b.tester_name as tester,b.dev_name as dev,"
				 +"  to_char(b.plan_dev_time,'YYYY-MM-DD') as dev_time,to_char(b.plan_test_time,'YYYY-MM-DD') as test_time,to_char(b.plan_release_time,'YYYY-MM-DD') as release_time,a.notice_content as link,"
				 +" decode(b.type,1,(select sta_name from qcs.demand_status where sta_id=b.state),2,(select name from qcs.proj_status where id=b.state),b.state) as state_name,a.demand_value"
				 +" from aicms.demand_reminder_notice a,aicms.especial_demand b "
				 +" where a.demand_seq=b.seq and a.type='PLAN_RELEASE_TIME' "
				 +" order by b.product,b.type,b.value";
			sSql4="select notice_receiver from aicms.demand_reminder_notice";
			sSql5="insert into aicms.demand_reminder_notice_his value"
				 +"(select demand_seq,demand_type,demand_value,notice_id,notice_topic,notice_content,notice_receiver,notice_create_time,sysdate,type from aicms.demand_reminder_notice)";
			sSql6="delete aicms.demand_reminder_notice";
			try 
			{
				rs1 = stmt1.executeQuery(sSql1);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

			try 
			{
				rs2 = stmt2.executeQuery(sSql2);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

			try 
			{
				rs3 = stmt3.executeQuery(sSql3);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			try 
			{
				rs4 = stmt4.executeQuery(sSql4);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

//////获取收件人//////////////////////////////////////////////////////////////////////////////////////////////////////
		String receiver="";
		while (rs4.next())
		{
			String[] receiverArray=rs4.getString("notice_receiver").split(";");
			for(int i = 0; i < receiverArray.length; i++)
			{
				if (receiverArray[i].trim().length() < 1 || receiverArray[i].equals("null")) 
				{
					continue;
				}
				receiver = receiver + "," + receiverArray[i];
			}

		}
			
/////发邮件////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if(!receiver.equals(""))
		{	
			sSubject = "重点需求/故障 提醒!(" + getDate(new java.util.Date())+ ")";
			sMailText = "<table width=100% border=0 > ";
			sMailText = sMailText + " <tr>	";
			sMailText = sMailText
						+ "   <td colspan='11'><div align='center' class='style1 style2'><font size=5><strong>重点需求/故障提醒"
                        + "(" + getDate(new java.util.Date())+")"
						+ "</strong></font> </div></td>";
			sMailText = sMailText + "</tr>";
			sMailText = sMailText + "</table>";
			sMailText = sMailText + "<table class=textfont cellSpacing=0 cellPadding=1 width='100%' align=center   border=1 ><TBODY>    ";
			sMailText = sMailText + "<tr bgColor=#666699> ";
			sMailText = sMailText + "<td colspan='9' ><div align='left'><font color=#E4E4E4><strong>"
								  + "开发到期需求、故障"
								  + "</strong></font></div></td>";
			sMailText = sMailText + "</tr>";
			sMailText = sMailText + "<tr>";
			sMailText = sMailText + "   <td width='15%' bgColor=#c0c0c0><div align='center'><font size=2><strong>产品</font></div></td>";
			sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>省份</font></div></td>";
			sMailText = sMailText + "   <td width='23%' bgColor=#c0c0c0><div align='center'><font size=2><strong>名称</font></div></td>";
			sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>状态</font></div></td>   ";
			sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>测试</font></div></td> ";
			sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>开发</font></div></td>";
			sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'> <font size=2><strong>计划提交</font></div></td>";
			sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>计划测试</font></div></td>";
			sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><align='center'><font size=2><strong>计划发布</font></div></td> ";

			sMailText = sMailText + " </tr>";
			while (rs1.next())
			{	
				sMailText = sMailText + "<tr>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("product")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("prov")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><font color='#0000FF'><div align='center'>"
				  					  +"<a href='" + rs1.getString("link") + "'>"
									  + rs1.getString("name")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("state_name")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("tester")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("dev")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
									  + rs1.getString("dev_time")
									  + "</a></div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
									  + rs1.getString("test_time")
									  + "</div></font></td>";
				sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
									  + rs1.getString("release_time")
									  + "</div></font></td>";
				sMailText = sMailText + "</tr> ";
			}

				sMailText = sMailText + "</table> ";
				
				sMailText = sMailText + "<table class=textfont cellSpacing=0 cellPadding=1 width='100%' align=center border=1> ";		
				sMailText = sMailText + "<tr bgColor=#666699> ";
				sMailText = sMailText + "<td colspan='9' ><div align='left'><font color=#E4E4E4><strong>"
									  + "测试到期需求、故障"
									  + "</strong></font></div></td>";
				sMailText = sMailText + "</tr>";
				sMailText = sMailText + "<tr>";
				sMailText = sMailText + "   <td width='15%' bgColor=#c0c0c0><div align='center'><font size=2><strong>产品</font></div></td>";
				sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>省份</font></div></td>";
				sMailText = sMailText + "   <td width='23%' bgColor=#c0c0c0><div align='center'><font size=2><strong>名称</font></div></td>";
				sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>状态</font></div></td>   ";
				sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>测试</font></div></td> ";
				sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>开发</font></div></td>";
				sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'> <font size=2><strong>计划提交</font></div></td>";
				sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>计划测试</font></div></td>";
				sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><align='center'><font size=2><strong>计划发布</font></div></td> ";
				sMailText = sMailText + " </tr>";

				while (rs2.next()) 
				{					
					sMailText = sMailText + "<tr>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("product")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("prov")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><font color='#0000FF'><div align='center'>"
					  					  +"<a href='" + rs2.getString("link") + "'>"
										  + rs2.getString("name")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("state_name")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("tester")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("dev")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
										  + rs2.getString("dev_time")
										  + "</a></div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
										  + rs2.getString("test_time")
										  + "</div></font></td>";
					sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
										  + rs2.getString("release_time")
										  + "</div></font></td>";
					sMailText = sMailText + "</tr> ";
				}

					sMailText = sMailText + "</table> ";
					
					sMailText = sMailText + "<table class=textfont cellSpacing=0 cellPadding=1 width='100%' align=center border=1> ";
					sMailText = sMailText + "<tr bgColor=#666699> ";
					sMailText = sMailText + "<td colspan='9' ><div align='left'><font color=#E4E4E4><strong>"
										  + "发布到期需求、故障"
										  + "</strong></font></div></td>";
					sMailText = sMailText + "</tr>";
					sMailText = sMailText + "<tr>";
					sMailText = sMailText + "   <td width='15%' bgColor=#c0c0c0><div align='center'><font size=2><strong>产品</font></div></td>";
					sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>省份</font></div></td>";
					sMailText = sMailText + "   <td width='23%' bgColor=#c0c0c0><div align='center'><font size=2><strong>名称</font></div></td>";
					sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>状态</font></div></td>   ";
					sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>测试</font></div></td> ";
					sMailText = sMailText + "   <td width='10%' bgColor=#c0c0c0><div align='center'><font size=2><strong>开发</font></div></td>";
					sMailText = sMailText + "   <td width='8%' bgColor=#c0c0c0><div align='center'> <font size=2><strong>计划提交</font></div></td>";
					sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><div align='center'><font size=2><strong>计划测试</font></div></td>";
					sMailText = sMailText + "	<td width='8%' bgColor=#c0c0c0><align='center'><font size=2><strong>计划发布</font></div></td> ";

					sMailText = sMailText + " </tr>";
					
					while (rs3.next()) 
					{						
						sMailText = sMailText + "<tr>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("product")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("prov")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><font color='#0000FF'><div align='center'>"
						  					  +"<a href='" + rs3.getString("link") + "'>"
											  + rs3.getString("name")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("state_name")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("tester")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("dev")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='center'>"
											  + rs3.getString("dev_time")
											  + "</a></div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
											  + rs3.getString("test_time")
											  + "</div></font></td>";
						sMailText = sMailText + "<td bgColor=#ffffff style= 'font-size: 12px;'><div align='left'>"
											  + rs3.getString("release_time")
											  + "</div></td>";
						sMailText = sMailText + "</tr> ";
					}

						sMailText = sMailText + "</table> ";
					

			sMailText = sMailText + " </TBODY></table>";
			
			
			String str = new String(sMailText.getBytes("GB2312"), "8859_1");
			sToMail = receiver;
			sCcMail = "liyf@asiainfo.com";
			
			System.out.println(sFromMail);

			if (Syslog.equals("debug")) 
			{
				System.out.println("-------------debug begin--------------");
				System.out.println(format.format(date));// 格式
				System.out.println("sSMTPserver:" + sSMTPserver);
				System.out.println("sFromMail:" + sFromMail);
				System.out.println("sToMail:" + sToMail);
				System.out.println("sCcMail:" + sCcMail);
				System.out.println("sSubject:" + sSubject);
				System.out.println("-------------debug end----------------");
			}
           boolean lei;
           String filename="d:/"+product_name+".html";
           lei=saveStrToFile(filename,sMailText);

           mymail.mail.HTML.send(sSMTPserver,sFromMail, sToMail, sCcMail, "",sSubject, str);
           
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//发送完邮件后，处理通知表中数据
			try 
			{
				rs5 = stmt5.executeQuery(sSql5);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			
			try 
			{
				rs6 = stmt6.executeQuery(sSql6);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}

		} 
		else
		{
			System.out.print("无接收人，不发送邮件！");
		}
		}
		finally 
		{
			conn.close();
		}	
	}

*/
}