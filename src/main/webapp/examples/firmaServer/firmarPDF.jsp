<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
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
				<h2>Firmas sin intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Firma PDF</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento PDF con formato PDF Signature en el servidor sin la intervención directa del usuario.</p>
								<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
								
								<p class="button">
									<a href="?firmarPDF&PDF_PKCS7">Firma de PDF en formato <%=TypeFormatSign.PDF_PKCS7.name()%></a>
								</p>
								<p class="button">
									<a href="?firmarPDF&PDF_PKCS7_T">Firma de PDF en formato <%=TypeFormatSign.PDF_PKCS7_T.name()%> (CON sellado de tiempo)</a>
								</p>
 								<p class="button"> 
 									<a href="?firmarPDF&PAdES_BASIC">Firma de PDF en formato <%=TypeFormatSign.PAdES_BASIC.name()%></a> 
 								</p> 
 								<p class="button"> 
 									<a href="?firmarPDF&PAdES_BES">Firma de PDF en formato <%=TypeFormatSign.PAdES_BES.name()%></a> 
 								</p>
 								<p class="button"> 
  									<a href="?firmarPDF&PAdES_EPES">Firma de PDF en formato <%=TypeFormatSign.PAdES_EPES.name()%></a> 
 								</p>
 								<p class="button"> 
  									<a href="?firmarPDF&PAdES_LTV">Firma de PDF en formato <%=TypeFormatSign.PAdES_LTV.name()%></a> 
 								</p>
 								<p class="button"> 
  									<a href="?firmarPDF&XAdES_role">Firma de PDF en Xades indicado el rol</a> 
 								</p>
							</div>
						</div>
								
								<%
									ConfigureUtil.initViafirmaClient();
									final String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
									final String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
									String tipoFirma=null;
									
									if (request.getParameter("firmarPDF") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										Policy policy = new Policy(); 
										
										//Formato de firma
										TypeFormatSign format;
										TypeFile typeFile = TypeFile.PDF;
										TypeSign typeSign = TypeSign.ENVELOPED;
										String nameDoc = "doc.pdf";
										if(request.getParameter("PDF_PKCS7") != null){
											format = TypeFormatSign.PDF_PKCS7;
										}else if(request.getParameter("PDF_PKCS7_T") != null){
											format = TypeFormatSign.PDF_PKCS7_T;
										}else if(request.getParameter("PAdES_BASIC") != null){
											format = TypeFormatSign.PAdES_BASIC;
										}else if(request.getParameter("PAdES_BES") != null){
											format = TypeFormatSign.PAdES_BES;
										}else if(request.getParameter("PAdES_EPES") != null){
											format = TypeFormatSign.PAdES_EPES;
											policy.addParameter(PolicyParams.SIGNATURE_POLICY_ID.getKey(), "2.16.724.1.3.1.1.2.1.9");
											policy.addParameter(PolicyParams.SIGNATURE_POLICY_HASH_DATA.getKey(), "G7roucf600+f03r/o0bAOQ6WAs0=");
											policy.addParameter(PolicyParams.SIGNATURE_POLICY_URI.getKey(), "https://sede.060.gob.es/politica_de_firma_anexo_1.pdf");
										}else if(request.getParameter("PAdES_LTV") != null){
											format = TypeFormatSign.PAdES_LTV;
										}else if(request.getParameter("XAdES_role") != null){
											format = TypeFormatSign.XADES_BES;
											typeSign = TypeSign.ENVELOPED;
											nameDoc = "doc.xml";
											policy.addParameter(PolicyParams.SIGNER_ROLE.getKey(), "Rol de prueba");
										}else{
											//por defecto PDF_PKCS7
											format = TypeFormatSign.PDF_PKCS7;
										}
										
										// Iniciamos la firmar el fichero
										tipoFirma="Firma en formato " + format.name() + " de un archivo PDF";
										
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
													try{
														// Datos documento a firmar
														byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
														
														policy.setTypeFormatSign(format);
														policy.setTypeSign(typeSign);
														//byte array de la imagen 
														String idFirma = "";

														Documento documento = new Documento(nameDoc, datosAFirmar, typeFile, format); 
														idFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);

														%>
														<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
														<strong>Id de firma:</strong><%=idFirma%><br/>
														<strong><a href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=idFirma%>?d">Descargar Documento</a></strong>
													<%}catch(Exception e){
														%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
													<%}%>
													
												</p>
											</div>
										</div>
										<%	
									}
								%>
						
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>signByServerWithPolicy</code></li>
									<li><code>Formatos:</code>
										<ul>
											<li>TypeFormatSign.PDF_PKCS7</li>
											<li>TypeFormatSign.PDF_PKCS7_T</li>
											<li>TypeFormatSign.PAdES_BASIC</li>
											<li>TypeFormatSign.PAdES_BES</li>
											<li>TypeFormatSign.PAdES_EPES</li>
											<li>TypeFormatSign.PAdES_LTV</li>
										</ul>
									</li>
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