<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.vo.UsuarioGenericoViafirma"%>
<%@page import="java.util.Map" %>


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
				<h2>Método <code>prepareFirmaWithTypeFileAndFormatSignAndFilterCertificate</code></h2>
				
				<p>Para poder firmar un documento, primero se debe enviar el fichero a Viafirma.<br/>El método <code>prepareFirmaWithTypeFileAndFormatSignAndFilterCertificate</code> solo permite firmar al usuario que se le indica y devuelve un identificador temporal que estará disponible durante 10 minutos que permitirá referenciar al archivo durante el proceso de firma.</p> 
				<p>Recibe como paramentro:</p>
				
				<ul class="parameters">
					<li><code>tituloFile</code> Titulo del fichero</li>
					<li><code>tipoFichero</code> Extension del fichero</li>
					<li><code>formatoFirma</code> Tipo de la firma a realizar</li>
					<li><code>bytesToSign</code> Byte array de los datos del fichero</li>
					<li><code>usuarioGenericoViafirma</code> Único usuario que podrá firmar</li>
				</ul>
				
				<p>Devuelve:</p>
				<ul class="parameters">
		     		<li><code>String</code> Identificador temporal del documento</li>
				</ul>
				<!--      
				<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
		
				-->
			
					<%
					if(request.getParameter("prepare")!=null){
					    /* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
						String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
						String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
						ConfigureUtil.initViafirmaClient();
						String idFirma=null;
						int size=0;
						try{
						    ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					// Iniciamos la autenticación indicando la uri de retorno.
					Map<String,String>result = viafirmaClient.processResponseAuthentication(request,response);
					// TODO
								byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
								idFirma=ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("titulo_prueba.xml", TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED, datosAFirmar);
		
						}catch(InternalException e){
							e.printStackTrace();
							%>
							<p>No se puede realizar la firma.<%=e.getMessage() %></p>
							<% 
						}
					%>
					<!-- 
				<div style="text-align:center;height:100px;">
					<p>Id de firma generado es:<%//=idFirma%>.</p>
				</div>-->
				<%} %>
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