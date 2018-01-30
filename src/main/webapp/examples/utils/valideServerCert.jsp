<%@page import="com.viafirma.client.verify.CertificateResponse"%>
<%@page import="com.viafirma.client.verify.SignatureVerification.SignatureStatus"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<h2>Comprobación de validez de certificador servidor</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
					<%
					if(request.getParameter("aliasCert")==null){
					%>
						<div class="box">
							<h3 class="box-title">Verificar que el certificado sea válido</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la comprobación de un certificado si es válido, está caducado o revocado. Este certificado se encuentra alojado en el caert del servidor.</p>
								<form action="?validateCert">
									<p>
										Alias del certificado:    
										<input style="width: 100%"type="text" value="" name="aliasCert">
									</p>
									<input type="submit" class="enlaceFakeButton" value="Verificar certificado">
								</form>
							</div>
						</div>
					<%
					}else{
					
						
						String alias= (String)request.getParameter("aliasCert");
						//Ejecutamos el método de validación y obtenemos la información de la misma
						        
					            ConfigureUtil.initViafirmaClient();
						        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					            
						        try{
						            CertificateResponse certificateResponse = viafirmaClient.verifyCertificateByAlias(alias);
						        
					    
					%>
					<div class="box">
						<h2 class="box-title">Estado</h2>
						<div class="box-content">
							<p>
								<strong>Estado del certificado: </strong><%=certificateResponse.getCertificateStatus().name()%><br/>
							<p>
						</div>
					</div>
					<div class="box">
						<h2 class="box-title">

							</h2>
						<div class="box-content">
							<p>
								<strong>Nif: </strong><%=certificateResponse.getNumberUserId()%>
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
								<strong>Estado: </strong><%=certificateResponse.getCertificateStatus().name()%>
							</p>
								<strong>Propiedades: </strong>
								<ul>
								<%
								Map<String,String> map = certificateResponse.getProperties();
								if(map!=null){
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
						}catch (Exception e){
							%>
							<div class="box">
								<h2 class="box-title">Error</h2>
								<div class="box-content">
									 <p><%=e.getMessage() %></p>
									 <p>Asegúrese de que ha introducido un certificado válido.</p>
								</div>
							</div>
						    <%     
						}

					    }
					%>
<!-- 					<p> -->
<!-- 						<a class="button" target="_blank" href="../../utils/downloads.jsp" -->
<!-- 											title="Descargar documento">Descargar documento</a> -->
<!-- 					</p> -->
				</div>

				<div class="col width-40">
					<div class="box">
						<h3 class="box-title">Métodos utilizados</h3>
						<div class="box-content">
							<ul>
								<li><code>verifyCertificate</code></li>
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
				<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
			</p>
		</div>
	</div>
</body>
</html>