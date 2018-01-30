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
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="java.util.*"%>


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
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Firma texto</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento de texto con formato XAdES_EPES en Viafirma con la intervención directa del usuario.</p>
								
								<p class="button">
									<a href="?firmarTexto&multiSign">Iniciar Multifirma de documento de texto en formato XAdES</a>									
								</p>							
								<p class="button">
									<a href="?firmarTexto">dddd Firma de documento de texto en formato XAdES con Viafirma</a>									
								</p>
								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmarTexto") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = "Prueba de firma".getBytes();
									
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma;
										if(request.getParameter("idMultifirma") != null){
											idFirma = request.getParameter("idMultifirma");
											session.setAttribute("idMultifirma", idFirma);
										}else if(request.getParameter("multiSign") != null){
											
											 
											idFirma = ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("prueba.txt",TypeFile.TXT,TypeFormatSign.XADES_EPES_ENVELOPED,datosAFirmar);
											idFirma = ViafirmaClientFactory.getInstance().enabledMultiSign(idFirma);
											session.setAttribute("idMultifirma", idFirma);
										}else{
											// cambiado											
											//Documento doc = new Documento("prueba.txt",datosAFirmar,TypeFile.TXT,TypeFormatSign.XADES_EPES_ENVELOPED);
											// Fujitsu
											/*
											Documento doc = new Documento("prueba.txt",datosAFirmar,TypeFile.hash,TypeFormatSign.XADES_EPES_ENVELOPED);
											Policy pol = new Policy();
											pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
											pol.setTypeSign(TypeSign.DETACHED);
											Map<String,String> params = new HashMap<String,String>();
											//params.put("CLIENT_LOCALE", "ca-ES");
											params.put("CLIENT_LOCALE", "en-EN");
											//params.put("CLIENT_LOCALE", "es-ES");
											//params.put("APPLET_STYLE", "templateBlue");
											params.put("APPLET_STYLE", "viafirmaAssets");
											pol.setParameters(params);
											idFirma=viafirmaClient.prepareSignWithPolicy(pol, doc);
											// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
											List<String> listaFirmas = new LinkedList<String>();
											listaFirmas.add(idFirma);
											viafirmaClient.solicitarFirmasIndependientes(listaFirmas, request, response,"/viafirmaClientResponseServlet");
											*/
											
											//Creamos el documento
											Documento doc = new Documento("pruebaXML.xml",datosAFirmar,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
											//Seteamos la politica
											Policy pol = new Policy();
											pol.setTypeFormatSign(TypeFormatSign.XMLDSIG);
											pol.setTypeSign(TypeSign.DETACHED);
//	 										//Parametros de politica
											Map<String,String> params = new HashMap<String, String>();
											params.put("CLIENT_LOCALE", "ca-ES"); //params.put(PolicyParams.CLIENT_LOCALE.getKey(), "ca-ES");
											params.put("APPLET_STYLE", "templateBlue"); //params.put(PolicyParams.APPLET_STYLE.getKey()", "templateBlue");
											pol.setParameters(params);
											// Indicamos a la plataforma que deseamos firmar el fichero
											String idFirma01 = viafirmaClient.prepareSignWithPolicy(pol, doc);	
											//String idFirma02 = viafirmaClient.prepareSignWithPolicy(pol, doc);
											// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
											List<String> listaFirmas = new LinkedList<String>();
											listaFirmas.add(idFirma01);
											//listaFirmas.add(idFirma01);
											viafirmaClient.solicitarFirmasIndependientes(listaFirmas, request, response,"/viafirmaClientResponseServlet");
											//viafirmaClient.solicitarFirma(idFirma01,request, response,"/viafirmaClientResponseServlet");
											
											
										}
										
									}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>prepareFirmaWithTypeFileAndFormatSign</code></li>
									<li><code>enabledMultisign (to activate multisignature)</code></li>
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
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>