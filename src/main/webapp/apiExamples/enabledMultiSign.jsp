<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="org.viafirma.cliente.ViafirmaClient"%>
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
				<h2>Método <code>enabledMultiSign</code></h2>
				
				<p>El método <code>enabledMultiSign</code> habilita la firma multiple en un documento.</p>   
				<p>
				Con este metodo se permitira que un documento contenga más de una firma.<br/>
				Tras preparar el documento, se le pasa el id temporal generado al metodo para habilitar la multifirma.
				El String que devuelve es el nuevo id del documento, este será utilizado para referenciar al archivo en proximas firmas.</p> 
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
					<li><code>String idFirma</code> Código temporal que identifica al archivo</li>
				</ul>
				
				<p>Devuelve:</p>
				<ul class="parameters">
			 		<li><code>String</code> Código de referencia al archivo con multifirma</li>
			 	</ul>
		
		      
				<p class="note">Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
				<%
				if(request.getParameter("firmar")!=null){
					//Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
					ConfigureUtil.initViafirmaClient();
					
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					
					byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
					String idFirma = viafirmaClient.prepareFirmaWithTypeFileAndFormatSign("temp.txt",TypeFile.TXT,TypeFormatSign.XADES_EPES_ENVELOPED,datosAFirmar);
					String firmaEnabled = viafirmaClient.enabledMultiSign(idFirma);
					
		
					%><p>El identificador del documento con multifirma habilitada es: <%=firmaEnabled %></p>
					 
					<% }%>
				
				
					<!--<div style="text-align:center;height:100px;">
					<p><a href="?firmar">Iniciar firma de varios documentos</a></p>
					</div>
					 -->
				<p>
					<a href="./">&larr; Volver</a>
				</p>
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
		