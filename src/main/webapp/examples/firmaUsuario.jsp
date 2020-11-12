<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<h2>Firmas con intervención del usuario</h2>
				
				<p>La firma se realizará a través del applet de Viafirma, siendo necesaria la intervención del usuario para completar el proceso de firma</p>
				
				<div class="group">
					<div class="col width-49 append-01">
						<div class="box">
							<h3 class="box-title">Firmas simples</h3>
				
							<div class="box-content">
								<ul>
									<li><a href="firmaUsuario/firmarPDF.jsp">Firmar documento PDF en formato PAdES</a></li>
									<li><a href="firmaUsuario/firmarPDFConSello.jsp">Firmar documento PDF en formato PDF Signature con imagen</a></li>
									<li><a href="firmaUsuario/firmarTexto.jsp">Firmar documento de texto en formato XAdES</a></li>
									<li><a href="firmaUsuario/firmarXML.jsp">Firmar documento xml en formato XAdES</a></li>
									<li><a href="firmaUsuario/firmarHash.jsp">Firmar conociendo solo el Hash del documento original</a></li>
									<li><a href="firmaUsuario/firmarCAdESexplicit.jsp">Realizar firma CAdES explicit</a></li>
									<li><a href="firmaUsuario/firmarPDFUpload.jsp" >Firma PAdES BASIC de PDF subido por el usuario</a></li>
								</ul>
							</div>
						</div>
						
						<% /*if(request.getHeader("user-agent").contains("iPad") || request.getHeader("user-agent").contains("iPhone")){ */ %> 
							<div class="box">
								<h3 class="box-title">Firmas digitalizada</h3>
								<div class="box-content">
									<ul>
										<li><a href="firmaUsuario/firmaDigitalizada_Windows.jsp">Firma digitalizada avanzada en Windows con Tableta de firma (WACOM o TOPAZ)</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada01.jsp">Firma digitalizada avanzada</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada02.jsp">Firma digitalizada con información de presión</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada03.jsp">Firma digitalizada sin firma en servidor</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada04.jsp">Firma digitalizada sin selección del lugar de firma por el usuario</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada05.jsp">Firma digitalizada sin terceros de confianza</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada06.jsp">Firma digitalizada sin puntero</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada07.jsp">Firma digitalizada sin localización</a></li>
										<li><a href="firmaUsuario/firmaDigitalizada08.jsp">Firma digitalizada sin sellado de tiempo de firma digital</a></li>
										<li><a href="exampleBiometricSignatureViafirmaDesktop.jsp" >Firma digitalizada avanzada invocando a Viafirma Desktop por protocolo</a></li>
									</ul>
								</div>
							</div>
						<%/*}*/%>
						
					</div>
					<div class="group">
					<div class="col width-49 append-01">
						<div class="box">
							<h3 class="box-title">Firmas por filtro</h3>
				
							<div class="box-content">
								<ul>
									<li><a href="../exampleFilter/exampleFirma.jsp">Firmar documento controlado por filtro con Viafirma</a></li>
								</ul>
							</div>
						</div>
					</div>
					
					<div class="col width-49 prepend">
						<div class="box">
							<h3 class="box-title">Firmas en lote</h3>
				
							<div class="box-content">
								<ul>
									<li><a href="firmaUsuario/firmarLote.jsp">Firmar documentos en lote en formato XAdES</a></li>
								</ul>
							</div>
						</div>
						
						<div class="box">
							<h3 class="box-title">Firmas de varios documentos en bucle</h3>
				
							<div class="box-content">
								<ul>
									<li><a href="firmaUsuario/firmarVarios.jsp">Firmar en bucle varios documentos en firmas independientes y una sola transacción  con formato XAdES</a></li>
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
	</div>
	</body>
</html>