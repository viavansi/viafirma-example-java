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
				<h2>Firmas sin intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Firma PDF con sello</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma con sello de un documento PDF con formato PDF Signature en el servidor sin la intervención directa del usuario.</p>
								
								<p>
									<a class="button" href="?firmarPDFConSello">Firma de PDF con imagen de sello en formato PDF Signature</a>
								</p>
								<p class="button">
									<a href="?firmarPDFConSelloAtField">Firma de PDF en formato PDF Signature con imagen de sello en un campo de formulario dado</a>
								</p>
							</div>
						</div>
								<%
									ConfigureUtil.initViafirmaClient();
									final String alias=ConfigureUtil.CERTALIAS;//Alias del certificado utilizado
									final String pass=ConfigureUtil.CERTPASS;//Pass del certificado utilizado.
									String tipoFirma=null;
									
									if (request.getParameter("firmarPDFConSello") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory
												.getInstance();
										// Preparamos un rectangulo para albergar la imagen de la firma
// 										java.awt.Rectangle position=new java.awt.Rectangle(120,50,300,150);
										java.awt.Rectangle position=new java.awt.Rectangle(500,125,75,75);
										
										// Datos imagen de firma 
										byte [] imageStamp=IOUtils.toByteArray(this.getClass().getResourceAsStream("/logoStamp.jpg"));
										// Datos a firmar
										byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										tipoFirma="Firma en formato XAdES con imagen de un archivo PDF";
										// Iniciamos la firma en el servidor
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
													try{
														String idFirma=viafirmaClient.signByServerPDFWithImageStamp("exampleSign.pdf",datosAFirmar,alias,pass,position,imageStamp);	
														%>
<%-- 														<strong>Tipo de firma:</strong><%=tipoFirma %><br/> --%>
														<strong>Id de firma:</strong><%=idFirma%><br/>
														<p>
															<a class="button" target="_blank" href="../../utils/downloads.jsp?firmado&id=<%=idFirma%>" title="Descargar documento firmado">Descargar documento firmado</a>
														</p>
													<%}catch(Exception e){
														%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
													<%}%>
												</p>
											</div>
										</div>
										<%	}
									else if (request.getParameter("firmarPDFConSelloAtField") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory
												.getInstance();
										// Preparamos un rectangulo para albergar la imagen de la firma
										java.awt.Rectangle position=new java.awt.Rectangle(120,50,300,150);
										// Datos imagen de firma 
										byte [] imageStamp=IOUtils.toByteArray(this.getClass().getResourceAsStream("/logoStamp.jpg"));
										// Datos a firmar
										byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/form_campoFirma.pdf"));
										tipoFirma="Firma en formato XAdES con imagen de un archivo PDF";
										// Iniciamos la firma en el servidor
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
													try{
														String idFirma=viafirmaClient.signByServerPDFWithImageStamp("exampleSign.pdf",datosAFirmar,alias,pass,"campoFirma",imageStamp);	
														%>
<%-- 														<strong>Tipo de firma:</strong><%=tipoFirma %><br/> --%>
														<strong>Id de firma:</strong><%=idFirma%><br/>
														<p>
															<a class="button" target="_blank" href="../../utils/downloads.jsp?firmado&id=<%=idFirma%>" title="Descargar documento firmado">Descargar documento firmado</a>
														</p>
													<%}catch(Exception e){
														%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
													<%}%>
												</p>
											</div>
										</div>
										<%	} %>
					</div>
					
					<div class="col width-35">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>signByServerPDFWithImageStamp</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<p>
					<a href="../firmaServer.jsp">&larr; Volver</a>
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