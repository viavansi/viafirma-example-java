<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
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
							<h3 class="box-title">Firma CAdES Explicit</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza una firma CAdES Explicit en la que lo que se envía a firmar es el hash del documento.</p>
								<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
								
								<p>
									<a class="button" href="?firmarCAdESxplicit">Firma de documento en formato CAdES Explicit</a>
								</p>
							</div>
						</div>
								
								<%
									ConfigureUtil.initViafirmaClient();
									final String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
									final String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
									String tipoFirma=null;
									
									if (request.getParameter("firmarCAdESxplicit") != null) {
										
										// Datos documento a firmar
										tipoFirma="CAdES Explicit";
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
													try{
														ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
														
														// Datos documento a firmar
														byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
																								
														//Creamos Policy y Documento
														Policy policy = new Policy();
														policy.setTypeFormatSign(TypeFormatSign.CAdES_EPES);
														policy.setTypeSign(TypeSign.DETACHED);
															    
														Documento documento = new Documento("hashSigned", DigestUtils.sha(datosAFirmar), TypeFile.hash, TypeFormatSign.CAdES_EPES);
																								
														// Indicamos a la plataforma que deseamos firmar el fichero
														String idFirma = viafirmaClient.signByServerWithPolicy(policy, documento, alias, pass);																								
														
														byte[] originalDocument = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
														String hashOriginal = new String(Base64.encodeBase64(DigestUtils.sha(originalDocument)));
														byte[] signedDocument = viafirmaClient.getDocumentoCustodiado(idFirma);
														//Valida con documento firmado
														FirmaInfoViafirma signInfo = viafirmaClient.checkSignedHashDocumentValidity(signedDocument, hashOriginal, TypeFormatSign.CMS);
														

														%>
														<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
														<strong>Id de firma:</strong><%=idFirma%><br/>
														<strong>Está firmado:</strong><%=signInfo.isSigned()%><br/>
														<strong>Es válida:</strong><%=signInfo.isValid()%><br/>
														<strong><a href="<%=ConfigureUtil.URL_VIAFIRMA%>/v/<%=idFirma%>?d">Descargar documento firmado</a>
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