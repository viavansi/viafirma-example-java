<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Método <code>checkOriginalDocumentSigned</code></h2>
				
				<p>Este ejemplo, recupera un documento xml original, que previamente ha sido firmado con Viafirma, y comprueba que el documento no ha sido modificado, y corresponde con la versión custodiada en Viafirma.</p>
				
				<p>Recibe como paramentro:</p>
				
				<ul class="parameters">
					<li><code>byte[] originalData</code> Byte array de los datos del fichero original</li>
					<li><code>String id</code> Identificador del documento custodiado</li>
			    </ul>
				
				<p>Devuelve:</p>
				<ul class="parameters">
					<li><code>FirmaInfoViafirma</code> Objeto FirmaInfoViafirma con toda la información de la firma</li>
				</ul>
				<p class="note">Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
				
				<!--<p><a href="?valido">Original valido</a>
				 <a href="?noValido">Original no valido</a></p>
				<%
				if(request.getParameter("valido")!=null || request.getParameter("noValido")!=null){
				    /* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
				
					ConfigureUtil.initViafirmaClient();
					
					// Firmamos el documento
					byte[] datosAComprobar = null;
					byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/Ejemplo_facturae_oficinal_Sin_FIRMA_example1.xml"));
					final String idFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("prueba_valido.xml",datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
				    
					
				    if(request.getParameter("valido")!=null){
						//Recupera los datos del documento XML que ya debe haber sido firmado y custodiado con Viafirma.
						//Si no ha firmado este documento con Viafirma, acceda a viafirma y firme el documento, una vez firmado obtendra un identificador
						//de firma que podra utilizar en este ejemplo para validar el funcionamiento del método checkOrignalDocumentSigned.
						datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/Ejemplo_facturae_oficinal_Sin_FIRMA_example1.xml")); 
				    }else{ // "noValido"
						//Recuperamos un documento distinto para forzar el error
						datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
				    }
		
					
					// Enviamos a Viafirma el documento original, y el identificador de firma generado al firmar este documento para que viafirma
					// indique si el documento es o no válido
					FirmaInfoViafirma info=ViafirmaClientFactory.getInstance().checkOrignalDocumentSigned(datosAComprobar,idFirma);
				%>
			
				<h3>Ejemplo</h3>
				<p><strong>¿Es válido?:</strong><%=info.getValid()%><br/>
				<strong>Firmante:</strong><%=info.getFirstName()%><br/>		
				<strong>CA:</strong><%=info.getCaName()%><br/>
				<strong>IdFirma:</strong><%=info.getSignId()%></p>
				<%}%>-->
					
				<p>
					<a href="./">&larr; Volver</a>
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