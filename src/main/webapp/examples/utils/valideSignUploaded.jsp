<%@page import="com.viafirma.client.verify.CertificateResponse"%>
<%@page import="com.viafirma.client.verify.SignatureVerification.SignatureStatus"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%@ page import="com.viafirma.client.verify.SignatureVerification" %>
<%@ page import="com.viafirma.client.verify.VerificationSignatureRequest" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Viafirma - Kit para desarrolladores</title>

<link rel="stylesheet" href="../../css/framework.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="../../css/styles.css" type="text/css"
	media="screen" />
</head>
<body>
	<div id="wrapper">
		<h1 id="header">
			<a href="../../"><img src="../../images/content/logo.png"
				alt="Viafirma" /></a>
		</h1>

		<div id="content">
			<h2>Comprobación de validez de firma en un documento aportado
				por el usuario</h2>

			<div class="group">
				<div class="col width-58 append-02">
					<div class="box">
						<h3 class="box-title">Validar firma</h3>

						<div class="box-content">
							<p>En este ejemplo se sube un documento firmado para
								posteriormente comprobar que la firma es valida.</p>

							<form action="#" method="post" enctype="multipart/form-data">
								<p>Adjunta el documento firmado</p>
								<p>
									<input type="file" name="signed" size="50" />
								</p>
								<p>Selecciona el tipo de firma<br/>
									<p>
									  <input type="radio" name="signatureStandard" value="<%=VerificationSignatureRequest.SignatureStandard.PADES.name()%>" checked="checked"> 
									  <%=VerificationSignatureRequest.SignatureStandard.PADES.name()%>
									  
									  <input type="radio" name="signatureStandard" value="<%=VerificationSignatureRequest.SignatureStandard.XADES.name()%>"> 
									  <%=VerificationSignatureRequest.SignatureStandard.XADES.name()%>
									  
									  <input type="radio" name="signatureStandard" value="<%=VerificationSignatureRequest.SignatureStandard.CADES.name()%>"> 
									  <%=VerificationSignatureRequest.SignatureStandard.CADES.name()%>
									 </p>
								<p>
									<input type="submit" value="Validar documento" />
								</p>
							</form>

						</div>
					</div>
					<%
					    File file;
					    int maxFileSize = 50000 * 1024;
					    int maxMemSize = 50000 * 1024;
					    ServletContext context = pageContext.getServletContext();
					    String filePath = context.getInitParameter("file-upload");

					    // Verify the content type
					    String contentType = request.getContentType();
					    if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {

					        DiskFileItemFactory factory = new DiskFileItemFactory();
					        // maximum size that will be stored in memory
					        factory.setSizeThreshold(maxMemSize);
					        // Location to save data that is larger than maxMemSize.
					        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

					        // Create a new file upload handler
					        ServletFileUpload upload = new ServletFileUpload(factory);
					        // maximum file size to be uploaded.
					        upload.setSizeMax(maxFileSize);
					        // Parse the request to get file items.
					        Map<String, List<FileItem>> fileItems = upload.parseParameterMap(request);

					        FileItem signatureFileitem = fileItems.get("signed").get(0);
					        byte[] signedDocument = IOUtils.toByteArray(signatureFileitem.getInputStream());
					        if(signedDocument.length>0){
						        
						        // Instaciamos la clase encargada de añadir los parámetros
					            VerificationSignatureRequest verificationSignatureRequest = new VerificationSignatureRequest();
						        
					            // SignatureStandard
					            String signatureStandardKey = VerificationSignatureRequest.ParameterKey.SIGNATURE_STANDARD.name();
					            String signatureStandardValue = fileItems.get("signatureStandard").get(0).getString(); 
					            // Añadimos el parámetro SignatureStandard
					            verificationSignatureRequest.addParameter(signatureStandardKey, signatureStandardValue);
	
					            // TypeSign
					            String typeSignKey = VerificationSignatureRequest.ParameterKey.TYPE_SIGN.name();
					            String typeSignValue = VerificationSignatureRequest.TypeSign.ENVELOPED.name();
					            // Añadimos el parámetro TypeSign
					            verificationSignatureRequest.addParameter(typeSignKey, typeSignValue);
	
					            // Añado el documento firmado
					            verificationSignatureRequest.setSignedDocument(signedDocument);
	
					            ConfigureUtil.initViafirmaClient();
						        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					            
						    	List<SignatureVerification> signatureVerificationList = viafirmaClient.verifySignature(verificationSignatureRequest);
	
						    	SignatureStatus signatureStatus = SignatureStatus.INVALID;
					            for (SignatureVerification signatureVerification : signatureVerificationList) {
					           		signatureStatus = signatureVerification.getSignatureStatus();
					           		if(SignatureStatus.INDETERMINATE.equals(signatureStatus) || SignatureStatus.INVALID.equals(signatureStatus)){
					           		    break;
					           		}
					            }

					    
					%>
					<div class="box">
						<h2 class="box-title">Estado</h2>
						<div class="box-content">
							<p>
								<strong>Estado de la firma: </strong><%=signatureStatus.name()%><br/>
							<p>
						</div>
					</div>
					<%
					 int i = 1;
					 for (SignatureVerification signatureVerification : signatureVerificationList) {
					%>
					<div class="box">
						<h2 class="box-title">
							Firma
							<%=i %>:
							<%CertificateResponse certificateResponse = signatureVerification.getCertificateResponseList().get(0);%>
							<%=certificateResponse.getNumberUserId() +" - "+signatureVerification.getSignatureStatus()%>
							</h2>
						<div class="box-content">
							<p>
								<strong>Fecha firma: </strong><%=signatureVerification.getSignTimeStamp()%></p>
							<p>
								<strong>Formato de firma: </strong><%=signatureVerification.getSignatureFormat()%></p>
							<p>
								<strong>NIF: </strong><%=certificateResponse.getNumberUserId()%>
							</p>
							<p>
								<strong>Nombre: </strong><%=certificateResponse.getFirstName()%>
							</p>
							<p>
								<strong>Apellido: </strong><%=certificateResponse.getLastName()%>
							</p>
							<p>
								<strong>Email: </strong><%=certificateResponse.getEmail()%>
							</p>
							<p>
								<strong>Tipo de cetificado: </strong><%=certificateResponse.getTypeCertificate()%>
							</p>
							<p>
								<strong>Tipo Legal: </strong><%=certificateResponse.getTypeLegal()%>
							</p>
							<p>
								<strong>Autoridad de certificación: </strong><%=certificateResponse.getCaName()%>
							</p>
							<p>
							<p>
								<strong>Mensaje: </strong><%=certificateResponse.getMessage()%>
							</p>
							<p>
								<strong>Estado: </strong><%=signatureVerification.getSignatureStatus()%>
							</p>
								<strong>Propiedades: </strong>
								<ul>
								<%
								Map<String,String> map = certificateResponse.getProperties();
								if (map != null) {
									for (Map.Entry<String, String> entry : map.entrySet())
									{
									    %>
									    	<li><strong><%=entry.getKey()%>: </strong><%=entry.getValue()%></li>
									    <%
									}
								}
								%>
								</ul>
							</p>
						</div>
					</div>
					<%
					 		i++;}
					    }
					%>
<!-- 					<p> -->
<!-- 						<a class="button" target="_blank" href="../../utils/downloads.jsp" -->
<!-- 											title="Descargar documento">Descargar documento</a> -->
<!-- 					</p> -->
					<%
					    }
					%>
				</div>

				<div class="col width-40">
					<div class="box">
						<h3 class="box-title">Métodos utilizados</h3>
						<div class="box-content">
							<ul>
								<li><code>verifySignature</code></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<p>
				<a href="../../index.jsp">&larr; Volver</a>
			</p>
		</div>
		<div id="footer">
			<p class="left">
				Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte
				más información técnica en <a href="http://developers.viafirma.com/">Viafirma
					Developers</a>
			</p>
			<p>
				<small>3.0.0</small>
			</p>
		</div>
	</div>
</body>
</html>