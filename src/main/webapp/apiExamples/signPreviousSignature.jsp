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
				<h2>Método <code>signPreviousSignature</code></h2>
				
				<p>El método <code>signPreviousSignature</code> firma un documento que ya ha sido firmado</p>
				<p>Con este metodo se pueden añadir firmas a un documento con multifirma.</p> 
				<p>
					Recibe como paramentro:
				</p>
				<ul class="parameters">
					<li><code>String signId</code> Listado de códigos temporales que identifican a los archivos</li>
		    		<li><code>HttpServletRequest request</code> Request</li>
		    		<li><code>HttpServletResponse response</code> Response</li>
		    		<li><code>String uriRetorno</code> [Opcional] Direccion de retorno cuando termine el proceso de firma</li>
		    	</ul>
		      <!-- 
				<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
		
				<%
				if(request.getParameter("sign")!=null){
					//Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
					ConfigureUtil.initViafirmaClient();
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					
					byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
					//Recuperamos 
					String idFirma=viafirmaClient.prepareFirmaWithTypeFileAndFormatSign("temp.txt",TypeFile.TXT,TypeFormatSign.CMS,datosAFirmar);
					viafirmaClient.signPreviousSignature(idFirma,request, response,"/viafirmaClientResponseServlet");
				}
			
				%>
				
				
					<div style="text-align:center;">
					<p><a href="?sign">Iniciar firma</a></p>
					</div>-->
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