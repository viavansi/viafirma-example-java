<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="java.awt.Rectangle"%>
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
				<h2>Método <code>prepareFirmaPDFWithImageStamp</code></h2>
				
				<p>Para poder firmar un documento, primero se debe enviar el fichero que deseamos firmar.</p> 
				<p>El método <code>prepareFirmaPDFWithImageStamp</code> prepara el archivo a firmar en pdf con la imagen de firma 
				y devuelve un identificador temporal que estará disponible durante 10 minutos, que permitirá referenciar al archivo
				durante el proceso de firma.</p>
				<p>Al método se le ha de pasar uno de estos parametros: <code>campo</code> o <code>rectangle</code>.</p>
				<p>Si se ha delimitado en el PDF una zona para la firma se le pasara la cadena que la identifique, en caso contrario se le pasará un objeto java.awt.Rectangle donde se incluira la imagen de firma.</p>
				
				<p>
					Recibe como paramentro:
				</p>
				<ul class="parameters">
					<li><code>String nombreFile</code> Titulo del fichero</li>
					<li><code>byte[] pdf</code> Byte array de los datos del fichero</li>
				    <li><code>String campo</code> Identificador de la zona definida [Opcion 1]</li>
				    <li><code>Rectangle rectangle</code> Rectangulo que indica el tamaño de la firma [Opcion 2]</li>
				    <li><code>byte[] imagen</code> Byte array de la imagen que se usará de firma</li>
			    </ul>
			    
			    <p>Devuelve:<p>
			    <ul class="parameters">
			    	<li><code>String</code> Identificador temporal del documento</li>
			    </ul>
		    
		      <!-- 
				<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
				
					<%
					if(request.getParameter("campo")!=null){
						/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
						String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
						String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
						ConfigureUtil.initViafirmaClient();
						String idFirma=null;
						int size=0;
						try{
						    byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));	
						    byte[] imageByte=IOUtils.toByteArray(this.getClass().getResourceAsStream("/firma.png"));
								
							idFirma=ViafirmaClientFactory.getInstance().prepareFirmaPDFWithImageStamp("test.pdf",datosAFirmar, "Campo firma",imageByte);
		
						}catch(InternalException e){
							e.printStackTrace();
							%>
							<p>No se puede preparar la firma.<%=e.getMessage() %></p>
							<% 
						}
					%>
				<div style="text-align:center;height:100px;">
					<p>Id de firma generado es:<%=idFirma%>.</p>
				</div>
				<% } %>
				<%
					if(request.getParameter("rectangulo")!=null){
						/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
						String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
						String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
						ConfigureUtil.initViafirmaClient();
						String idFirma=null;
						int size=0;
						try{
								byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
								byte [] imageByte=IOUtils.toByteArray(this.getClass().getResourceAsStream("/firma.png"));
								
								idFirma=ViafirmaClientFactory.getInstance().prepareFirmaPDFWithImageStamp("test.pdf",datosAFirmar, new Rectangle(100, 100,300, 200),imageByte);
		
						}catch(InternalException e){
							e.printStackTrace();
							%>
							<p>No se puede preparar la firma.<%=e.getMessage() %></p>
							<% 
						}
					%>
				<div style="text-align:center;height:100px;">
					<p>Id de firma generado es:<%=idFirma%>.</p>
				</div>
				<% } %>
				<p><a href="?campo">Preparar firma de documento PDF con imagen de sello y ¿campo?</a></p>
				<p><a href="?rectangulo">Preparar firma de documento PDF con imagen de sello y rectangulo</a></p>
				 -->
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