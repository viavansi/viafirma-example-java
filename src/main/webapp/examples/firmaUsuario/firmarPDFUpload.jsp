<%@page import="org.viafirma.cliente.firma.DigestMethod"%>
<%@page import="org.bouncycastle.crypto.Digest"%>
<%@page import="org.viafirma.cliente.firma.SignatureAlgorithm"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="../../"><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmas con intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Firma PDF</h3>
							
							<form action="#" method="post" enctype="multipart/form-data">
								<p>Adjunta el documento a firmar</p>
								<p>
									<input type="file" name="fileToSign" size="50" />
								</p>
								<p>
									<input type="submit" value="Firmar PDF" />
								</p>
							</form>
							 
							<div class="box-content">
								<p>En este se ejemplo realiza la firma en formato PADES-Basic de un documento PDF subido por el usuario.</p>
							
								<%

							    File file;
							    int maxFileSize = 5000 * 1024;
							    int maxMemSize = 5000 * 1024;
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

							        FileItem signatureFileitem = fileItems.get("fileToSign").get(0);

										// Datos documento a firmar
										byte[] datosAFirmar = IOUtils.toByteArray(signatureFileitem.getInputStream());

										ConfigureUtil.initViafirmaClient();
						        		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										//Creamos el documento
										Documento doc = new Documento("DocumentSigned.pdf",datosAFirmar,TypeFile.PDF,TypeFormatSign.PAdES_BASIC);
										
										//Seteamos la politica
										Policy policy = new Policy();
										policy.setTypeFormatSign(TypeFormatSign.PAdES_BASIC);
										policy.setTypeSign(TypeSign.ENVELOPED);
										
										policy.addParameter(PolicyParams.SIGNATURE_ALGORITHM.getKey(), SignatureAlgorithm.SHA256withRSA.name());
										policy.addParameter(PolicyParams.DIGEST_METHOD.getKey(), DigestMethod.SHA256.name());
										
										policy.addParameter(PolicyParams.DIGITAL_SIGN_PAGE.getKey(), "0");
		                                policy.addParameter(PolicyParams.DIGITAL_SIGN_RECTANGLE.getKey(), new org.viafirma.cliente.vo.Rectangle(40,10,550,75));
		                                policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_HIDE_STATUS.getKey(), "true");
		                                policy.addParameter(PolicyParams.DIGITAL_SIGN_REASON.getKey(), "cepto y firmo el trámite en Portafirmas TRAGSA");
		                                policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_TEXT.getKey(), "Firmado digitalmente por\n[CN]\nFecha: [vSignTimeKey(dd/MM/yyyy HH:mm:ss)]");
										
										
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma = viafirmaClient.prepareSignWithPolicy(policy, doc);	
										
										// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
										viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
							    }
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-45">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>prepareFirmaWithTypeFileAndFormatSign</code></li>
									<li><code>Formatos:</code>
										<ul>
											<li>TypeFormatSign.PAdES_BASIC</li>
										</ul>
									</li>
									<li><code>solicitarFirma</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p>
					<a href="../firmaUsuario.jsp">&larr; Volver</a>
				</p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>