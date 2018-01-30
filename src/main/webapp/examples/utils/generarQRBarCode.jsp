<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%> 
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
				<h2>Metodos de utilidad</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Generar Resguardo con QRBarCode</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento y se recupera el resguardo de la firma con codigo de seguimiento QR.</p>
						
								<p>
									<a class="button" href="?QRB">Generar resguardo QRB</a>
								</p>
								<%
								if(request.getParameter("QRB")!=null){
							
									ConfigureUtil.initViafirmaClient();
									String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
									String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
									ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
									
									try{
									// Firmamos un documento para poder recuperar despues su codigo QR
									byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
									
									Policy policy = new Policy();
									TypeFormatSign format = TypeFormatSign.CMS;
									    
									policy.setTypeFormatSign(format);
									policy.setTypeSign(TypeSign.ENVELOPED);

									Documento documento = new Documento("firma_QRB.xml", datosAFirmar, TypeFile.XML, format); 
									String codFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
									
									
									// Recuperamos el codigo de la firma realizada
									byte[] resguardo = viafirmaClient.buildInfoQRBarCode(codFirma);
									
									// Preparamos el codigo recibido para ser descargado
									response.setContentType("image/png;");
									response.setHeader("Content-Disposition","attachment;filename=\""+codFirma+".png\";");
									response.setContentLength(resguardo.length);
									javax.servlet.ServletOutputStream servletoutputstream = response.getOutputStream();
									servletoutputstream.write(resguardo);
									servletoutputstream.flush();
									servletoutputstream.close();
									}catch(InternalException e){
										if(e.getCause().toString().contains("ExcepcionDatosNoEncontrados")){
											%><p class="message error">Invalid ID</p><% 
										}else{
											out.append(e.getMessage());
										}
									}
								}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>signByServerWithPolicy</code></li>
									<li><code>buildInfoQRBarCode</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Volver</a></p>
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