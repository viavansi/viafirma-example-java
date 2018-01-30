<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Cambiar la conexión a otro servidor de viafirma</h2>

				<%
				if(request.getParameter("updateConfiguration")!=null){
					ConfigureUtil.updateConfiguration((String)request.getParameter("url_server"),(String)request.getParameter("url_server_ws"));
					response.sendRedirect("index.jsp");
				}
				if(request.getParameter("updateAlias")!=null){
					ConfigureUtil.updateAlias((String)request.getParameter("alias"),(String)request.getParameter("password"));
				}
				if(request.getParameter("updateApiKey")!=null){
					ConfigureUtil.updateApiKey((String)request.getParameter("apiKey"),(String)request.getParameter("apiPass"));
				}
				if(request.getParameter("updateProxy")!=null){
					ConfigureUtil.updateProxy((String)request.getParameter("proxyHost"), (String)request.getParameter("proxyPort"), (String)request.getParameter("proxyUser"), (String)request.getParameter("proxyPass"));
				}
				%>
				
				<form action="?updateConfiguration"  >
					<p>URL_VIAFIRMA:    <input style="width: 100%"type="text" value="<%=ConfigureUtil.getViafirmaServer()%>" name="url_server"></p>
					<p>URL_VIAFIRMA_WS: <input style="width: 100%" type="text" value="<%=ConfigureUtil.getViafirmaServerWS()%>" name="url_server_ws"></p>
					<p><input type="hidden" value="updateConfiguration" name="updateConfiguration"></p>
					<br/>
					<p>ALIAS: <input style="width: 100%"type="text" value="<%=ConfigureUtil.CERTALIAS%>" name="alias"></p>
					<p>PASS:  <input style="width: 100%" type="text" value="<%=ConfigureUtil.CERTPASS%>" name="password"></p>
					<p><input type="hidden" value="updateAlias" name="updateAlias"></p>

					<br/>
					<p>API_KEY: <input style="width: 100%"type="text" value="<%=ConfigureUtil.API_KEY%>" name="apiKey"></p>
					<p>API_PASS:  <input style="width: 100%" type="text" value="<%=ConfigureUtil.API_PASS%>" name="apiPass"></p>
					<p><input type="hidden" value="updateApiKey" name="updateApiKey"></p>

					<br/>
					<p>PROXY HOST: <input style="width: 100%"type="text" value="<%=ConfigureUtil.PROXY_HOST%>" name="proxyHost"></p>
					<p>PROXY PORT:  <input style="width: 100%" type="text" value="<%=ConfigureUtil.PROXY_PORT%>" name="proxyPort"></p>
					<p>PROXY USER: <input style="width: 100%"type="text" value="<%=ConfigureUtil.PROXY_USER%>" name="proxyUser"></p>
					<p>PROXY PASS:  <input style="width: 100%" type="text" value="<%=ConfigureUtil.PROXY_PASS%>" name="proxyPass"></p>
					<p><input type="hidden" value="updateProxy" name="updateProxy"></p>


					<input type="submit" class="enlaceFakeButton" value="Actualizar">
					
				</form>
				
				<div style="text-align:center;">
					<p><a href="index.jsp">Inicio</a></p>
				</div>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>