<%@page import="org.viafirma.cliente.vo.Rectangle"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<h2>Firmas con intervención del usuario</h2>
				
				<div class="group">
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Firma PDF</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza una firma <strong>digitalizada</strong> de un documento PDF.</p>
							
								<p>
									<a class="button" href="?firmar">Firmar PDF</a>
								</p>
								
								<%
									ConfigureUtil.initViafirmaClient();
									if (request.getParameter("firmar") != null) {
										//Cliente
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										//Formato de firma
										TypeFormatSign format = TypeFormatSign.DIGITALIZED_SIGN;
										
										// Datos documento a firmar y logo
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										byte[] logoStamp=IOUtils.toByteArray(this.getClass().getResourceAsStream("/logoStamp.jpg"));
										
										//Documento
										Documento documento = new Documento("prueba.pdf",datosAFirmar,TypeFile.PDF, format);
										String pem = IOUtils.toString(this.getClass().getResourceAsStream("/xnoccio.pem"));
										
										//Policy
										Policy policy = new Policy();
										policy.setTypeSign(TypeSign.ATTACHED);
										//Indica el formato (en este caso digitalizada)
										policy.setTypeFormatSign(format);
										//Indica el color de fondo de la pantalla
// 										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BACK_COLOUR.getKey(), "#0000FF");
										//Indica el color de la firma de la pantalla
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_COLOUR.getKey(), "#FF0000");
										//Indica el texto de ayuda que aparece en la pantalla 
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_HELP_TEXT.getKey(), "Texto de ayuda aportado por el integrador");
										//Logo a mostrar
// 										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_LOGO.getKey(), logoStamp);
										//Rectangulo donde se fija la firma
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_RECTANGLE.getKey(), new Rectangle(400,60,160,120));
										//Biometric alias - pass son utilizados para firmar los datos biometricos en servidor (el alias debe existir en el servidor) 
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BIOMETRIC_ALIAS.getKey(), "xnoccio");
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BIOMETRIC_PASS.getKey(), "12345");
									    //Clave publica en formato pem con la que cifrar los datos biometricos, si no se indica no se cifran
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_BIOMETRIC_CRYPTO_PEM.getKey(), pem);
									    //Pagina donde insertar la firma, -1 para la ultima pagina, si no se indica, en iOS se permitirá seleccionar la pagina/s manualmente, en Topaz se pondrá en la última página
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_PAGE.getKey(), -1); 
									    
									    //Firma en servidor del documento
										policy.addParameter(PolicyParams.DIGITALIZED_SIGN_ALIAS.getKey(), "xnoccio");
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGN_PASS.getKey(), "12345");
									    
									    policy.addParameter(PolicyParams.DIGITALIZED_SIGNATURE_INFO.getKey(), "Firmante de ejemplo");
									    
									    policy.addParameter(PolicyParams.DIGITALIZED_PRESSURE_STYLUS.getKey(), "NONE");
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										String idFirma=viafirmaClient.prepareSignWithPolicy(policy, documento);
										// Solicitamos la firma
										viafirmaClient.solicitarFirma(idFirma, request, response, "/viafirmaClientResponseServlet");										
									}
								%>
							</div>
						</div>
					</div>
					
					<div class="col width-45">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>prepareSignWithPolicy</code></li>
									<li><code>Params:</code>
										<ul>
											<li><code>PolicyParams.DIGITALIZED_SIGN_BACK_COLOUR</code></li>
											<li><code>PolicyParams.DIGITALIZED_SIGN_COLOUR</code></li>
											<li><code>PolicyParams.DIGITALIZED_SIGN_HELP_TEXT</code></li>
											<li><code>PolicyParams.DIGITALIZED_SIGN_LOGO</code></li>
											<li><code>PolicyParams.DIGITALIZED_SIGN_RECTANGLE</code></li>
										</ul>
									</li>
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
