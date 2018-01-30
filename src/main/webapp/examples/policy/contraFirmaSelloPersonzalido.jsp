<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="../../"><img src="../../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Contrafirma de documento pdf con sello</h2>
			
				<div class="group">
					<div class="col width-48 append-02">
						<div class="box">
							<h3 class="box-title">Contrafirma de documento  pdf sellado con Viafirma</h3>
							
							<div class="box-content">
								<p>En este ejemplo implementa la contrafirma de un documento pdf ya firmado y sellado haciendo uso del applet de Viafirma.
								Los diferentes firmantes apareceran en el nuevo sello generado.</p>
								
								<p>
									<a class="button" href="?firmar">Contrafirmar documento pdf de ejemplo</a>
								</p>
							</div>
						</div>
					</div>
					
					<%
						if (request.getParameter("firmar") != null) {
							ConfigureUtil.initViafirmaClient();
							
							ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
							
							//Otros firmantes del documnto;
							String otherSigners = "";
							
							// Datos documento a firmar
							byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSignedWithFooter.pdf"));	
					
							//Creamos el documento
							Documento doc = new Documento("exampleSign.pdf",datosAFirmar,TypeFile.PDF,TypeFormatSign.PAdES_BASIC);
							
							//Comprobamos, antes de firma, si el documento está firmado previamente por mas firmantes
							byte[] datosFirmados = doc.getDatos();
							
							// Enviamos a Viafirma el documento para que nos indique si está firmado o no
							FirmaInfoViafirma firmaInfo = viafirmaClient.checkSignedDocumentValidityByFileType(datosFirmados, TypeFormatSign.PAdES_BASIC);
							//Veo si el documento está firmado
							if(firmaInfo.isSigned()){
							  	//Voy añadiendo los firmantes a una cadena para después mostrarlos en el sello de firma
							  	//Tengo en cuenta que haya salto de linea cada 3 comas
								//1-Otros firmantes
								int count = 0;
								if(firmaInfo.getOtherSigners()!=null){
								    for(FirmaInfoViafirma info : firmaInfo.getOtherSigners()){
								        otherSigners += info.getFirstName()+ " " + info.getLastName()+", ";
								    }
								}
								//2-firmante actual del documento
							  	otherSigners += firmaInfo.getFirstName()+ " " + firmaInfo.getLastName()+", ";
							}
							
							//Metemos saltos de líneas al llegar al límite de caracteres establecido
							int maxLineLength = 80;
							Pattern p = Pattern.compile("\\G\\s*(.{1,"+maxLineLength+"})(?=\\s|$)", Pattern.DOTALL);
							Matcher m = p.matcher(otherSigners);
							otherSigners = "";
							while (m.find()){
							    otherSigners+=m.group(1)+"\n";
							}
						    
							//Seteamos la politica
							Policy policy = new Policy();
							
							policy.setTypeFormatSign(TypeFormatSign.PAdES_BASIC);
							policy.setTypeSign(TypeSign.ATTACHED);
							policy.addParameter(PolicyParams.DIGITAL_SIGN_PAGE.getKey(), "1");
							policy.addParameter(PolicyParams.DIGITAL_SIGN_RECTANGLE.getKey(), 
							new org.viafirma.cliente.vo.Rectangle(40,10,550,75));
							policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_HIDE_STATUS.getKey(), "true");
							//Añado el firmante actual mas los firmantes anteriores si existieran
							policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_TEXT.getKey(), "Firmado por "+otherSigners+"[CN]");
							policy.addParameter(PolicyParams.DIGITAL_SIGN_STAMPER_TYPE.getKey(), "QR-BAR-H");
							// Indicamos a la plataforma que deseamos firmar el fichero
							String idFirma = viafirmaClient.prepareSignWithPolicy(policy, doc);	
							
							// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
							viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
						}
					%>
					
					<div class="col width-50">
						<div class="box">
							<h3 class="box-title">Parámetros utilizados</h3>
							
							<div class="box-content">
								<ul>
									<li>TypeFormatSign</li>
									<li>TypeSign</li>
									<li>DIGITAL_SIGN_PAGE</li>
									<li>DIGITAL_SIGN_RECTANGLE</li>
									<li>DIGITAL_SIGN_STAMPER_HIDE_STATUS</li>
									<li>DIGITAL_SIGN_STAMPER_TEXT</li>
									<li>DIGITAL_SIGN_STAMPER_TYPE</li>
								</ul>
							</div>
						</div>
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							
							<div class="box-content">
								<ul>
									<li>checkSignedDocumentValidityByFileType</li>
									<li>prepareSignWithPolicy</li>
									<li>solicitarFirma</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
					
				<p>
					<a href="../firmaPolicy.jsp">&larr; Volver</a>
				</p>
			
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>