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
			<h1 id="header"><a href="../"><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmar documento controlado por filtro con Viafirma</h2>
				
			
				<div class="group">
					<div class="col width-48 append-02">
						<div class="box">
							<h3 class="box-title">Firma de documento por filtro con Viafirma</h3>
							
							<div class="box-content">
								<p>En este ejemplo se intenta acceder a una página y mediante filtro se controla que el acceso solo se realice si el usuario se ha firmado a través del applet de Viafirma.</p>
								
								<p>
									<a class="button" href="../exampleFilter/resultadoFirma.jsp">Firmar documento controlado por filtro</a>
								</p>
							</div>
						</div>
					</div>
					
					<div class="col width-50">
						<div class="box">
							<h3 class="box-title">Ficheros relacionados</h3>
							
							<div class="box-content">
								<ul>
									<li>src/main/webapp/WEB-INF/web.xml</li>
									<li>src/main/java/com.viavansi.examples.FirmaFilter</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
					
				<p>
					<a href="../examples/firmaUsuario.jsp">&larr; Volver</a>
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