<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.viafirma.examples.util.ConfigureUtil"%><html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Examples</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href=""><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">	
				<h2>Resultado del proceso de firma</h2>

				<p><strong>Sellado de tiempo:</strong>${resultado.signTimeStamp}</p>
				<p><strong>Código de firma:</strong>${resultado.signId}</p>
				<!--  Soporte para Viafirma -->
				
				<p>
					<strong>Otros datos:</strong>
				</p>
				<%if(request.getAttribute("error")!=null ){%>
					<p>${error}. Operación cancelada</p>
				<%}else{ %>
					
					<% 
						FirmaInfoViafirma firmaInfoViafirma=(FirmaInfoViafirma)request.getSession().getAttribute("resultado");
						String[] ids=firmaInfoViafirma.getSignId().split(";");
						for(String id:ids){
					%>
					
					<table>
							<tr><td>First Name</td><td>${resultado.properties.firstName}</td></tr>
							<tr><td>Last Name</td><td>${resultado.properties.lastName}</td></tr>
							<tr><td>Number User Id</td><td>${resultado.properties.numberUserId}</td></tr>
							<tr><td>E-mail</td><td>${resultado.properties.email}</td></tr>
							<tr><td>Ca Name</td><td>${resultado.properties.caName}</td></tr>
							<tr><td>Oids</td><td>${resultado.properties.oids}</td></tr>
							<tr><td>Type Certificate</td><td>${resultado.properties.typeCertificate}</td></tr>
							<tr><td>Type Legal</td><td>${resultado.properties.typeLegal}</td></tr>
					</table>
					<p class="codBarras">
						<img alt="Imagen QR de justificante del resultado de la firma del fichero" width="500" src="<%=ConfigureUtil.getViafirmaServer() %>/downloadComprobanteQR?codFirma=<%=id%>&amp;tipo=png" title="Imagen QR de justificante del resultado de la firma del fichero" />
					</p>
				
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>?j" title="Descargar Comprobante">Descarga de comprobante de firma</a> 				
					</p>
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>?d" title="Descargar Documento firmado">Descarga de documento firmado</a> 				
					</p>	
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="../utils/downloads.jsp?original&id=<%=id%>" title="Descargar Documento original">Descarga de documento original</a> 				
					</p>
						
						<%}%>
					<%
					}
					%>
					<a href="../">&larr; Volver</a>
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