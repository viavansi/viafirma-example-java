<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
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
				<h2>Comprobación de validez de firma en un documento</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Validar firma</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento y se recupera el documento custodiado para posteriormente comprobar que la firma es valida.</p>
							
								<fieldset>
									<legend>PDF</legend>
									<p class="button"><a href="?valida&PDF">Validar firmas PDF</a></p>
									<p class="button"><a href="?valida&PDF_TSA">Validar firma PDF con TSA</a></p>
									<p class="button"><a href="?valida&PDF_1_TSA">Validar firmas PDF 1 TSA</a></p>
									<p class="button"><a href="?valida&PDF_2_TSA">Validar firmas PDF 2 TSAs</a></p>								
								</fieldset>
								<fieldset>
									<legend>XML</legend>
									<p class="button"><a href="?valida&XML">Validar firma XML</a></p>
									<p class="button"><a href="?valida&XML_TSA">Validar firma XML con TSA</a></p>
									<p class="button"><a href="?valida&XML_1_TSA">Validar firmas XML 1 TSA</a></p>
									<p class="button"><a href="?valida&XML_2_TSA">Validar firmas XML 2 TSA</a></p>
								</fieldset>
								<fieldset>
									<legend>CMS</legend>
									<p class="button"><a href="?valida&CMS">Validar firma CMS</a></p>
								</fieldset>
							</div>
						</div>
								<%
								if(request.getParameter("valida")!=null){
							
									ConfigureUtil.initViafirmaClient();
									ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
									String alias= ConfigureUtil.CERTALIAS;
									String pass= ConfigureUtil.CERTPASS;
									// Firmamos un documento
									String codFirma = "";
									org.viafirma.cliente.firma.TypeFormatSign formatSign = null;
									String docName = "";
									byte[] datosAFirmar = null;
									if(request.getParameter("XML")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										docName = "prueba.xml";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
										formatSign = TypeFormatSign.XADES_EPES_ENVELOPED;
									}else if(request.getParameter("PDF")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSigned.pdf"));
										docName = "exampleSign.pdf";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.PDF,TypeFormatSign.PDF_PKCS7);
										formatSign = TypeFormatSign.PDF_PKCS7;
									}else if(request.getParameter("CMS")!=null){
										datosAFirmar = "Prueba de firma".getBytes();
										docName = "prueba.txt";
										codFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.TXT,TypeFormatSign.CMS);
										formatSign = TypeFormatSign.CMS;
									}else if(request.getParameter("PDF_TSA")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba_sin_firmar.pdf"));
										docName = "prueba_sin_firmar.pdf";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.PDF,TypeFormatSign.PDF_PKCS7_T);
										formatSign = TypeFormatSign.PDF_PKCS7_T;
									}else if(request.getParameter("PDF_2_TSA")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba_firmado_tsa.pdf"));
										docName = "prueba_firmado_tsa.pdf";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.PDF,TypeFormatSign.PDF_PKCS7_T);
										formatSign = TypeFormatSign.PDF_PKCS7_T;
									}else if(request.getParameter("PDF_1_TSA")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba_firmado_tsa.pdf"));
										docName = "prueba_firmado_tsa.pdf";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.PDF,TypeFormatSign.PDF_PKCS7);
										formatSign = TypeFormatSign.PDF_PKCS7;
									}else if(request.getParameter("XML_TSA")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba_sin_firmar.xml"));
										docName = "prueba_sin_firmar.xml";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_T_ENVELOPED);
										formatSign = TypeFormatSign.XADES_T_ENVELOPED;
									}else if(request.getParameter("XML_2_TSA")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba_firmado_tsa.xml"));
										docName = "prueba_firmado_tsa.xml";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_T_ENVELOPED);
										formatSign = TypeFormatSign.XADES_T_ENVELOPED;
									}else if(request.getParameter("XML_1_TSA")!=null){
										datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba_firmado_tsa.xml"));
										docName = "prueba_firmado_tsa.xml";
										codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign(docName,datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
										formatSign = TypeFormatSign.XADES_EPES_ENVELOPED;
									}
									
									// Recuperamos el documento custodiado
									byte[] datosFirmados = viafirmaClient.getDocumentoCustodiado(codFirma);
									session.setAttribute("documento", datosFirmados);
									
									// Enviamos a Viafirma el documento firmado para que nos indique si la firma es o no válida
									FirmaInfoViafirma firmaInfo = viafirmaClient.checkSignedDocumentValidityByFileType(datosFirmados, formatSign);
									List<FirmaInfoViafirma> firmas = new ArrayList<FirmaInfoViafirma>(); 
									if(firmaInfo.getOtherSigners()!=null){
										firmas.addAll(firmaInfo.getOtherSigners());
									}
									firmas.add(firmaInfo);
									
									%>
									<div class="box">
										<h2 class="box-title">Is signed?</h2> 
										<div class="box-content">
											<p><strong>Documento: </strong><%=docName%></p>
											<p><strong>¿Está firmado?: </strong><%=firmaInfo.isSigned()%></p>
											<p><strong>¿Es válida?: </strong><%=firmaInfo.isValid()%></p>
											<p><strong>Id de Firma: </strong><%=codFirma%></p>
										</div>
									</div>									
									<%if(firmaInfo.isSigned()){ 
										for(int i = 0; i < firmas.size(); i++){
											FirmaInfoViafirma info = firmas.get(i);%>
											<div class="box">
												<h2 class="box-title">Firma <%=i+1%>: <%=info.getNumberUserId()%></h2> 
												<div class="box-content">
													<p><strong>Nif: </strong><%=info.getNumberUserId()%></p>
													<p><strong>Nombre: </strong><%=info.getFirstName()%></p>
													<p><strong>Primer Apellido: </strong><%=info.getLastName()%></p>
													<p><strong>Email: </strong><%=info.getEmail()%></p>
													<p><strong>Tipo de cetificado: </strong><%=info.getTypeCertificate()%></p>
													<p><strong>Tipo Legal: </strong><%=info.getTypeLegal()%></p>
													<p><strong>Autoridad de certificación: </strong><%=info.getCaName()%></p>
													<p><strong>Propiedades: </strong><%=info.getProperties().toString() %>
													<p><strong>Mensaje: </strong><%=info.getMessage()%></p>
												</div>
											</div>
										<%}%>
									<%}%>
									<p> 
										<a class="button" target="_blank" href="../../utils/downloads.jsp"
											title="Descargar documento">Descargar documento</a>
									</p>
							<%}	%>
					</div>
						
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>signByServerWithTypeFileAndFormatSign</code></li>
									<li><code>getDocumentoCustodiado</code></li>
									<li><code>checkSignedDocumentValidityByFileType</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Volver</a></p>
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