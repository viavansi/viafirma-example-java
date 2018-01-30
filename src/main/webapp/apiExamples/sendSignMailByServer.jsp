<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>

<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
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
				<h2>Método <code>sendSignMailByServer</code></h2>
				
				<p>El método <code>sendSignMailByServer</code> permite el envío de emails firmados digitalmente. Devuelve un <code>boolean</code>con el resultado de la operación.</p>
				
				<p>Para su correcto funcionamiento, el servidor de Viafirma debe tener correctamente configurado el servidor de correo saliente (SMTP). Necesita también un certificado de usuario dentro del Cacerts de Java (*)</p>
				
				<p>Recibe como paramentro:</p>
				<ul class="parameters">
					<li><code>String subject</code> Asunto del mensaje</li>
					<li><code>String mailTo</code> Destinatario</li>
					<li><code>String texto</code> Mensaje</li>
					<li><code>String htmlTexto</code> Mensaje en formato Html [Opcional]</li>
					<li><code>String alias</code> Alias del certificado utilizado</li>
				    <li><code>String password</code> Password del certificado utilizado</li>
			    </ul>
			    
			    <p>Devuelve:</p>
			    <ul class="parameters">
					<li><code>booelan</code> Resultado del proceso</li>
				</ul>
				<%
					// Envia el contenido seguido del contenido en HTML indicado en las cadenas de caracteres. Se enviara al destinatario indicado en el mailTo
					//y firmado con el certificado indicado por el alias. El servidor de correo configurado actualmente es el servidor de correo interno de Viavansi,
					//por lo que solo se permite enviar correos a direcciones internas de la empresa.
				if(request.getParameter("mail")!=null){
					String asunto="Viafirma";
					String mailTo="pruebas@test.es"; /* Cuenta de correo a la que quiero enviar el mensaje*/
					String contenido="Esto es una prueba";
					String contenidoHTML="<b>Esto es una prueba</b>";
					String alias=ConfigureUtil.CERTALIAS; /* Alias del certificado con el que quiero firmar el mensaje*/
					String pass=ConfigureUtil.CERTPASS;     /* Password del certificado con el que quiero firmar el mensaje*/
					
					ConfigureUtil.initViafirmaClient();
					
					try{
						ViafirmaClientFactory.getInstance().sendSignMailByServer(asunto,mailTo,contenido,contenidoHTML,alias,pass);
					}catch(InternalException e){
						%>No se puede firmar el email.<%=e.getMessage() %><%
					}
				}
				%>
				<p>
					<a href="../apiExamples/" >&larr; Volver</a>
				</p>	
				
				<p class="note">
					<strong>(*)</strong> Comando Linux para importar un certificado al cacerts de Java<br>
					<code>
					sudo keytool -importkeystore -srckeystore /home/Usuario/.java/deployment/security/trusted.clientcerts<br />
		 			-destkeystore /etc/java-6-sun/security/cacerts -deststorepass changeit -srcalias AliasDelCertificado<br />
		 			-destalias certificadoAvansiCxA -srckeypass PassOriginal -destkeypass Viavansi
		 			</code>	
				</p>
				<p class="note">
					<strong>(*)</strong> Para conocer el alias del certificado, usaremos el comando:<br />
					<code>
					keytool -list -v -keystore /home/Usuario/.java/deployment/security/trusted.clientcerts
					</code>
				</p>
				<p class="note">
					<strong>(*)</strong> Para comprobar si esta importado correctamente<br>
					<code>
					keytool -list -keystore /etc/java-6-sun/security/cacerts
					</code>
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