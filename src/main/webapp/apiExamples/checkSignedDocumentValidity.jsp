<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Método <code>checkSignedDocumentValidity</code></h2>
				
				<p>El método <code>checkSignedDocumentValidity</code> comprueba la validez de un documento que este firmado.</p>
				<p>Recibe un byte array con el documento y devuelve <code>true</code> en caso de que sa valido y <code>false</code> en caso contrario.</p>
				
				<p>Recibe como paramentro:</p>
				<ul class="parameters">
					<li><code>byte[] originalData</code> Byte array del documento</li>
				</ul>
			    
			    <p>Devuelve:</p>
			    <ul class="parameters">
					<li><code>boolean</code> Boolean indicando su validez</li>
				</ul>
				<!-- <br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>-->
				<%
				if(request.getParameter("QRB")!=null){
					
					ConfigureUtil.initViafirmaClient();
					
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					String alias= ConfigureUtil.CERTALIAS;
					String pass= ConfigureUtil.CERTPASS;
					byte[] datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
					String codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign("temp2.xml",datosAComprobar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
					byte[] datosFirmados = viafirmaClient.getDocumentoCustodiado(codFirma);
					/* Enviamos a Viafirma el documento firmado, y el identificador de firma generado al firmar este documento para que viafirma */
					/* Nos indique si el documento es o no válido */
					boolean valido=ViafirmaClientFactory.getInstance().checkSignedDocumentValidity(datosFirmados);
				
				%>
					<p><strong>¿Es válido?:</strong><%=valido %></p>-->
				<%} %>
				
				<p>
					<a href="./">&larr; Volver</a>
				</p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>