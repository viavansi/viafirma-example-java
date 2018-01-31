<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.vo.Rectangle"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
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
			<h1 id="header"><a href="../.."><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmas con intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Firma PDF con sello</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma con sello de un documento PDF en formato PDF Signature con Viafirma con la intervención directa del usuario.</p>
							
								<p class="button">
									<a href="?firmarPDFConSelloAvanzado">Firma de PDF en formato PDF Signature con imagen de sello y posicionamiento</a>
								</p>								
								<%
									ConfigureUtil.initViafirmaClient();
									
									if (request.getParameter("firmarPDFConSelloAvanzado") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										
										// Preparamos un rectangulo para albergar la imagen de la firma
										org.viafirma.cliente.vo.Rectangle rectangle=new Rectangle(225,100,150,100);
										
										//Ejemplo de firma pdf en el que se coloca una imagen como sello de firma y el nombre y nif del firmante.
										Policy policy = new Policy();
										policy.setTypeSign(TypeSign.ATTACHED);
										policy.setTypeFormatSign(TypeFormatSign.PDF_PKCS7);

										Integer numPage =1;
										 
										//imagen base para el sello de firma.
										byte [] imageStamp=IOUtils.toByteArray(this.getClass().getResourceAsStream("/logoStamp.jpg"));
										policy.addParameter(PolicyParams.DIGITAL_SIGN_IMAGE_STAMPER.getKey(),imageStamp);
										//string que indica la pagina en la que se colocar 1 (primera página) a N. ademas -1 última página, 
										policy.addParameter(PolicyParams.DIGITAL_SIGN_PAGE.getKey(), numPage.toString());
										// añade ademas de la imagen el nombre y nif del firmante (generando una segunda imagen con esa información)
										policy.addParameter(PolicyParams.DIGITAL_SIGN_IMAGE_STAMPER_AUTOGENERATE.getKey(), "true");

										policy.addParameter(PolicyParams.DIGITAL_SIGN_RECTANGLE.getKey(), rectangle);

										// Indicamos a la plataforma que deseamos firmar el fichero
										Documento documento = new Documento("example.pdf", datosAFirmar, TypeFile.PDF, TypeFormatSign.PDF_PKCS7);
										 // requiere indicar el formato de firma por documento(ademas de la politica)
										String idTemporal = viafirmaClient.prepareSignWithPolicy(policy, documento);
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idTemporal,request, response,"/viafirmaClientResponseServlet");
									}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-35">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>prepareSignWithPolicy</code></li>
									<li><code>solicitarFirma</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../firmaUsuario.jsp">&larr; Volver</a></p>
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