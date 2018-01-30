<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%-- <%@page import="org.viafirma.cliente.firma.TypeSign"%> --%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%-- <%@page import="org.viafirma.cliente.firma.Policy"%> --%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
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
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Firma XML</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento del cual solo se conoce el hash, 
								se pasa el hash como datos del documento, durante la firma no se calcula hash del documento, 
								se usa el hash pasado.
								</p>
								<p>
								Para la validación será necesario utilizar métodos de específicos que reciben 
								el hash del fichero original, por tanto no se realiza el cálculo del hash del 
								documento original, sino que se utiliza el hash pasado</p>
								
								<p class="button">
									<a href="?firmarHashXAdES">Firma XAdES conociendo solo el Hash del documento original</a>
								</p>
								
								<p class="button">
									<a href="?firmarHashCAdES">Firma CAdES conociendo solo el Hash del documento original</a>
								</p>
								
								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmarHashXAdES") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba2.xml"));
										String hashOriginal = new String(org.apache.commons.codec.binary.Base64.encodeBase64(DigestUtils.sha(datosAFirmar)));
										
										//Creamos Policy y Documento
										Policy policy = new Policy();
										policy.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
										policy.setTypeSign(TypeSign.DETACHED);
	    
										Documento documento = new Documento("hashSigned", hashOriginal.getBytes(), TypeFile.hash, TypeFormatSign.XADES_EPES_ENVELOPED);
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma = viafirmaClient.prepareSignWithPolicy(policy, documento);
										
										byte[] datosAFirmar2 = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										
										//Creamos Policy y Documento
										Policy policy2 = new Policy();
										policy2.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
										policy2.setTypeSign(TypeSign.ENVELOPED);
	    
										Documento documento2 = new Documento("firma2.xml", datosAFirmar2, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma2 = viafirmaClient.prepareSignWithPolicy(policy2, documento2);
										
										
										
										List<String> idFirmas = new ArrayList<String>();
										idFirmas.add(idFirma2);
										idFirmas.add(idFirma);
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirmasIndependientes(idFirmas, request, response,"/viafirmaClientResponseServlet");
									
									}else if (request.getParameter("firmarHashCAdES") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										String hashOriginal = new String(org.apache.commons.codec.binary.Base64.encodeBase64(DigestUtils.sha(datosAFirmar)));
										
										//Creamos Policy y Documento
										Policy policy = new Policy();
										policy.setTypeFormatSign(TypeFormatSign.CAdES_EPES);
										policy.setTypeSign(TypeSign.DETACHED);
	    
										Documento documento = new Documento("hashSigned", DigestUtils.sha(datosAFirmar), TypeFile.hash, TypeFormatSign.CAdES_EPES);
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma = viafirmaClient.prepareSignWithPolicy(policy, documento);
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idFirma, request, response,"/viafirmaClientResponseServlet");
									
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
									<li><code>solicitarFirma</code></li>
									<li>Policy:</li>
									<ol>
										<li>TypeFormatSign: CAdES or XAdES</li>
										<li>TypeSign.DETACHED</li>
									</ol>
									<li>Documento:</li>
									<ol>
										<li>TypeFormatSign: CAdES or XAdES</li>
										<li>TypeFile.hash</li>
									</ol>
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
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>