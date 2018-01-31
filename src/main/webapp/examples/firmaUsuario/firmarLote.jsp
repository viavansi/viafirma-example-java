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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="../../"><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmas con intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Firma en lote</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un lote compuesto por varios documentos en Viafirma con la intervención directa del usuario. El resultado de la firma es considerado como una única unidad</p>
							
								<p>
									<a class="button" href="?firmarLote">Iniciar firma de documento en lote</a>
								</p>
								
								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmarLote") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmarTXT = IOUtils.toByteArray(getClass().getResourceAsStream("/ejemplo.txt"));
										byte[] datosAFirmarXML = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										byte[] datosAFirmarPDF = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										
										// Indicamos a la plataforma que deseamos iniciar una firma en lote
										String idTemporalLote=viafirmaClient.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
										
										// Agregamos los documentos al lote
										String idDocu1 = viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 1.txt",TypeFile.TXT, datosAFirmarTXT);
										String idDocu2 = viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 2.xml",TypeFile.XML, datosAFirmarXML);
										String idDocu3 = viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 3.pdf",TypeFile.PDF, datosAFirmarPDF);
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idTemporalLote,request, response,"/viafirmaClientResponseServlet");
									}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-33 append-02">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>iniciarFirmaEnLotes</code></li>
									<li><code>addDocumentoFirmaEnLote</code></li>
									<li><code>solicitarFirma</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p>
					<a href="../firmaUsuario.jsp">&larr; Volver</a>
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