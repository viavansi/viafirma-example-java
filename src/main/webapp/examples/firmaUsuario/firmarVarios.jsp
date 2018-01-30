<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.vo.UsuarioGenericoViafirma"%>
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
			<h1 id="header"><a href="../.."><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmas con intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-63 append-02">
						<div class="box">
							<h3 class="box-title">Firma de varios documentos independientes</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de varios documentos independientes con distinto formato en Viafirma con la intervención directa del usuario.</p>
								
								<p>
									<a class="button" href="?firmarVarios">Firma de varios documentos independientes en formato XAdES</a>
								</p>
								
								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmarVarios") != null) {
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										String alias = ConfigureUtil.CERTALIAS;
										String pass = ConfigureUtil.CERTPASS; 
										
										// Listado de id de firmas
										List<String>firmas=new LinkedList<String>();
																				
										// Datos documentos a firmar
										byte[] datosAFirmar1 = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));;
										byte[] datosAFirmar2 = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));;
										
										Documento documento1 = new Documento("datos1.pdf",datosAFirmar1,TypeFile.pdf,TypeFormatSign.PAdES_BASIC);
										Documento documento2 = new Documento("datos2.pdf",datosAFirmar1,TypeFile.pdf,TypeFormatSign.PAdES_BASIC);
										
										Policy policy = new Policy();
										policy.setTypeFormatSign(TypeFormatSign.PAdES_BASIC);
										policy.setTypeSign(TypeSign.ENVELOPED);
										
										
										// Preparamos los ficheros que deseamos firmar
										String id1=viafirmaClient.prepareSignWithPolicy(policy, documento1);
										String id2=viafirmaClient.prepareSignWithPolicy(policy, documento2);

										// Y los adjuntamos al listado de ids de firma
										firmas.add(id1);
										firmas.add(id2);
																				
										// Finalmente iniciamos la firma enviando al usuario a Viafirma e indicando la uri de retorno.
										viafirmaClient.solicitarFirmasIndependientes(firmas,request, response,"/viafirmaClientResponseServlet");
									}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-35">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>solicitarFirmasIndependientes</code></li>
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