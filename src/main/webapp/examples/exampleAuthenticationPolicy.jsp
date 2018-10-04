<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
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
			<h1 id="header"><a href=".."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Autenticar al usuario</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Autenticación del usuario con Viafirma</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la autenticación del usuario a través de Viafirma con la intervención directa del usuario.</p>
						
								<%
									if (request.getParameter("autenticar") != null) {
										ConfigureUtil.initViafirmaClient();
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										// Iniciamos la autenticación indicando la uri de retorno.
										Policy policy=new Policy();
										//policy.addParameter(PolicyParams.FILTER_GENERIC.getKey(), "{contains};FNMT");
										viafirmaClient.authWithPolicy(policy, request, response,"/viafirmaClientResponseServlet");
									}
								%>
								<p>
									<a class="button" href="?autenticar=true">Autenticar al usuario con Viafirma</a>
								</p>
							</div>
						</div>
					</div>
					
					<div class="col width-35">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							
							<div class="box-content">
								<ul>
									<li><code>authWithPolicy</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p>
					<a href="../index.jsp">&larr; Inicio</a>
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