<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="java.util.List" %>
<%@page import="java.util.LinkedList"%>

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
				<h2>Recuperación del listado de firmas de un lote</h2>
				
				<div class="group">
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Recuperar informacion de documentos originales</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un lote de documentos, se recupera el listado de identificadores y se recuperan los documentos originales que fueron firmados.</p>
								
								<p><a class="button" href="?recuperarIds">Recuperar los ids de documentos originales</a></p>
							</div>
						</div>
								<%
								    if (request.getParameter("recuperarIds") != null) {
								
								    	ConfigureUtil.initViafirmaClient();
										String alias = ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
										String pass = ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
										ViafirmaClient viafirmaClient=ViafirmaClientFactory.getInstance();
								
										// Comenzamos un proceso de Firma en Lotes
										String idFinalFirmaLote = "";
										final String idTemporalLote = viafirmaClient.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
										byte[] datosAFirmarTXT = IOUtils.toByteArray(getClass().getResourceAsStream("/ejemplo.txt"));
										byte[] datosAFirmarXML = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										byte[] datosAFirmarPDF = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 1.txt",TypeFile.TXT, datosAFirmarTXT);
										viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 2.xml",TypeFile.XML, datosAFirmarXML);
										viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 3.pdf",TypeFile.PDF, datosAFirmarPDF);
										try {
										    idFinalFirmaLote = viafirmaClient.signByServerEnLotes(idTemporalLote, alias, pass);
										} catch (InternalException e) {
										%><p>No se puede realizar la firma.<%=e.getMessage()%></p>
										<% e.printStackTrace();
										}%>
									<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
										<div class="box-content">
									<%
								
										// Una vez realizada la firma recuperamos el listado de identificadores de documento.
										List<String>listIdentifiersDocuments = null;
										listIdentifiersDocuments = viafirmaClient.getOriginalDocumentsIds(idFinalFirmaLote);
										// Comenzamos la recuperación de los documentos originales
										for (String identifierDocument : listIdentifiersDocuments) {
										    Documento docu = viafirmaClient.getOriginalDocument(identifierDocument);%>
										    <p><strong>ID:</strong><%=docu.getId()%><br/>
											<strong>Nombre:</strong><%=docu.getNombre()%><br/>
											<strong>Tamaño:</strong><%=docu.getSize()%><br/>
											<strong>Tipo de Documento:</strong><%=docu.getTipo()%></p>
											<%
								    	}
										%>
										</div>
									</div>	
									<%}	%>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>iniciarFirmaEnLotes</code></li>
									<li><code>addDocumentoFirmaEnLote</code></li>
									<li><code>signByServerEnLotes</code></li>
									<li><code>getOriginalDocumentsIds</code></li>
									<li><code>getOriginalDocument</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Inicio</a></p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>
