<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href=".."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmas sin intervención del usuario</h2>
				<p>Las firmas realizadas sin intervención del usuario son realizadas a través del servidor.</p>
				<p>Para el correcto funcionamiento de los siguientes ejemplos, el certificado debe estar instalado en el servidor.</p>
				
				<div class="group">
					<div class="col width-49 append-01">
						<div class="box">
							<h3 class="box-title">Firmas simples</h3>
							<div class="box-content">
								<ul>
									<li><a href="firmaServer/firmarPDF.jsp">Firmar documento en formato PAdES</a></li>
									<li><a href="firmaServer/firmarPDFConSello.jsp">Firmar documento en formato PDF Signature con imagen</a></li>
									<li><a href="firmaServer/firmarTexto.jsp">Firmar documento de texto en formato XAdES</a></li>
									<li><a href="firmaServer/firmarXML.jsp">Firmar documento xml en formato XAdES</a></li>
<!-- 							 	Esto funciona pero no tenemos un certificado de pruebas con OCSP para usarlo -->
									<li><a href="firmaServer/firmarResign.jsp">Firmar con XAdES A un documento ya firmado</a></li>
									<li><a href="firmaServer/firmarDetachedServer.jsp">Firmar con XAdES A DETACHED</a></li>
									<li><a href="firmaServer/tsaRequest.jsp">Sellado de tiempo de un documento</a></li>
									<li><a href="firmaServer/firmarHashServer.jsp">Firmar conociendo solo el Hash del documento original</a></li>
									<li><a href="firmaServer/firmarCAdESexplicit.jsp">Realizar firma CAdES explicit</a></li>
									<li><a href="firmaServer/firmarCAdES.jsp">Realizar firma CAdES</a></li>
									<li><a href="firmaServer/firmarXAdES.jsp">Realizar firma XAdES eligiendo combinación de firma</a></li>
								</ul>
							</div>
						</div>
					</div>
					
					<div class="col width-49 prepend-01">
						<div class="box">
							<h3 class="box-title">Firmas en lote</h3>
							<div class="box-content">
								<ul>
									<li><a href="firmaServer/firmarLote.jsp">Firmar documentos en lote formato XAdES</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
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