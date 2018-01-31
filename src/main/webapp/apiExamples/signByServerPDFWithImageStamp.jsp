<%@page import="javax.imageio.ImageIO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.Rectangle"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
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
			<h1 id="header"><a href="."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Método <code>signByServerPDFWithImageStamp</code></h2>
				
				<p>Este metodo <code>signByServerPDFWithImageStamp</code> firma en PDF automaticamente en servidor un documento con una imagen.</p>
				
				<p>Recibe como paramentro:</p>
				<ul class="parameters">
					<li><code>String nombreFile</code> Nombre con el que se guardará el documento</li>
					<li><code>byte[] pdf</code> Byte array de los datos del fichero PDF a firmar</li>
					<li><code>String alias</code> Alias del certificado utilizado</li>
				    <li><code>String password</code> Password del certificado utilizado</li>
				    <li><code>String campo</code> Identificador de la zona definida [Opcion 1]</li>
				    <li><code>Rectangle rectangle</code> Rectangulo que indica el tamaño de la firma [Opcion 2]</li>
				    <li><code>byte[] imagen</code> Byte array de la imagen que se usará de firma</li>
			    </ul>
			    
			    <p>Devuelve:<p>
			    <ul class="parameters">
			    	<li><code>String</code> Identificador final de la firma en lote</li>
			    </ul>
			    <p class="note">
			    	<strong>(*)</strong> Para su correcto funcionamiento el certificado debe estar instalado en el servidor 
				</p>
				<%
				if(request.getParameter("PDFImage")!=null){
					/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
				
					ConfigureUtil.initViafirmaClient();
					String idFirma=null;
					int size=0;
					try{
						// Ejemplo de firma en PDF
						byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
						java.awt.Rectangle position=new java.awt.Rectangle(120,50,300,150);
						byte [] imageStamp=IOUtils.toByteArray(this.getClass().getResourceAsStream("/logoStamp.jpg"));
						idFirma=ViafirmaClientFactory.getInstance().signByServerPDFWithImageStamp("exampleSign.pdf",datosAFirmar,alias,pass,position,imageStamp);		
						// La firma se ha realizado, recuperamos el documento custodiado.
						byte [] datos=ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
						size=datos.length;
					}catch(InternalException e){
						e.printStackTrace();
						%>
		<!--					<p>No se puede realizar la firma.<%=e.getMessage() %></p>
						<% 
					}
				%>
				<div style="text-align:center;height:100px;">
					<p>Id de firma generado es:<%=idFirma%>.</p>
					<p>El tamaño del documento firmado es:<%=size%>.</p>
				</div>-->
				<%} %>
				<p>
					<a href="./">&larr; Volver</a>
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