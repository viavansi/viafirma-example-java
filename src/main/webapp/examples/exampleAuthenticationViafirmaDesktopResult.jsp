<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Set"%>
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.CertificateValidationResponse"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%><html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Examples</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href=".."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">	
				<h2>Resultado del proceso de autenticación por invocación directa a Viafirma Desktop</h2>
				
				<%if(request.getAttribute("error")!=null ){%>
				<p class="message error">${error}. Operación cancelada</p>
				<%}else{
					//We should get the operation data from server with operationId
					//Server will double-check de current user's sessionId with the stored one during preparation to avoid hack attacks
					//In real life operationId could be ciphered
					ConfigureUtil.initViafirmaClient();										
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					String sessionId = request.getSession().getId();
					String operationId = (String) request.getParameter("operationId");
					CertificateValidationResponse certificateValidationResponse = viafirmaClient.getCertificateValidationResponse(operationId, sessionId);					
					String oidAsHtml = StringUtils.replace(certificateValidationResponse.getOidsAsString(), System.lineSeparator(), "<br/>");
					
				%>
				<table>
					<tbody>
						<tr><th class="width-20"><strong>First Name</strong> </th><td><%=certificateValidationResponse.getName() %></td></tr>
						<tr><th class="width-20"><strong>Last Name</strong></th><td><%=certificateValidationResponse.getSurname1() %> <%=certificateValidationResponse.getSurname2() %></td></tr>
						<tr><th class="width-20"><strong>Number User Id</strong></th><td><%=certificateValidationResponse.getNumberUserId() %></td></tr>
						<tr><th class="width-20"><strong>E-mail</strong></th><td><%=certificateValidationResponse.getEmail() %></td></tr>
						<tr><th class="width-20"><strong>Ca Name</strong></th><td><%=certificateValidationResponse.getCa() %></td></tr>
						<tr><th class="width-20"><strong>Oids</strong></th><td><%=oidAsHtml %></td></tr>
						<tr><th class="width-20"><strong>Type Certificate</strong></th><td><%=certificateValidationResponse.getType() %></td></tr>
						<tr><th class="width-20"><strong>Validated OK?</strong></th><td><%=certificateValidationResponse.getIsValidated() %></td></tr>
						<tr><th class="width-20"><strong>Expired?</strong></th><td><%=certificateValidationResponse.getIsExpired() %></td></tr>
						<tr><th class="width-20"><strong>Revoked?</strong></th><td><%=certificateValidationResponse.getIsRevoked() %></td></tr>
					</tbody>
				</table>
				<%}%>
				<p>
					<a href="../index.jsp">&larr; Inicio</a>
				</p> 
			</div>
			
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="https://doc.viafirma.com/viafirma-platform/integration/">Manual de integración de viafirma platform</a> 
				</p>
				<p>
					<small>3.0.0</small>
				</p>
			</div>
		</div>	
	</body>
</html>