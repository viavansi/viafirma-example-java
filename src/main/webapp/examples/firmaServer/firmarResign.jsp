<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
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
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Firma con XAdES A</h3>
							<div class="box-content">
									<p>En este ejemplo, un documento PDF que ya se encuentra firmado con formato XAdES XL se vuelve a firmar con XAdES A .</p>
									<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor</p>
								
								<p>
									<a class="button" href="?xadesAResign">Firma de documento de texto en formato XAdES en servidor</a>
								</p>
							</div>
						</div>
								
								<%
																	ConfigureUtil.initViafirmaClient();
																	if (request.getParameter("xadesAResign") != null) {
																		//Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.
																		// 										String alias="x";// Alias del certificado utilizado
																		// 										String pass="1111";// Pass del certificado utilizado.
																		ConfigureUtil.initViafirmaClient();

																		ViafirmaClient viafirmaClient = ViafirmaClientFactory
																				.getInstance();
																		// Datos documento a firmar
																		byte[] datosAFirmar = IOUtils.toByteArray(getClass()
																				.getResourceAsStream("/ejemplo.txt"));

																		// Iniciamos la firmar el fichero
																%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
														try {
																final String ALIAS = ConfigureUtil.CERTALIAS;
																final String PASS = ConfigureUtil.CERTPASS;
																
																
																 Policy policy = new Policy();
																    TypeFormatSign format = TypeFormatSign.XADES_A_ENVELOPED;
																    
																    policy.setTypeFormatSign(format);
																	policy.setTypeSign(TypeSign.ENVELOPED);

																	Documento document = new Documento("ejemplo.txt", datosAFirmar, TypeFile.TXT, format); 
																	String idFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, document, ALIAS, PASS);

																
																byte[] documento = viafirmaClient.getDocumentoCustodiado(idFirma);
																documento = viafirmaClient.xadesAResign(documento);
																documento = viafirmaClient.xadesAResign(documento);
																session.setAttribute("documento", documento);
																
													%>
<%-- 														<strong>Tipo de firma:</strong><%=tipoFirma %><br/> --%>
														<strong>Id de firma:</strong><%=idFirma%>.<br/>
														<p>
															<a class="button" target="_blank" href="../../utils/downloads.jsp" title="Descargar documento refirmado">Descargar documento refirmado</a>
														</p>
													<%
														} catch (Exception e) {
													%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
													<%
														}
													%>
												</p>
											</div>
										</div>
										<%
											}
										%>	
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
									<li>getDocumentoCustodiado</li>
									<li>xadesAResign</li>
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