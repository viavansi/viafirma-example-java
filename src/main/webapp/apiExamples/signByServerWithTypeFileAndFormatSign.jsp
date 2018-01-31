<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
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
				<h2>Método <code>signByServerWithTypeFileAndFormatSign</code></h2>
				
				<p>Este ejemplo, firma automaticamente en servidor un documento</p>
				
				<p>Recibe como paramentro:</p>
				
				<ul class="parameters">
					<li><code>String nombredocumento</code> Nombre con el que se guardará el documento</li>
					<li><code>byte[] datosToSign</code> Byte array de los datos del fichero a firmar</li>
					<li><code>String alias</code> Alias del certificado utilizado</li>
				    <li><code>String password</code> Password del certificado utilizado</li>
			    	<li><code>TypeFile tipoFichero</code> Tipo de formato del fichero firmado</li>
			    	<li><code>TypeFormatSign tipofirma</code> Tipo de firma realizada en servidor</li>
			    </ul>
			    
			    <p>Devuelve:</p>
			    <ul class="parameters">
			    	<li><code>String</code> Identificador final de la firma en lote</li>
			    </ul>
			    
		    <!-- 
				<p><a href="?pdf">Firma PDF con XAdES</a></p>
				<p><a href="?xml">Firma XML con XAdES</a></p>
				<p><a href="?cms">Firma XML con CMS</a></p>
				<%
				if(request.getParameter("pdf")!=null || request.getParameter("xml")!=null ||request.getParameter("cms")!=null){
						/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
						String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
						String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
						ConfigureUtil.initViafirmaClient();
						byte[] datosAFirmar=null;
						String idFirma=null;
						String tipoFirma=null;
						int size=0;
						try{
						    if(request.getParameter("pdf")!=null){
								// Ejemplo de firma en XAdES de un pdf
								tipoFirma="Firma en formato XAdES de un archivo PDF";
								datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
								idFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("exampleSign.pdf",datosAFirmar,alias,pass,TypeFile.PDF,TypeFormatSign.XADES_EPES_ENVELOPED);		
							}
							if(request.getParameter("xml")!=null){
								// Ejemplo de firma de documento xml con XAdES
								tipoFirma="Firma en formato XAdES de un archivo XML";
								datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
								idFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("prueba.xml",datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
							}
							if(request.getParameter("cms")!=null){
								// Ejemplo de firma de documento xml con CMS
								tipoFirma="Firma en formato CMS de un archivo XML";
								datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
								idFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("temp.txt",datosAFirmar,alias,pass,TypeFile.TXT,TypeFormatSign.CMS);
							}
							// La firma se ha realizado, recuperamos el documento custodiado.
							byte [] datos=ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
							size=datos.length;
						}catch(InternalException e){
						    %>
							<p>No se puede realizar la firma.<%=e.getMessage() %></p>
							<%
							e.printStackTrace();
						}
				%>
				<div style="text-align:left;">
				<p><strong>Tipo de firma:</strong><%=tipoFirma %><br/>
				<strong>Id de firma:</strong><%=idFirma%>.<br/>
				<strong>Tamaño del documento firmado:</strong><%=size %>.</p>
				</div>
				<%} %>-->

				<p>
					<a href="./">&larr; Volver</a>
				</p>
				
				<p class="note">
			    	<strong>(*)</strong> Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
			    </p>
				
				<p class="note">
					<strong>(*)</strong> Comando Linux para importar un certificado al cacerts de Java<br>
					<code>sudo keytool -importkeystore -srckeystore /home/Usuario/.java/deployment/security/trusted.clientcerts<br>
			 			-destkeystore /etc/java-6-sun/security/cacerts -deststorepass changeit -srcalias AliasDelCertificado<br>
			 			-destalias certificadoAvansiCxA -srckeypass PassOriginal -destkeypass Viavansi</code>	
				</p>
				
				<p class="note">
					<strong>(*)</strong> Para conocer el alias del certificado, usaremos el comando:<br>
					<code>keytool -list -v -keystore /home/Usuario/.java/deployment/security/trusted.clientcerts</code>
				</p>
				
				<p class="note">
					<strong>(*)</strong> Para comprobar si esta importado correctamente<br>
					<code>keytool -list -keystore /etc/java-6-sun/security/cacerts</code>
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