<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
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
				<h2>Firmas sin intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-68 append-02">
						<div class="box">
							<h3 class="box-title">Firma en lote</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un lote de documentos de texto con formato XAdES en el servidor sin la intervención directa del usuario.</p>
								<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
								
								<p>
									<a class="button" href="?firmarLote">Firmar documentos en lote formato XAdES en servidor</a>
								</p>
							</div>
						</div>
								<%
									if (request.getParameter("firmarLote") != null) {
										ConfigureUtil.initViafirmaClient();
										final String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
										final String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
										String tipoFirma=null;
										List<String>listIdentifiersDocuments=null;
									
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documentos a firmar
										byte[] datosAFirmarTXT = IOUtils.toByteArray(getClass().getResourceAsStream("/ejemplo.txt"));
										byte[] datosAFirmarXML = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										byte[] datosAFirmarPDF = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										try{
											// Iniciamos el lote
											String idTemporalLote=viafirmaClient.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
											
											// Agregamos los distintos documentos
											viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 1.txt",TypeFile.TXT, datosAFirmarTXT);
											viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 2.xml",TypeFile.XML, datosAFirmarXML);
											viafirmaClient.addDocumentoFirmaEnLote(idTemporalLote, "Documento 3.pdf",TypeFile.PDF, datosAFirmarPDF);
											
										
											// Iniciamos la firma del lote en el servidor
											String idFinalFirmaLote=viafirmaClient.signByServerEnLotes(idTemporalLote,alias,pass);
										
										
										 	// Recuperamos el listado de Ids implicados en el lote
											listIdentifiersDocuments=viafirmaClient.getOriginalDocumentsIds(idFinalFirmaLote);
										 	%>
											<div class="box">
											<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<%	
												for (String identifierDocument:listIdentifiersDocuments){
												   	// Recuperamos la informacion de cada documento
													Documento docu = viafirmaClient.getOriginalDocument(identifierDocument);%>
													<p><strong>ID:</strong> <%=docu.getId()%>
													<br/><strong>Nombre:</strong> <%=docu.getNombre()%>
													<br/><strong>Tamaño:</strong> <%=docu.getSize()%>
													<br/><strong>Tipo de Documento:</strong> <%=docu.getTipo()%></p>
														
												<%} %>
											</div>
											</div>
										 	<%
										}catch(Exception e){
											%>
											<div class="box">
												<h2 class="box-title">Ejemplo</h2> 
												<div class="box-content">
													<%	
													e.printStackTrace();
													listIdentifiersDocuments=new LinkedList();
													%>
													<p><strong>Se ha poducido un error en la firma:</strong><%=e.getMessage() %></p>
												</div>
											</div>
										<%}
										/* Comenzamos el proceso de recuperación de los documentos firmados */
										%>
									
									<%} %>
					</div>
					
					<div class="col width-30">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>iniciarFirmaEnLotes</code></li>
									<li><code>addDocumentoFirmaEnLote</code></li>
									<li><code>signByServerEnLotes</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<p>
					<a href="../firmaServer.jsp">&larr; Volver</a>
				</p>
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
