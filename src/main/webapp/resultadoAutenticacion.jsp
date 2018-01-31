<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="org.viafirma.cliente.vo.UsuarioGenericoViafirma"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Examples</title>
		
		<link rel="stylesheet" href="css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">	
				<h2>Resultado del proceso de autenticación</h2>
				
				<%if(request.getAttribute("error")!=null ){%>
				<p class="message error">${error}. Operación cancelada</p>
				<%}else{ %>
				<table>
					<tbody>
						<tr><th class="width-20"><strong>First Name</strong> </th><td>${usuarioAutenticado.firstName}</td></tr>
						<tr><th class="width-20"><strong>Last Name</strong></th><td>${usuarioAutenticado.lastName}</td></tr>
						<tr><th class="width-20"><strong>Number User Id</strong></th><td>${usuarioAutenticado.numberUserId}</td></tr>
						<tr><th class="width-20"><strong>E-mail</strong></th><td>${usuarioAutenticado.email}</td></tr>
						<tr><th class="width-20"><strong>Ca Name</strong></th><td>${usuarioAutenticado.caName}</td></tr>
						<tr><th class="width-20"><strong>Oids</strong></th><td>${usuarioAutenticado.oids}</td></tr>
						<tr><th class="width-20"><strong>Type Certificate</strong></th><td>${usuarioAutenticado.typeCertificate}</td></tr>
						<tr><th class="width-20"><strong>Type Legal</strong></th><td>${usuarioAutenticado.typeLegal}</td></tr>
					</tbody>
				</table>
				<%}%>
				<p>
					<a href="index.jsp">&larr; Inicio</a>
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