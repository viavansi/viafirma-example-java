<%@page import="org.apache.xml.security.utils.Base64"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%-- <%@page import="org.viafirma.cliente.firma.TypeSign"%> --%>
<%-- <%@page import="org.viafirma.cliente.firma.Policy"%> --%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Firma XML</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza el sellado de tiempo de un documento XML en el servidor.</p>
								<p>Para su correcto funcionamiento la TSA debe estar correctamente indicada.</p>
								<p class="button">
									<a href="?timestamp">Timestamping del documento XML</a>
								</p>
							</div>
						</div>
						<%
						if (request.getParameter("timestamp") != null) {
							ConfigureUtil.initViafirmaClient();
							final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
							final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
							String tipoFirma=null;
							tipoFirma="Firma en formato XAdES de un archivo XML";
										 
							// Datos documento a sellar
							byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										
						%>
							<div class="box">
								<h2 class="box-title">Ejemplo</h2> 
								<div class="box-content">
									<p>
									<%
									try{
										byte[] datosSellados = ViafirmaClientFactory.getInstance().tsaRequest(datosAFirmar);
										String selloB64 = Base64.encode(datosSellados);
									%>
										<a href="../descargar.jsp?selloB64=<%=selloB64%>">Descargar fichero del sello en Base64</a>
									<%
									}catch(Exception e){ %>
										<strong>Se ha poducido un error en el sellado:</strong><%=e.getMessage()%><br/>
								  <%}%>
									</p>
								</div>
							</div>
						<%}%>
					</div>
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>tsaRequest</li>
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
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>