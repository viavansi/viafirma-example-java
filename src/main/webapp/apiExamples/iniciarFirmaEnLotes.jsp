<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>


<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>

<%@page import="org.viafirma.cliente.ViafirmaClient"%>
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
				<h2>Método <code>iniciarFirmaEnLotes</code></h2>
				
				<p>Inicia la firma del lote de archivos. El método <code>iniciarFirmaEnLotes</code> inicia un lote y genera un identificador temporal para referenciarlo</p>
				
				<p>Recibe como paramentro:</p>
				
				<ul class="parameters">
					<li><code>TypeFormatSign formatSign</code> Formato de firma del lote</li>
				</ul>
			 
			 	<p>Devuelve:</p>
			 	<ul class="parameters">
			 		<li><code>String</code> Codigo temporal que identifica al lote</li>
				</ul>
				<!-- 
				<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
				
				<p><a href="?generarLote">Generar lote</a>
					<%
					if(request.getParameter("generarLote")!=null){
					String tempBatchCode=null;
					/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
				
					ConfigureUtil.initViafirmaClient();
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					//Iniciamos el lote indicandole el tipo de archivos que va a contener
					tempBatchCode = viafirmaClient.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
						
					%>
					<div style="text-align:center;">
						<p>El codigo que identifica al lote: <%=tempBatchCode%></p>
						<p><a href="../apiExamples/addDocumentoFirmaEnLote.jsp">Añade un documento al lote</a></p>
					</div>
					<%} %>-->
						
				<p>
					<a href="./">&larr; Volver</a>
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