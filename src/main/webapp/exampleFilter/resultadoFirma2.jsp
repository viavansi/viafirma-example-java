<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.viafirma.examples.util.ConfigureUtil"%><html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Examples</title>
		<style type="text/css" media="screen">
			@import url('../css/screen.css');
		</style>
	</head>
	<body>
		<div id="global">
			<div id="cabecera">
				<p>Aplicación de ejemplo para integradores de Viafirma </p>
				<p>Resultado del proceso de firma.</p>
			</div>
			<div id="cuerpo">	
				<p><strong>Sellado de tiempo:</strong>${resultado.signTimeStamp}</p>
				<p><strong>Código de firma:</strong>${resultado.signId}</p>
					
				<!--  Soporte para Viafirma -->
				
				<p>
					<strong>Otros datos:</strong>
				</p>
				<%if(request.getAttribute("error")!=null ){%>
					<p>${error}. Operación cancelada</p>
					<%}else{ %>
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
					<%}%>
				<p class="codBarras">
						<img alt="Imagen QR de justificante del resultado de la firma del fichero" width="500" src="<%=ConfigureUtil.getViafirmaServer() %>/downloadComprobanteQR?codFirma=${resultado.signId}&amp;tipo=png" title="Imagen QR de justificante del resultado de la firma del fichero" />
				</p>
				<p class="descargaComprobante">
					<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer() %>/v/${resultado.signId}?j" title="Descargar Comprobante">Descarga de comprobante de firma</a> 				
				</p>
				<p class="descargaComprobante">
					<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer() %>/v/${resultado.signId}?d" title="Descargar Documento original">Descarga de documento original</a> 				
				</p>	
			</div>
		</div>
		<p><a href="../index.jsp" >volver </a></p>
	</body>
</html>