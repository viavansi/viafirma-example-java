<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
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
								<p>En este ejemplo se realiza la firma de un documento XML con formato XAdES_EPES en Viafirma con la intervención directa del usuario.</p>
								
								<p class="button">
									<a href="?firmarXML">Firma XAdES de documento XML con Viafirma</a>
								</p>
								
								<p class="button">
									<a href="?firmarXML&signNode">Firmar XML en XAdES, firmando un nodo especifico</a>
								</p>
								
								<p class="button">
									<a href="?firmarXMLDsig">Firmar XML en XMLDsig</a>
								</p>
								
								<%
									ConfigureUtil.initViafirmaClient();
									
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));	
										//Creamos el documento
										Documento doc = new Documento("pruebaXML.xml",datosAFirmar,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
										
										//Seteamos la politica
										Policy pol = new Policy();
										pol.setTypeFormatSign(TypeFormatSign.XMLDSIG);
										pol.setTypeSign(TypeSign.DETACHED);
// 										//Parametros de politica
										Map<String,String> params = new HashMap<String, String>();
										params.put(PolicyParams.DETACHED_REFERENCE_URL.getKey(), "http://descargas.viavansi.com/viafirma/exampleSign.pdf");
										params.put("CLIENT_LOCALE", "ca-ES"); //params.put(PolicyParams.CLIENT_LOCALE.getKey(), "ca-ES");
										params.put("APPLET_STYLE", "templateBlue"); //params.put(PolicyParams.APPLET_STYLE.getKey()", "templateBlue");
										pol.setParameters(params);
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma = viafirmaClient.prepareSignWithPolicy(pol, doc);	
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
									
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-45">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>prepareFirmaWithTypeFileAndFormatSign</code></li>
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