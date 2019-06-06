<%@page import="org.viafirma.cliente.util.OptionalRequest"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil" %>
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.FilterOperator"%>
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.CertFilter"%>
<%@page import="org.viafirma.cliente.vo.DirectDesktopInvocation"%>
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.AuthOperationRequest"%>
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
				<h2>Autenticar al usuario usando llamada a Viafirma Desktop por protocolo (requiere Javascript)</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Autenticación del usuario con Viafirma</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la autenticación del usuario utilizando Javascript para la invocación a Viafirma Desktop por protocolo. Requiere código Javascript local.</p>
						
								<%
									
									if (request.getParameter("autenticar") != null) {
									 	// This is just a sample; your app would start with something like this:
										ConfigureUtil.initViafirmaClient();										
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
									    // Now use the new prepareAuthForDirectDesktop method
									    AuthOperationRequest authRequest = new AuthOperationRequest();
									    
									    //Examples with filters
									    CertFilter certFilter = new CertFilter();
									    List<String> filterValueList = new ArrayList<String>();
									    filterValueList.add("FNMT");
									    certFilter.setOperator(FilterOperator.contains);
									    certFilter.setFilterValues(filterValueList);
									    
									    CertFilter caFilter = new CertFilter();
									    caFilter.setOperator(FilterOperator.contains);
									    caFilter.getFilterValues().add("FNMT");
									    
									    CertFilter numberUserIdFilter = new CertFilter();
									    numberUserIdFilter.setOperator(FilterOperator.contains);
									    numberUserIdFilter.getFilterValues().add("4");
									    
									    //authRequest.setCertFilter(certFilter);
									    //authRequest.setCaFilter(caFilter);
									    //authRequest.setNumberUserIdFilter(numberUserIdFilter);

									    authRequest.setAutoSend(false);
									    authRequest.setSessionId(request.getSession().getId());
									    
									    // The method returns an object with the information required to:
									    // a) Create a button that opens Viafirma Desktop by protocol
									    // b) Gets the just-prepared operation ID to start polling using Javascriot
									    DirectDesktopInvocation directCall = viafirmaClient.prepareAuthForDirectDesktop(authRequest);
									    String operationId = directCall.getOperationId();
									    String viafirmaDesktopLink = directCall.getViafirmaDesktopInvocationLink();
									    String viafirmaDesktopAlternateLink=viafirmaDesktopLink.replace("viafirmawpfclient","viafirmadesktop");
							    %>
							    
                                <script src="<%=ConfigureUtil.getViafirmaServerPublicWS() %>/viafirma.js?t=<%=System.currentTimeMillis()%>">
                             		// Including this remote Javascript is mandatory, it includes the polling logic
                                </script>
                                <script>
                                // Customize this in your own client webapp... this is just a sample!
                                // When the polling detects an error, it invokes this function
                                function showError(response) {
                                	document.getElementById("loading").innerHTML = "";
                                	document.getElementById("authError").innerHTML = "Ocurrió un problema durante la autenticación: "+ JSON.stringify(response);
                                }
                             	// If the user cancels the operation in Viafirma Desktop app, this function is invoked
                                function showCancel(response) {
                                	document.getElementById("loading").innerHTML = "";
                                	document.getElementById("authCancel").innerHTML = "La autenticación fue cancelada: "+ JSON.stringify(response);
                                }
                             	// If the authentication runs ok, this function is invoked - customize it with your own logic 
                                function showSuccess(response) {
                                	window.location.replace("./exampleAuthenticationViafirmaDesktopResult.jsp?operationId=" + response.operationId);
                                }
                             	// If Viafirma Desktop is not loaded, this function is invoked
                                function showUnloaded() {
                                	alert("Viafirma Desktop no encontrado");
                                 	document.getElementById("loading").style = "display: none;";
                                    
                                  	document.getElementById("authSuccess").innerHTML = 
                                	  "<p>Viafirma Desktop no ha sido cargado, aquí se puede incluir código para gestionar la instalación, instrucciones, etc.</p>";
                                }
                                // Here we initialize the viafirma.js polling 
                                function initAuth() {
                                	   document.getElementById("authButton").style = "display: none;";
                                	   document.getElementById("loading").innerHTML = "<img src='../images/icons/ajax-loader.gif' />";
                                	   
                                	   // Start the viafirma JS client: watch the status of a given operationId
                                	   // - if the operation fails, "errorCallback" will be called
                                	   // - if the operation is cancelled, "cancelCallback" will be called
                                	   // - if the operation is completed: "successCallback" will be called
                                	   // - if Viafirma client is not loaded after unloadedTime seconds: "unloadedCallback" 
                                	   viafirma.init({
                                		   // Here we include 
                                		   operationId: "<%=operationId%>",
                                		   viafirmaUrl: "<%=ConfigureUtil.getViafirmaServerPublicWS() %>/",
                                		   unloadedTime: 5,
                                		   errorCallback: function(response) {
                                			   showError(response);
                                		   },
                                		   successCallback: function(response) {
                                			   showSuccess(response);
                                		   },
                                		   cancelCallback: function(response) {
                                			   showCancel(response);
                                		   },
                                		   unloadedCallback: function(response) {
                                			   showUnloaded();
                                		   }
                                	   });
                                }
                                </script>
                                <p id="authError"></p>
                                <p id="authCancel"></p>
                                <p id="authSuccess"></p>
                                <p id="loading"></p>
                                <p id="authButton">
                                    <a class="button" href="<%=viafirmaDesktopLink%>" onclick="initAuth();">Autenticar con Viafirma (viafirmawpfclient)</a>       
                                </p>
                                <p>                                                             
                                    <a class="button" href="<%=viafirmaDesktopAlternateLink%>" onclick="initAuth();">Autenticar con Viafirma (viafirmadesktop)</a>
                                </p>
                                <%  		
									} else {
								%>
                                <p>
                                    <a class="button" href="?autenticar=true">Iniciar ejemplo de proceso de autenticación</a>
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
									<li><code>prepareAuthForDirectDesktop</code></li>
									<li><code>javascript: viafirma.init()</code></li>									
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