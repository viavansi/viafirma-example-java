<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="org.viafirma.cliente.vo.UsuarioGenericoViafirma"%>
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
				<h2>Resultado del proceso de autenticación</h2>
				
				<%if(request.getAttribute("error")!=null || request.getAttribute("cancel")!=null || session.getAttribute("error")!=null){%>
				<p class="message error">${error}. Operación cancelada</p>
				<%
					session.removeAttribute("error");
				}else{ %>
				<table>
					<tr><th>First Name</th><td>${usuarioAutenticado.firstName}</td></tr>
					<tr><th>Last Name</th><td>${usuarioAutenticado.lastName}</td></tr>
					<tr><th>Number User Id</th><td>${usuarioAutenticado.numberUserId}</td></tr>
					<tr><th>E-mail</th><td>${usuarioAutenticado.email}</td></tr>
					<tr><th>Ca Name</th><td>${usuarioAutenticado.caName}</td></tr>
					<tr><th>Oids</th><td>${usuarioAutenticado.oids}</td></tr>
					<tr><th>Type Certificate</th><td>${usuarioAutenticado.typeCertificate}</td></tr>
					<tr><th>Type Legal</th><td>${usuarioAutenticado.typeLegal}</td></tr>
				
				</table>
				<%}%>
				<p><a href="../index.jsp" >&larr; Volver</a></p> 
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