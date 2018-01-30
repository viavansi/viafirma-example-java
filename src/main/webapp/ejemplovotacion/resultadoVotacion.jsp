<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.filter.FirmaViafirmaFilter"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
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
				<h1>Viafirma - TooMeeting</h1>
		
			<div id="content">
				<form action="index.jsp">
		
					<h2>Resultado votación</h2>
					<%
						if(request.getParameter("respuesta").equals("true")){
					%>
						<strong><span id="resultadoVotacion">Votación positiva.</span></strong><br/><strong>Código de firma:</strong>${resultado.signId}
						<!--  <p><strong>Sellado de tiempo:</strong>${resultado.signTimeStamp}</p>-->
						<br/>
						<a class="descarga" href="<%=ConfigureUtil.getViafirmaServer() %>/v/${resultado.signId}?j" target="_blank" title="Descargar Comprobante">Descarga de comprobante de firma</a>&nbsp;&nbsp;&nbsp;	
						<a class="descarga" href="<%=ConfigureUtil.getViafirmaServer() %>/v/${resultado.signId}?d" target="_blank" title="Descargar Documento original">Descarga de documento original</a> 				
		
						<p class="codBarras">
							<img alt="Código de firma" width="400" height="100" src="<%=ConfigureUtil.getViafirmaServer() %>/downloadComprobanteQR?codFirma=${resultado.signId}&amp;tipo=png" title="Imagen QR de justificante del resultado de la firma del fichero" />
						</p>
	
					<%}else if(request.getParameter("respuesta").equals("false")){%>
						<p><strong><span id="resultadoVotacion">Votación negativa.</span></strong></p>
					<%}else{%>
						<p><strong><span id="resultadoVotacion">Se abstiene de firmar.</span></strong></p>
					<%}%>
								
					<p class="buttons">
						<input class="button" type="submit" value="Volver" />
					</p>
				</form>
			</div>
		</div>
	</body>
</html>