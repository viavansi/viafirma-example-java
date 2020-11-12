<%@page import="org.viafirma.cliente.vo.Rectangle"%>
<%@page import="org.viafirma.cliente.firma.DigestMethod"%>
<%@page import="org.viafirma.cliente.firma.SignatureAlgorithm"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.util.LinkedList"%>
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.OperationFile"%>
<%@page import="java.util.List"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.DirectDesktopInvocation"%>
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
				<h2>Firma biométrica usando llamada a Viafirma Desktop por protocolo (requiere Javascript)</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Firma biométrica con Viafirma Desktop</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma biométrica de un documento utilizando Javascript para la invocación a Viafirma Desktop por protocolo. Requiere código Javascript local.</p>
						
								<%
									
									if (request.getParameter("doSign") != null) {
									 	// This is just a sample; your app would start with something like this:
										ConfigureUtil.initViafirmaClient();										
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
									    // Now use the new prepareBiometricSignatureForDirectDesktop method
									    // 1.- A single PDF File to be signed, as an OperationFile (base64 and filename) instance - mandatory
									    // 2.- Policy object - mandatory
									    
									    // Policy (mandatory) - exactly the same as the 1st digitalized signature example
										Policy policy = new Policy();
										policy.setTypeSign(TypeSign.ATTACHED);
										policy.setTypeFormatSign(TypeFormatSign.DIGITALIZED_SIGN);

										//Indica el color de fondo de la pantalla
// 										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BACK_COLOUR.getKey(), "#0000FF");
										//Indica el color de la firma de la pantalla
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_COLOUR.getKey(), "#FF0000");
										//Indica el texto de ayuda que aparece en la pantalla 
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_HELP_TEXT.getKey(), "Texto de ayuda aportado por el integrador");
										//Logo a mostrar
// 										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_LOGO.getKey(), logoStamp);
										//Rectangulo donde se fija la firma
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_RECTANGLE.getKey(), new Rectangle(400,60,160,120));
										//Biometric alias - pass son utilizados para firmar los datos biometricos en servidor (el alias debe existir en el servidor) 
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BIOMETRIC_ALIAS.getKey(), "xnoccio");
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BIOMETRIC_PASS.getKey(), "12345");
									    //Clave publica en formato pem con la que cifrar los datos biometricos, si no se indica no se cifran
									    String pem = IOUtils.toString(this.getClass().getResourceAsStream("/xnoccio.pem"));
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BIOMETRIC_CRYPTO_PEM.getKey(), pem);
									    //Pagina donde insertar la firma, -1 para la ultima pagina, si no se indica, en iOS se permitirá seleccionar la pagina/s manualmente, en Topaz se pondrá en la última página
									    //policy.addParameter(PolicyParams.DIGITALIZED_SIGN_PAGE.getKey(), -1); 
									    
									    //Server signature params
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_ALIAS.getKey(), "xnoccio");
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_PASS.getKey(), "12345");
										
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGNATURE_INFO.getKey(), "Firmante de ejemplo");

										
										// Files to be signed
										byte[] documentBinaryContent = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));	
										OperationFile file = new OperationFile();
										file.setFilename("exampleSign.pdf");
										file.setBase64Content(Base64.encodeBase64String(documentBinaryContent));
										file.setPolicy(policy);
										
									    
									    // The method returns an object with the information required to:
									    // a) Create a button that opens Viafirma Desktop by protocol
									    // b) Gets the just-prepared operation ID to start polling using Javascriot
									    DirectDesktopInvocation directCall = viafirmaClient.prepareBiometricSignatureForDirectDesktop(file, request);
									    String operationId = directCall.getOperationId();
									    String viafirmaDesktopLink = directCall.getViafirmaDesktopInvocationLink();
							    %>
							    
                                <script src="<%=ConfigureUtil.getViafirmaServerPublicWS() %>/viafirma.js?t=<%=System.currentTimeMillis()%>">
                             		// Include this remote Javascript is mandatory, it includes the polling logic
                                </script>
                                <script>
                                // Customize this in your own client webapp... this is just a sample!
                                // When the polling detects an error, it invokes this function
                                function showError(response) {
                                	   document.getElementById("loading").style = "display: none;";
                                	   document.getElementById("signatureError").innerHTML = "Ocurrió un problema durante la firma: "+ JSON.stringify(response);
                                }
                             	// If the user cancels the operation in Viafirma Desktop app, this function is invoked
                                function showCancel(response) {
                                	   document.getElementById("loading").style = "display: none;";
                                	   document.getElementById("signatureCancel").innerHTML = "La firma fue cancelada: "+ JSON.stringify(response);
                                }
                             	// If the signature operation runs ok, this function is invoked - customize it with your own logic 
                                function showSuccess(response) {
                                	window.location.replace("./exampleSignatureViafirmaDesktopResult.jsp?operationId=" + response.operationId);
                                }
                             	// If Viafirma Desktop is not loaded, this function is invoked
                                function showUnloaded() {
                             		alert("Viafirma Desktop no encontrado");
                                 	document.getElementById("loading").style = "display: none;";
                                    
                                  	document.getElementById("signatureSuccess").innerHTML = 
                                	  "<p><strong>Viafirma Desktop no ha sido cargado, aquí se puede incluir código para gestionar la descarga, instalación, instrucciones, etc.</strong></p>";
                                }
                                // Here we initialize the viafirma.js polling 
                                function initSignature() {
                                	   document.getElementById("signatureButton").style = "display: none;";
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
                                		   unloadedTime: 30,
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
                                <p id="signatureError"></p>
                                <p id="signatureCancel"></p>
                                <p id="signatureSuccess"></p>
                                <p id="loading"></p>
                                <p id="signatureButton">
                                    <a class="button" href="<%=viafirmaDesktopLink%>" onclick="initSignature();">Firma biométrica con Viafirma Desktop</a>
                                </p>
                                <%  
									} else {
								%>
                                <p>
                                    <a class="button" href="?doSign=true">Iniciar ejemplo de proceso de firma de firma biométrica</a>
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
									<li><code>prepareBiometricSignatureForDirectDesktop</code></li>
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
