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
									<a href="?firmarTexto">Firma de documento de texto en formato XAdES con Viafirma</a>									
								</p>
								<p class="button">
									<a href="?firmarTexto=true&XADES_T_ENVELOPED=true">Firma de documento de texto en formato XADES_T_ENVELOPED con Viafirma</a>									
								</p>
								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmarTexto") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = "Prueba de firma".getBytes();
										
										Policy policy = new Policy();
									
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma;
										if(request.getParameter("idMultifirma") != null){
											idFirma = request.getParameter("idMultifirma");
											session.setAttribute("idMultifirma", idFirma);
										}else if(request.getParameter("multiSign") != null){
										    TypeFile typeFile = TypeFile.TXT;
										    TypeFormatSign typeFormatSign = TypeFormatSign.XADES_EPES_ENVELOPED;
										    
										    policy.setTypeFormatSign(typeFormatSign);
										    policy.setTypeSign(TypeSign.ENVELOPED);
										    
										    Documento documento = new Documento("fimrado.txt", datosAFirmar, typeFile, typeFormatSign);
										    
										    idFirma = ViafirmaClientFactory.getInstance().prepareSignWithPolicy(policy, documento);
											idFirma = ViafirmaClientFactory.getInstance().enabledMultiSign(idFirma);
											session.setAttribute("idMultifirma", idFirma);
										}else{
										    //Formato de firma
											TypeFormatSign format;
											if(request.getParameter("XADES_A") != null){
												format = TypeFormatSign.CAdES_A;
											}else if(request.getParameter("XADES_BES") != null){
												format = TypeFormatSign.XADES_BES;
											}else if(request.getParameter("XADES_EPES_ENVELOPED") != null){
												format = TypeFormatSign.XADES_EPES_ENVELOPED;
											}else if(request.getParameter("XADES_T_ENVELOPED") != null){
												format = TypeFormatSign.XADES_T_ENVELOPED;
											}else if(request.getParameter("XADES_XL_ENVELOPED") != null){
												format = TypeFormatSign.XADES_XL_ENVELOPED;
											}else{
												//por defecto XADES_BES
												format = TypeFormatSign.XADES_EPES_ENVELOPED;
											}
											 TypeFile typeFile = TypeFile.TXT;
											    
											    policy.setTypeFormatSign(format);
											    policy.setTypeSign(TypeSign.ENVELOPED);
											    
											    Documento documento = new Documento("fimrado.txt", datosAFirmar, typeFile, format);
																					    
											    idFirma = ViafirmaClientFactory.getInstance().prepareSignWithPolicy(policy, documento);
											    
										}
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
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
									<li><code>prepareSignWithPolicy</code></li>
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
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="https://doc.viafirma.com/viafirma-platform/integration/">Manual de integración de viafirma platform</a> 
				</p>
				<p>
					<small>3.0.0</small>
				</p>
			</div>
		</div>
	</body>
</html>