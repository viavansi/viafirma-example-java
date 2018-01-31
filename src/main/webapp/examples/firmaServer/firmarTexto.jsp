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
							<h3 class="box-title">Firma texto</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento de texto con formato XAdES_EPES en el servidor sin la intervención directa del usuario.</p>
								<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
								
								<p>
									<a class="button" href="?firmarTexto">Firma de documento de texto en formato XAdES en servidor</a>
								</p>
							</div>
						</div>
								
								<%
									ConfigureUtil.initViafirmaClient();
									final String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
									final String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
									String tipoFirma=null;
									
									if (request.getParameter("firmarTexto") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Datos documento a firmar
										byte[] datosAFirmar = "Prueba de firma".getBytes();
										tipoFirma="Firma en formato XAdES de un archivo de texto";
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
													try{
													    Policy policy = new Policy();
													    TypeFormatSign format = TypeFormatSign.XADES_EPES_ENVELOPED;
													    
													    policy.setTypeFormatSign(format);
														policy.setTypeSign(TypeSign.ENVELOPED);

														Documento documento = new Documento("doc.txt", datosAFirmar, TypeFile.txt, format); 
														String idFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
													    
														%>
														<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
														<strong>Id de firma:</strong><%=idFirma%>.<br/>
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
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="https://doc.viafirma.com/viafirma-platform/integration/">Manual de integración de viafirma platform</a> 
				</p>
				<p>
					<small>3.0.0</small>
				</p>
			</div>
		</div>
	</body>
</html>