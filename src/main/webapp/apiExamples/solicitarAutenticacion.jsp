<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
				<h2>Método <code>solicitarAutenticacion</code></h2>
				
				<p>El método <code>solicitarAutenticacion</code> envia al usuario al Applet de para la autenticación.</p>
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
		    		<li><code>HttpServletRequest request</code> Request</li>
		     		<li><code>HttpServletResponse response</code> Response</li>
		     		<li><code>String uriRetorno</code> [Opcional] Direccion de retorno cuando termine el proceso de autenticación</li>
		     	</ul>
		      
				<%
					ConfigureUtil.initViafirmaClient();
				
					if (request.getParameter("autenticar") != null) {
						ViafirmaClient viafirmaClient = ViafirmaClientFactory
								.getInstance();
						// Iniciamos la autenticación indicando la uri de retorno.
						viafirmaClient.solicitarAutenticacion(request, response,
								"/viafirmaClientResponseServlet");
					}
				%>
				<!--			<p><a href="autenticar">Iniciar autenticacion</a></p>-->
				<p>
					<a href="../apiExamples/" >Volver al listado</a>
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