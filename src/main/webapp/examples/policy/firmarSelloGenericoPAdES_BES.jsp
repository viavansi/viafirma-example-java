<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="../../"><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firma pdf con sello genérico en PAdES_BES</h2>
			
				<div class="group">
					<div class="col width-48 append-02">
						<div class="box">
							<h3 class="box-title">Firma de documento pdf sellado con Viafirma</h3>
							
							<div class="box-content">
								<p>En este ejemplo implementa la firma de un documento pdf sellado haciendo uso del applet de Viafirma.</p>
								
								<p>
									<a class="button" href="?firmar">Firmar documento pdf de ejemplo</a>
								</p>
							</div>
						</div>
					</div>
					
					<%
									if (request.getParameter("firmar") != null) {
										ConfigureUtil.initViafirmaClient();
										
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));	
										byte[] logoStamp = IOUtils.toByteArray(getClass().getResourceAsStream("/stamperWatermark.png"));
										//Creamos el documento
										Documento doc = new Documento("exampleSign.pdf",datosAFirmar,TypeFile.PDF,TypeFormatSign.PAdES_BES);
										
										//Seteamos la politica
										Policy policy = new Policy();
										policy.setTypeFormatSign(TypeFormatSign.PAdES_BES);
										policy.setTypeSign(TypeSign.ATTACHED);
 										policy.addParameter(PolicyParams.DIGITAL_SIGN_PAGE.getKey(), "1");
										policy.addParameter(PolicyParams.DIGITAL_SIGN_RECTANGLE.getKey(), new org.viafirma.cliente.vo.Rectangle(40,10,550,75));
										policy.addParameter(PolicyParams.PADES_INCLUDE_TSA.getKey(), "true");
										//policy.addParameter(PolicyParams.DIGITAL_SIGN_TIMEZONE.getKey(), "GMT-8");
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma = viafirmaClient.prepareSignWithPolicy(policy, doc);	
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
									}
								%>
					
					<div class="col width-50">
						<div class="box">
							<h3 class="box-title">Parámetros utilizados</h3>
							
							<div class="box-content">
								<ul>
									<li>TypeFormatSign</li>
									<li>TypeSign</li>
									<li>DIGITAL_SIGN_PAGE</li>
									<li>DIGITAL_SIGN_RECTANGLE</li>
									<li>PADES_INCLUDE_TSA</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
					
				<p>
					<a href="../firmaPolicy.jsp">&larr; Volver</a>
				</p>
			
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