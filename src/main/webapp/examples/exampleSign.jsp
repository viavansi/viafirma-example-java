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
<%@page import="com.viafirma.examples.util.ConfigureUtil"%><html>
<head>
<title>Ejemplo Viafirma</title>
</head>
<body>
<img src="../images/layout/cabecera.png" />
<p>Ejemplo de firma de un PDF</p>
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
	if (request.getParameter("firmarPDFConSello") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory
				.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
		byte [] imageByte=IOUtils.toByteArray(this.getClass().getResourceAsStream("/firma.png"));

		// Indicamos a la plataforma que deseamos firmar el fichero
		String idFirma=ViafirmaClientFactory.getInstance().prepareFirmaPDFWithImageStamp("test.pdf",datosAFirmar,new Rectangle(100, 100,300, 200),imageByte);
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("firmarTexto") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar = "Prueba de firma".getBytes();

		// Indicamos a la plataforma que deseamos firmar el fichero
		String idFirma=ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("prueba.txt",TypeFile.TXT,TypeFormatSign.XADES_EPES_ENVELOPED,datosAFirmar);
		
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
	if (request.getParameter("firmarvarios") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		
		// Datos documento a firmar
		byte[] datosAFirmar1 = "Datos 1".getBytes();
		byte[] datosAFirmar2 = "Datos 2".getBytes();
		List<String>firmas=new LinkedList<String>();
		// Indicamos a la plataforma que deseamos firmar el fichero
		String id1=viafirmaClient.prepareFirmaWithTypeFileAndFormatSign("datos1.txt",TypeFile.txt,TypeFormatSign.XADES_EPES_ENVELOPED,datosAFirmar1);
		firmas.add(id1);
		String id2=viafirmaClient.prepareFirmaWithTypeFileAndFormatSign("datos2.txt",TypeFile.txt,TypeFormatSign.XADES_EPES_ENVELOPED,datosAFirmar2);
		firmas.add(id2);
		
		//Anadimos tambien una firma en lotes
		String idLote=viafirmaClient.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
		viafirmaClient.addDocumentoFirmaEnLote(idLote,"datos1.txt",TypeFile.txt,datosAFirmar1);
		viafirmaClient.addDocumentoFirmaEnLote(idLote,"datos2.txt",TypeFile.txt,datosAFirmar2);
		firmas.add(idLote);
		
		String idFirmaServidor=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("datos1.txt",datosAFirmar1,ConfigureUtil.CERTALIAS,ConfigureUtil.CERTPASS,TypeFile.txt,TypeFormatSign.XADES_EPES_ENVELOPED);
		firmas.add(idFirmaServidor);
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirmasIndependientes(firmas,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("continue") != null) {
		String idFirma=request.getParameter("id");
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		viafirmaClient.solicitarFirma(idFirma,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("loop") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		String numeroString=request.getParameter("numero");
		int numero=new Integer(numeroString);
		// Datos documento a firmar
		//byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba600k.pdf"));
		byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
		
		List<String>firmas=new LinkedList<String>();
		String id;
		BenchMarkTimeUtils.startDate=System.currentTimeMillis();
		for(int cont=1;cont<=numero;cont++){
			// Indicamos a la plataforma que deseamos firmar el fichero
			id=ViafirmaClientFactory.getInstance().prepareFirmaWithTypeFileAndFormatSign("pdf"+cont+".pdf",TypeFile.pdf,TypeFormatSign.PDF_PKCS7,datosAFirmar);
			firmas.add(id);
		}
		
		// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
		viafirmaClient.solicitarFirmasIndependientes(firmas,request, response,"/viafirmaClientResponseServlet");
	}
	if (request.getParameter("loopWithImage") != null) {
		ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
		String numeroString=request.getParameter("numero");
		int numero=new Integer(numeroString);
		// Datos documento a firmar
		//byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba600k.pdf"));
		byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
		byte [] imageByte=IOUtils.toByteArray(this.getClass().getResourceAsStream("/firma.png"));
		String id;
		BenchMarkTimeUtils.startDate=System.currentTimeMillis();
		out.println("<ul>");
		for(int cont=1;cont<=numero;cont++){
			// Indicamos a la plataforma que deseamos firmar el fichero
			out.println("<li>");
			out.println(ViafirmaClientFactory.getInstance().signByServerPDFWithImageStamp("pdf"+cont+".pdf",datosAFirmar,ConfigureUtil.CERTALIAS,ConfigureUtil.CERTPASS,new Rectangle(100, 100,300, 200),imageByte));
			out.println("</li>");
		}
		out.println("</ul>");
	}
	
	
	
	
%>
<p><a href="?firmarPDF">Firmar documento PDF en formato PDF Signature con Viafirma</a></p>
<p><a href="?firmarPDFConSello">Firmar documento PDF en formato PDF Signature con imagen de sello con Viafirma</a></p>
<p><a href="?firmarTexto">Firmar documento de texto en formato XAdES con Viafirma</a></p>
<p><a href="?firmarXML">Firmar documento xml en formato XAdES con Viafirma</a></p>
<p><a href="?firmarLote">Firmar documentos en lote formato XAdES con Viafirma</a></p>
<p><a href="?firmarvarios">Firmar varios documentos independientes formato XAdES con Viafirma</a></p>
<form action="#">
	<p>
		Refirmar documento firmado:<br/>
		ID:<br/><input type="text" name="id"></input><br/>
		<input type="hidden" name="continue"/>	
		<input type="submit">
	</p>
</form>
<form action="#">
	<p>
		Bucle de firmas individuales:<br/>
		Numero de peticiones:<br/><input type="text" name="numero"></input><br/>
		<input type="hidden" name="loop"/>	
		<input type="submit">
	</p>
</form>
<form action="#">
	<p>
		Bucle de firmas PDF con imagen:<br/>
		Numero de peticiones:<br/><input type="text" name="numero"></input><br/>
		<input type="hidden" name="loopWithImage"/>	
		<input type="submit">
	</p>
</form>

</body>
</html>