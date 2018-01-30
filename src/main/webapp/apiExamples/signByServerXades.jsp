<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>


<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
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
				<div style="text-align:center;">
					<h1>Aplicación de ejemplo para integradores de Viafirma</h1>
					<p>Este ejemplo, firma automaticamente en servidor un documento<br>
					Para su correcto funcionamiento el certificado debe estar instalado en el servidor.INCOMPLETO<br>
					<br/><br/>Recibe como paramentro:<br/>
					<code>String nombredocumento</code>( Nombre con el que se guardará el documento )<br/>
					<code>byte[] datosToSign</code>( ( Byte array de los datos del fichero a firmar )<br/>
					<code>String alias</code>( Alias del certificado utilizado )<br/>
				    <code>String password</code>( Password del certificado utilizado )<br/>
				    <code>TypeFile tipoFichero</code>( Tipo de formato del fichero firmado )<br/>
				    <code>TypeFormatSign tipofirma</code>( Tipo de firma realizada en servidor )<br/>
				    <br/>Devuelve:<br/>
				    <code>String</code>( Identificador final de la firma en lote )<br/>
				    <br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
				    </p>
				</div>
				<div style="text-align:left;">
					<a href="../apiExamples/" >Volver al listado</a>
				</div>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>