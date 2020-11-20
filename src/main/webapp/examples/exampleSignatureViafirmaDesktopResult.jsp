<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.SignatureResponse"%>
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
				<h2>Resultado del proceso de firma por invocación directa a Viafirma Desktop</h2>
<%
	ConfigureUtil.initViafirmaClient();										
	ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
	String sessionId = request.getSession().getId();
	String operationId = (String) request.getParameter("operationId");
	SignatureResponse signatureResponse = viafirmaClient.getSignatureResponse(operationId, sessionId);
	String id = signatureResponse.getSignatureId();

%>

				<p><strong>Código de firma: </strong><%=id%></p>
			
				<p>
					<strong>Otros datos:</strong>
				</p>
				<%if(request.getAttribute("error")!=null ){%>
					<p>${error}. Operación cancelada</p>
				<%}else{ 
					if(signatureResponse.getCertificateValidationData() != null) {
				%>
					<table>
						<tr><th class="width-20"><strong>First Name</strong> </th><td><%=signatureResponse.getCertificateValidationData().getName() %></td></tr>
						<tr><th class="width-20"><strong>Last Name</strong></th><td><%=signatureResponse.getCertificateValidationData().getSurname1() %> <%=signatureResponse.getCertificateValidationData().getSurname2() %></td></tr>
						<tr><th class="width-20"><strong>Number User Id</strong></th><td><%=signatureResponse.getCertificateValidationData().getNumberUserId() %></td></tr>
						<tr><th class="width-20"><strong>E-mail</strong></th><td><%=signatureResponse.getCertificateValidationData().getEmail() %></td></tr>
						<tr><th class="width-20"><strong>Ca Name</strong></th><td><%=signatureResponse.getCertificateValidationData().getCa() %></td></tr>
						<tr><th class="width-20"><strong>Type Certificate</strong></th><td><%=signatureResponse.getCertificateValidationData().getType() %></td></tr>
					</table>
				<%} %>	
					
					<p class="codBarras">
						<img alt="Imagen QR de justificante del resultado de la firma del fichero" width="500" src="<%=ConfigureUtil.getViafirmaServer() %>/downloadComprobanteQR?codFirma=<%=id%>&amp;tipo=png" title="Imagen QR de justificante del resultado de la firma del fichero" />
					</p>
				
<!-- 					<p class="ValidarFirma"> -->
<%-- 						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>" title="Validar Firma">Validar Firma</a> 				 --%>
<!-- 					</p> -->
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>?j" title="Descargar Comprobante">Descarga de comprobante de firma</a> 				
					</p>
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>?d" title="Descargar Documento firmado">Descarga de documento firmado</a> 				
					</p>	
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="utils/downloads.jsp?original&id=<%=id%>" title="Descargar Documento original">Descarga de documento original</a> 				
					</p>

				<%
				}
				%>
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