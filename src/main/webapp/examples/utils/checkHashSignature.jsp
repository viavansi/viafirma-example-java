<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.viafirma.client.vo.validation.ValidationInfo"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
				<h2>Verificación de un documento firmado</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Verificar la firma de un documento firmado en HASH</h3>
							<div class="box-content">
								<form action="#" method="post" enctype="multipart/form-data">
									<p>Adjunta el documento firmado o indica su ID de firma</p>
									<p><input type="file" name="signed" size="50" /></p>
									<p>ID del documento firmado</p>
									<p><input type="text" name="id" /></p>
									<p>Introduce el hash del documento original</p>
									<p><input type="text" name="hash" /></p>
									<p>Selecciona el formato de firma</p>
									<p><select name="signatureType">
									<%
										for(TypeFormatSign formatSign:TypeFormatSign.values()){
											%><option value="<%=formatSign.getCode()%>"><%=formatSign.getName()%></option><%
										}
									%>
									</select> </p>
									<p><input type="submit" value="Validar documento" /></p>
								</form>
							</div>
						</div>
<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");

   // Verify the content type
   String contentType = request.getContentType();
   if (contentType!=null && contentType.indexOf("multipart/form-data") >= 0) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
         // Parse the request to get file items.
         Map<String,List<FileItem>> fileItems = upload.parseParameterMap(request);
        //for(List<FileItem> item:fileItems.values()){
        //	out.print("<br/>**ListSize="+item.size());
        //	out.print("<br/>**FirstItem="+item.get(0));
        //}
        FileItem signatureFileitem=fileItems.get("signed").get(0);
        byte[] signedDocument=IOUtils.toByteArray(signatureFileitem.getInputStream());
        
        FileItem hashFileitem=fileItems.get("hash").get(0);
        String hash=hashFileitem.getString();
        FileItem signatureTyeFileItem=fileItems.get("signatureType").get(0);
        System.out.println(new String(signatureFileitem.get()));
        TypeFormatSign formatSign=TypeFormatSign.getByCode(new String(signatureTyeFileItem.get()).charAt(0));
        String id=fileItems.get("id").get(0).getString();
        //out.print("<br/>**SignatureType="+formatSign.getName());
        //out.print("<br/>**Signature="+Base64.encodeBase64String(signedDocument));
        //out.print("<br/>**Hash="+hash);
        FirmaInfoViafirma firmaInfoViafirma=null;
        if(hash!=null && !StringUtils.isEmpty(hash) && ((id!=null && !StringUtils.isEmpty(id)) || hashFileitem.getSize()>1)){
        	if(id!=null && !StringUtils.isEmpty(id)){
        		firmaInfoViafirma=ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidityById(id, hash, formatSign);
        	}else{
        		firmaInfoViafirma=ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidity(signedDocument, hash, formatSign);
        	}
        }
        if(firmaInfoViafirma!=null){
        	if(firmaInfoViafirma.getValid()){
        		out.println("Documento validado correctamente.");
        		ValidationInfo validationInfo=ViafirmaClientFactory.getInstance().checkCertificate(Base64.decodeBase64(firmaInfoViafirma.getProperties().get("pem").getBytes()));
        		out.println(validationInfo.getValidationResponse().isExpired());
        		out.println(validationInfo.getValidationResponse().isValidated());
        		out.println(validationInfo.getValidationResponse().getRevocationDate());
        	}else{
        		out.println("Documento invalido.");
        		out.println(firmaInfoViafirma.getProperties());
        	}
        }
        	
        
   }
        
        
%>

					</div>
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Metodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
									<li>getDocumentoCustodiado</li>
									<li>checkSignedDetachedDocumentValidity</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Volver</a></p>
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