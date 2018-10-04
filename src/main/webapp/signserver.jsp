<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="com.viafirma.client.verify.SignatureVerification"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.client.verify.VerificationSignatureRequest"%>
<%@page import="com.viafirma.client.verify.CertificateResponse"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page
	import="org.viafirma.cliente.rest.desktop.direct.model.SSLClientAuthOperationResponse"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Viafirma - Kit para desarrolladores</title>

<link rel="stylesheet" href="../css/framework.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="../css/styles.css" type="text/css"
	media="screen" />
</head>
<body>
	<%
		ConfigureUtil.initViafirmaClient();
		final String alias = "xnoccio";// Alias del certificado utilizado
		final String pass = "12345";
		String idFirma = null;
		try {

			//Recuperar la instancia iniciada de viafirma client
			ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();

			//Formato de firma
			TypeFormatSign format = TypeFormatSign.PAdES_BASIC;
			TypeFile typeFile = TypeFile.PDF;
			TypeSign typeSign = TypeSign.ENVELOPED;

			//Configuración de la política de firma
			Policy policy = new Policy();
			policy.setTypeFormatSign(format);
			policy.setTypeSign(typeSign);
			
			byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));

			//Generar el objeto Documento con los datos a firmar
			Documento documentoAFirmar = new Documento("doc.pdf", datosAFirmar, typeFile, format);

			//Firma en servidor
			String viafirmaResponse = viafirmaClient.signByServerWithPolicy(policy, documentoAFirmar, alias, pass);
			out.println("RESPONSE: " + viafirmaResponse);
		} catch (InternalException e) {
			out.println(e.getMessage());
		}
	%>
</body>
</html>