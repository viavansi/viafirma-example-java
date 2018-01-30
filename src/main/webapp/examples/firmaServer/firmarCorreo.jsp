<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>

<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<div style="text-align:center;">
					<h1>Aplicación de ejemplo para integradores de Viafirma</h1>
					<p> Este ejemplo, envia un correo firmado con un certificado electrónico.<br>
					Para su correcto funcionamiento el servidor de Viafirma debe tener correctamente configurado el servidor de correo saliente (SMTP).<br>
					</p>
					+ info: <a href="../../apiExamples/sendSignMailByServer.jsp">sendSignMailByServer</a>
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
					</div>
				<br/>
				<div style="text-align:center;">
					<p><a href="../../index.jsp">Inicio</a>| <a href="../firmaServer.jsp">Firmas con intervención del usuario </a></p>
				</div>
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
