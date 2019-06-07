<%@page import="org.viafirma.cliente.rest.desktop.direct.model.SignatureOperationRequest"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.util.LinkedList"%>
<%@page import="org.viafirma.cliente.rest.desktop.direct.model.OperationFile"%>
<%@page import="java.util.List"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
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
				<h2>Firmar usando llamada a Viafirma Desktop por protocolo (requiere Javascript)</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Firma con Viafirma Desktop</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento utilizando Javascript para la invocación a Viafirma Desktop por protocolo. Requiere código Javascript local.</p>
						
								<%
									
									if (request.getParameter("doSign") != null) {
									 	// This is just a sample; your app would start with something like this:
										ConfigureUtil.initViafirmaClient();										
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
									    // Now use the new prepareSignatureForDirectDesktop method
									    // The method requires:
									    // 1.- An AuthOperationRequest object (includes logic to filter certificates, autosend, etc.) - optional (can be null)
									    // 2.- Files to be signed, in a list of OperationFile (base64 and filename) - mandatory
									    // 3.- Policy object - mandatory
									    AuthOperationRequest authRequest = new AuthOperationRequest();
									    // For instance...
									    authRequest.setAutoSend(true);
									    authRequest.setSessionId(request.getSession().getId());
									    
									    // Policy (mandatory)
									    Policy policy = new Policy();
										policy.setTypeFormatSign(TypeFormatSign.PAdES_BASIC);
										policy.setTypeSign(TypeSign.ATTACHED);
										policy.addParameter(PolicyParams.DIGITAL_SIGN_PAGE.getKey(), "1");
										policy.addParameter(PolicyParams.DIGITAL_SIGN_RECTANGLE.getKey(), new org.viafirma.cliente.vo.Rectangle(40,10,550,75));
										policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_HIDE_STATUS.getKey(), "true");
										policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_TYPE.getKey(), "QR-BAR-H");
										policy.addParameter(PolicyParams.DIGITAL_SIGN_REASON.getKey(), "Example Sign");
										policy.addParameter(PolicyParams.DIGITAL_SIGN_CONTACT.getKey(), "Contact Person Name");
										policy.addParameter(PolicyParams.DIGITAL_SIGN_LOCATION.getKey(), "Tomares");
										
										// Files to be signed
										byte[] documentBinaryContent = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));	
										List<OperationFile> files = new LinkedList<OperationFile>();
										OperationFile file = new OperationFile();
										file.setFilename("exampleSign.pdf");
										file.setBase64Content(Base64.encodeBase64String(documentBinaryContent));
										file.setPolicy(policy);
										
										files.add(file);
										
										documentBinaryContent = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSigned.pdf"));
										file = new OperationFile();
										file.setFilename("exampleSigned.pdf");
										file.setBase64Content(Base64.encodeBase64String(documentBinaryContent));
										Policy policy2 = new Policy();
										policy2.setTypeFormatSign(TypeFormatSign.PAdES_BASIC);
										policy2.setTypeSign(TypeSign.ATTACHED);
										policy2.addParameter(PolicyParams.DIGITAL_SIGN_PAGE.getKey(), "1");
										policy2.addParameter(PolicyParams.DIGITAL_SIGN_RECTANGLE.getKey(), new org.viafirma.cliente.vo.Rectangle(520,250,420,75));
										policy2.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_HIDE_STATUS.getKey(), "true");
										policy2.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_TEXT.getKey(), "Firmado por [CN] con DNI [SERIALNUMBER]\ntrabajador de [O] en el departamento de [OU]");
										policy2.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_TYPE.getKey(), "QR-BAR-H");
										policy2.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_ROTATION_ANGLE.getKey(), "90");
										file.setPolicy(policy2);
										
										files.add(file);
									    
									    // The method returns an object with the information required to:
									    // a) Create a button that opens Viafirma Desktop by protocol
									    // b) Gets the just-prepared operation ID to start polling using Javascriot
									    DirectDesktopInvocation directCall = viafirmaClient.prepareSignatureForDirectDesktop(authRequest, files, request);
									    String operationId = directCall.getOperationId();
									    String viafirmaDesktopLink = directCall.getViafirmaDesktopInvocationLink();
									    String viafirmaDesktopAlternateLink=viafirmaDesktopLink.replace("viafirmawpfclient","viafirmadesktop");
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
                             	// For instance, probably you will need to invoke an internal REST service that receives the signature response object
                                function showSuccess(response) {
                                	document.getElementById("loading").style = "display: none;";
                                    
                                    document.getElementById("signatureSuccess").innerHTML = "<p>Operación de firma realizada con éxito. Información obtenida:</p><ul>"+
                                    	   "<li><strong>ID de operación</strong>: "+ response.operationId +"</li>"+
                                    	   "<li><strong>Identificación usuario</strong>: "+ response.certificateValidationData.numberUserId +"</li>"+
                                    	   "<li><strong>Usuario</strong>: "+ response.certificateValidationData.name +" "+ response.certificateValidationData.surname1 +" "+ response.certificateValidationData.surname2 +"</li>"+
                                    	   "<li><strong>CA</strong>: "+ response.certificateValidationData.shortCa +"</li>"+
                                    	   "<li><strong>ID Firma</strong>: "+ response.signatureId +"</li>"+
                                    	    "</ul>";
                                }
                                // Here we initialize the viafirma.js polling 
                                function initSignature() {
                                	   document.getElementById("signatureButton").style = "display: none;";
                                	   document.getElementById("loading").innerHTML = "<img src='../images/icons/ajax-loader.gif' />";
                                	   
                                	   // Start the viafirma JS client: watch the status of a given operationId
                                	   // - if the operation fails, "errorCallback" will be called
                                	   // - if the operation is cancelled, "cancelCallback" will be called
                                	   // - if the operation is completed: "successCallback" will be called
                                	   viafirma.init({
                                		   // Here we include 
                                		   operationId: "<%=operationId%>",
                                		   viafirmaUrl: "<%=ConfigureUtil.getViafirmaServerPublicWS() %>/",
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
                                <p id="signatureError"></p>
                                <p id="signatureCancel"></p>
                                <p id="signatureSuccess"></p>
                                <p id="loading"></p>
                                <p id="signatureButton">
                                    <a class="button" href="<%=viafirmaDesktopLink%>" onclick="initSignature();">Firmar con Viafirma Desktop (viafirmawpfclient)</a>
                                    
                                </p>
                                <%  
									} else {
								%>
                                <p>
                                    <a class="button" href="?doSign=true">Iniciar ejemplo de proceso de firma</a>
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
									<li><code>prepareSignatureForDirectDesktop</code></li>
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