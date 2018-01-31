<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
					<h2>Método <code>checkCertificate</code></h2>
					
					<p>El método <code>checkCertificate</code> chequea la validez de un certificado.</p>
					
					<p>
						Recibe como paramentro:
					</p>
					
					<ul class="parameters">
						<li><code>byte[] pem</code> Byte array de la clave pública del certificado</li>
					</ul>
					
					<p>Devuelve:<p>
					<ul class="parameters">
						<li><code>ValidationInfo</code> Información del certificado indicando su validez</li>
					</ul>
						 <!--<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
						 <p><a href="?check">Comprobar valido</a><a href="?checkNo">Comprobar no valido</a></p>-->
						 
						 <p>
							<a href="./" >&larr; Volver</a>
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
