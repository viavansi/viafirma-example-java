<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.DigestMethod"%>
<%@page import="org.viafirma.cliente.firma.SignatureAlgorithm"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
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
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
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
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Firma PDF</h3>
							 
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento PDF con el formato PDF elegido en Viafirma con la intervención directa del usuario.</p>
							
								<p class="button">
									<a href="?firmarPDF=true&PDF_PKCS7=true">Firma de PDF en formato <%=TypeFormatSign.PDF_PKCS7.name() %> (SIN timestamp)</a>
								</p>
								<p class="button">
									<a href="?firmarPDF=true&PDF_PKCS7_T=true">Firma de PDF en formato <%=TypeFormatSign.PDF_PKCS7_T.name() %> (CON timestamp)</a>
								</p>
 								<p class="button"> 
 									<a href="?firmarPDF=true&PAdES_BASIC=true">Firma de PDF en formato <%=TypeFormatSign.PAdES_BASIC.name()%> </a> 
 								</p> 
 								<p class="button"> 
 									<a href="?firmarPDF=true&PAdES_BES=true">Firma de PDF en formato <%=TypeFormatSign.PAdES_BES.name()%> </a> 
 								</p> 
 								<p class="button"> 
  									<a href="?firmarPDF=true&PAdES_EPES=true">Firma de PDF en formato <%=TypeFormatSign.PAdES_EPES.name()%> </a> 
 								</p> 

								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmarPDF") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										//Formato de firma
										TypeFormatSign format;
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
										}else{
											//por defecto PDF_PKCS7
											format = TypeFormatSign.PDF_PKCS7;
										}

										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));

										// Indicamos a la plataforma que deseamos firmar el fichero
										Policy policy = new Policy();

		                                TypeFile typeFile = TypeFile.PDF;
										TypeSign typeSign = TypeSign.ENVELOPED;
		                                
										policy.setTypeFormatSign(format);
										policy.setTypeSign(typeSign);
										
										policy.addParameter(PolicyParams.SIGNATURE_ALGORITHM.getKey(), SignatureAlgorithm.SHA256withRSA.name());

										Documento documento = new Documento("firmado.pdf", datosAFirmar, typeFile, format);

										String idFirma=viafirmaClient.prepareSignWithPolicy(policy, documento);
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
									}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-45">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>prepareSignWithPolicy</code></li>
									<li><code>Formatos:</code>
										<ul>
											<li>TypeFormatSign.PDF_PKCS7</li>
											<li>TypeFormatSign.PDF_PKCS7_T</li>
											<li>TypeFormatSign.PAdES_BASIC</li>
											<li>TypeFormatSign.PAdES_BES</li>
											<li>TypeFormatSign.PAdES_EPES</li>
										</ul>
									</li>
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
