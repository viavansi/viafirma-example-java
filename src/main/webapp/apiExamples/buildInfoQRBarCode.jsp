<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%><%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>

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
				<h2>Método <code>buildInfoQRBarCode</code></h2>
				
				<p>El método <code>buildInfoQRBarCode</code> recupera el resguardo del documento que ya debe haber sido firmado y custodiado con Viafirma.</p>
				
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
			 		<li><code>Strign codFirma</code> Codigo del documento ya firmado</li>
			 	</ul>
			 	
			 	<p>Devuelve:</p>
			 	<ul class="parameters">
			 		<li><code>byte[]</code> Byte array de la imagen png con el código de barras y QR code del documento custodiado</li>
				</ul>
				
				<div style="text-align:left;">
					<a href="./">&larr; Volver</a>
				</div>
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
		<%
		if(request.getParameter("QRB")!=null){
		// Recupera el resguardo del documento que ya debe haber sido firmado y custodiado con Viafirma.
		// Si no ha firmado este documento con Viafirma, acceda a viafirma y firme el documento, una vez firmado obtendra un identificador
		// de firma que podra utilizar en este ejemplo para validar el funcionamiento del método buildInfoQRBarCode.
		
		// Enviamos a Viafirma el identificador de firma generado al firmar un documento para que viafirma
		// devuelva el resguardo de la firma
		ConfigureUtil.initViafirmaClient();
		
		String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
		String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		// Decargamos el resguardo de un cod válido.
		try{
		byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
		String codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign("firma_QRB.txt",datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.CMS);
		
		byte[] resguardo = viafirmaClient.buildInfoQRBarCode(codFirma);
	
		response.setContentType("image/png;");
		response.setHeader("Content-Disposition","attachment;filename=\""+codFirma+".png\";");
		response.setContentLength(resguardo.length);
		javax.servlet.ServletOutputStream servletoutputstream = response.getOutputStream();
		servletoutputstream.write(resguardo);
		servletoutputstream.flush();
		servletoutputstream.close();
		}catch(InternalException e){
			if(e.getCause().toString().contains("ExcepcionDatosNoEncontrados")){
				%><p>Invalid ID</p><% 
			}else{
				out.append(e.getMessage());
			}
		}
		}
	%>