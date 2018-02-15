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
				<h2>Autenticar al usuario usando el cliente Javascript</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Autenticación del usuario con Viafirma</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la autenticación del usuario utilizando el cliente Javascript con la intervención directa del usuario.</p>
						
								<%
									if (request.getParameter("autenticar") != null) {
							    %>
                                <script src="<%=ConfigureUtil.getViafirmaServer() %>/viafirma.js"></script>
                                <script>
                                function showError(response) {
                                	   document.getElementById("loading").style = "display: none;";
                                	   document.getElementById("authError").innerHTML = "Ocurrió un problema durante la autenticación: "+ JSON.stringify(response);
                                }
                                
                                function showCancel(response) {
                                	   document.getElementById("loading").style = "display: none;";
                                	   document.getElementById("authCancel").innerHTML = "La autenticación fue cancelada: "+ JSON.stringify(response);
                                }
                                
                                function showSuccess(response) {
                                	   document.getElementById("loading").style = "display: none;";
                                    
                                    document.getElementById("authSuccess").innerHTML = "<p>Operación de autenticación realizada con éxito. Información obtenida:</p><ul>"+
                                    	   "<li><strong>ID de operación</strong>: "+ response.operationId +"</li>"+
                                    	   "<li><strong>Identificación usuario</strong>: "+ response.numberUserId +"</li>"+
                                    	   "<li><strong>Usuario</strong>: "+ response.name +" "+ response.surname1 +" "+ response.surname2 +"</li>"+
                                    	   "<li><strong>CA</strong>: "+ response.shortCa +"</li>"+
                                    	    "</ul>";
                                }
                                
                                function initAuth() {
                                	   document.getElementById("authButton").style = "display: none;";
                                	   document.getElementById("loading").innerHTML = "<img src='../images/icons/ajax-loader.gif' />";
                                	   
                                	   // Start the viafirma JS client: watch the status of a given operationId
                                	   // - if the operation fails, "errorCallback" will be called
                                	   // - if the operation is cancelled, "cancelCallback" will be called
                                	   // - if the operation is completed: "successCallback" will be called
                                	   viafirma.init({
                                		   operationId: "1518614616080JZOZ4JRB",
                                		   viafirmaUrl: "<%=ConfigureUtil.getViafirmaServer() %>/",
                                		   errorCallback: function(response) {
                                			   showError(response);
                                		   },
                                		   successCallback: function(response) {
                                			   showSuccess(response);
                                		   },
                                		   cancelCallback: function(response) {
                                			   showCancel(response);
                                		   }
                                	   });
                                }
                                </script>
                                <p id="authError"></p>
                                <p id="authCancel"></p>
                                <p id="authSuccess"></p>
                                <p id="loading"></p>
                                <p id="authButton">
                                    <a class="button" href="#" onclick="initAuth();">Autenticar con Viafirma</a>
                                </p>
                                <%  		
									} else {
								%>
                                <p>
                                    <a class="button" href="?autenticar=true">Iniciar proceso de autenticación</a>
                                </p>
                                <%                           
                                    }
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-35">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							
							<div class="box-content">
								<ul>
									<li><code>viafirma.init()</code></li>
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