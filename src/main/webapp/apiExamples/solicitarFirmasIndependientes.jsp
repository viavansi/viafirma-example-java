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
				<h2>Método <code>solicitarFirmasIndependientes</code></h2>
				
				<p>El método <code>solicitarFirmasIndependientes</code> envia al usuario a la pantalla de firma donde se cargara el Applet.</p>   
				<p>Con este metodo con una sola firma se firmaran los documentos cuya idFirma se encuentre en la lista que se le pasa. No confundir con Firma en lotes </p>
				
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
					<li><code>List&lt;String&gt; idFirma</code> Listado de códigos temporales que identifican a los archivos</li>
		     		<li><code>HttpServletRequest request</code> Request</li>
		     		<li><code>HttpServletResponse response</code> Response</li>
		     		<li><code>String uriRetorno</code> [Opcional] Direccion de retorno cuando termine el proceso de firma</li>
				</ul>
		      <!-- 
				<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
			
				<%
				if(request.getParameter("firmar")!=null){
					//Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
					ConfigureUtil.initViafirmaClient();
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					
					byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
					//Recuperamos 
					String idFirma=viafirmaClient.prepareFirmaWithTypeFileAndFormatSign("temp.txt",TypeFile.TXT,TypeFormatSign.CMS,datosAFirmar);
					byte[] datosAFirmar2 = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba2.xml"));
					String idFirma2=viafirmaClient.prepareFirmaWithTypeFileAndFormatSign("temp2.txt",TypeFile.TXT,TypeFormatSign.CMS,datosAFirmar2);
					List<String>listIdFirmas = new ArrayList<String>();
					listIdFirmas.add(idFirma);
					listIdFirmas.add(idFirma2);
		
					viafirmaClient.solicitarFirmasIndependientes(listIdFirmas,request,response,"/viafirmaClientResponseServlet");
				}
			
				%>
				
				
					<div style="text-align:center;height:100px;">
					<p><a href="?firmar">Iniciar firma de varios documentos</a></p>
					</div>
						 -->
				<p>
					<a href="./">&larr; Volver</a>
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