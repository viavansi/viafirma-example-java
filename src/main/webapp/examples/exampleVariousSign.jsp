<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%><html>
<head>
<title>Ejemplo Viafirma</title>
</head>
<body>
<img src="../images/layout/cabecera.png" />
<p>Ejemplo de firma de un 2 PDFs</p>
<%
	ConfigureUtil.initViafirmaClient();


	if (request.getParameter("firmarPDF") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory
				.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));

		// Indicamos a la plataforma que deseamos firmar el fichero
		String idFirma=ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("test.pdf",TypeFile.PDF,TypeFormatSign.PDF_PKCS7,datosAFirmar);
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("firmarTexto") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar = "Prueba de firma".getBytes();

		// Indicamos a la plataforma que deseamos firmar el fichero
		String idFirma=ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("prueba.txt",TypeFile.TXT,TypeFormatSign.XADES_A_ENVELOPED,datosAFirmar);
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("firmarXML") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Edit_Mensaje><Mensaje><Remitente><Nombre>Nombre del remitente</Nombre><Mail>Correo del remitente </Mail></Remitente><Destinatario><Nombre>Nombre del destinatario</Nombre><Mail>Correo del destinatario</Mail></Destinatario><Texto><Asunto>Este es mi documento con una estructura muy sencilla no contiene atributos ni entidades...</Asunto><Parrafo>Este es mi documento con una estructura muy sencilla no contiene atributos ni entidades...</Parrafo></Texto></Mensaje></Edit_Mensaje>".getBytes();

		// Indicamos a la plataforma que deseamos firmar el fichero
		String idFirma=ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("prueba.xml",TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED,datosAFirmar);
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("firmarLote") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar1 = "Datos 1".getBytes();
		byte[] datosAFirmar2 = "Datos 2".getBytes();
		byte[] datosAFirmar3 = "Datos especiales para JaviEU".getBytes();

		// Indicamos a la plataforma que deseamos firmar el fichero
		String idFirmaLote=ViafirmaClientFactory.getInstance().iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
		ViafirmaClientFactory.getInstance().addDocumentoFirmaEnLote(idFirmaLote,"datos1.txt",TypeFile.txt,datosAFirmar1);
		ViafirmaClientFactory.getInstance().addDocumentoFirmaEnLote(idFirmaLote,"datos2.txt",TypeFile.txt,datosAFirmar2);
		ViafirmaClientFactory.getInstance().addDocumentoFirmaEnLote(idFirmaLote,"datos3EspecialJaviEU.txt",TypeFile.txt,datosAFirmar3);
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirma(idFirmaLote,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("continue") != null) {
		String idFirma=request.getParameter("id");
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
	}
	
	
	
	
%>
<p><a href="?firmarPDF">Firmar documento PDF en formato PDF Signature con Viafirma</a></p>
<p><a href="?firmarTexto">Firmar documento de texto en formato XAdES con Viafirma</a></p>
<p><a href="?firmarXML">Firmar documento xml en formato XAdES con Viafirma</a></p>
<p><a href="?firmarLote">Firmar documentos en lote formato XAdES con Viafirma</a></p>

<form action="#">
<p>
	Refirmar documento firmado:<br/>
	ID:<input type="text" name="id"></input><br/>
	<input type="hidden" name="continue"/>	
	<input type="submit">
</p>
</form>

</body>
</html>