<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>

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
				<div class="box">
					<h2 class="box-title">Métodos del API cliente </h2>
					<div class="box-content group">
						<div class="col width-49 append-01">
							<ul class="data-list">
								<li><a href="addDocumentoFirmaEnLote.jsp"><code>addDocumentoFirmaEnLote</code></a> Añade documento a un lote ya iniciado</li>
								<li><a href="buildInfoQRBarCode.jsp" ><code>buildinfoQRBarCode</code></a> Generación del PNG de código de seguimiento</li>
								<li><a href="checkDocumentSigned.jsp" ><code>checkDocumentSigned</code></a> Verificación de un documento firmado</li>
								<li><a href="checkOriginalDocumentSigned.jsp" ><code>checkOrignalDocumentSigned</code></a> Verificación del contenido de un documento firmado</li>
								<li><a href="checkSignedDocumentValidity.jsp"><code>checkSignedDocumentValidity</code></a> Comprobación de validez de firma en un documento</li>
								<li><a href="disabledMultiSign.jsp"><code>disabledMultiSign</code></a> Deshabilitar multifirma</li>
								<li><a href="enabledMultiSign.jsp"><code>enabledMultiSign</code></a> Habilitar multifirma</li>
								<li><a href="getDocumentoCustodiado.jsp" ><code>getDocumentoCustodiado</code></a> Devuelve documento custodiado</li>
								<li><a href="getOriginalDocument.jsp" ><code>getOriginalDocument</code></a> Recupera el original de una firma</li>
								<li><a href="getOriginalDocumentsIds.jsp" ><code>getOriginalDocumentsIds</code></a> Recupera el listado de identificadores de los documento orignales de un lote</li>
								<li><a href="getSignInfo.jsp" ><code>getSignInfo</code></a> Recupera información de una firma</li>
								<li><a href="iniciarFirmaEnLotes.jsp"><code>iniciarFirmaEnLotes</code></a> Inicia un lote de firmas</li>
								<li><a href="prepareFirmaPDFWithImageStamp.jsp"><code>prepareFirmaPDFWithImageStamp</code></a> Prepara un documento para ser firmado con imagen</li>
								<li><a href="prepareFirmaWithTypeFileAndFormatSign.jsp"><code>prepareFirmaWithTypeFileAndFormatSign</code></a> Prepara un documento para ser firmado</li>
							</ul>
						</div>
						
						<div class="col width-49 prepend-01">
							<ul class="data-list">
								<li><a href="prepareFirmaWithTypeFileAndFormatSignAndFilterCertificate.jsp"><code>prepareFirmaWithTypeFileAndFormatSignAndFilterCertificate</code></a> Prepara un documento para ser firmado por un usuario </li>
								<li><a href="sendSignMailByServer.jsp" ><code>sendSignMailByServer</code></a> Firma en servidor y envio de emails</li>
								<li><a href="signatureInBatches.jsp" ><code>signByServerEnLotes</code></a> Firma en Lotes</li>
								<li><a href="signByServerPDFWithImageStamp.jsp" ><code>signByServerPDFWithImageStamp</code></a> Firma en servidor un PDF con imagen</li>
								<li><a href="signByServerWithTypeFileAndFormatSign.jsp" ><code>signByServerWithTypeFileAndFormatSign</code></a> Firma en servidor de un documento</li>
								<li><a href="signPreviousSignature.jsp"><code>signPreviousSignature</code></a> Añade firma a un documento ya firmado</li>
								<li><a href="solicitarAutenticacion.jsp"><code>solicitarAutenticacion</code></a> Envia al usuario al inicio del proceso de autenticación</li>
								<li><a href="solicitarFirma.jsp"><code>solicitarFirma</code></a> Envia al usuario al inicio del proceso de firma</li>
								<li><a href="solicitarFirmasIndependientes.jsp"><code>solicitarFirmasIndependientes</code></a> Firma varios documentos de forma independiente con intervención del usuario</li>
								<li><a href="xadesAResign.jsp"><code>xadesAResign</code></a> Vuelve a firmar un documento XADES XL en XADES A</li>
								<li><a href="prepareSignWithPolicy.jsp"><code>prepareSignWithPolicy</code></a> Prepara una firma usando un objeto Policy (utilizado, por ejemplo, para firmas digitalizadas)</li>
								<li><a href="checkCertificate.jsp"><code>checkCertificate</code></a> Chequea la validez de un certificado</li>
								<li><a href="checkCertificateByAlias.jsp"><code>checkCertificateByAlias</code></a> Chequea la validez de un certificado alojado en el servidor</li>
							</ul>
						</div>
					</div>
				</div>
				
				<p class="note">Para utilizar los métodos <code>signByServer*</code> tener instalado un certificado en el HSM del servidor además de conocer su clave y alias</p>
			</div>
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