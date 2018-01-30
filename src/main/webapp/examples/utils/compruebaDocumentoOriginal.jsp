<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
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
				<h2>Verificación de correspondencia entre el documento original y el firmado</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Comprobar original firmado</h3>
							
							<div class="box-content">
								<p>Este ejemplo, recupera un documento xml original, que previamente ha sido firmado con Viafirma, y comprueba que el documento no ha sido modificado, y corresponde con la versión custodiada en Viafirma.</p>
								
								<p><a class="button" href="?checkOrig">Verificar documento de prueba</a></p>
							</div>
						</div>
								<%
								if(request.getParameter("checkOrig")!=null){
									
									if (!ViafirmaClientFactory.isInit()){
										ViafirmaClientFactory.init(
												ConfigureUtil.getViafirmaServer(),
												ConfigureUtil.getViafirmaServerWS(),
												ConfigureUtil.getApiKey(),
												ConfigureUtil.getApiPass());
									}
									String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
									String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
									ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
									// Firmamos el documento
									byte[] datosOriginalAComprobar = null;
									byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
									final String idFirma=viafirmaClient.signByServerWithTypeFileAndFormatSign("prueba_valido.xml",datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
									// Recuperarmos el documento original
									datosOriginalAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml")); 
									
									//byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/ejemplo.txt"));
									//final String idFirma=viafirmaClient.signByServerWithTypeFileAndFormatSign("prueba_valido.txt",datosAFirmar,alias,pass,TypeFile.TXT,TypeFormatSign.XADES_EPES_ENVELOPED);
									// Recuperarmos el documento original
									//datosOriginalAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/ejemplo.txt")); 
									
									
									//byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
									//final String idFirma=viafirmaClient.signByServerWithTypeFileAndFormatSign("prueba_valido.pdf",datosAFirmar,alias,pass,TypeFile.PDF,TypeFormatSign.XADES_EPES_ENVELOPED);
									// Recuperarmos el documento original
									//datosOriginalAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf")); 
							
									// Enviamos a Viafirma el documento original y el identificador de firma generado al firmar este documento para que
									// nos indique si el documento firmado y el original corresponden al mismo documento y corresponde a la version custodiada.
									FirmaInfoViafirma info=viafirmaClient.checkOrignalDocumentSigned(datosOriginalAComprobar,idFirma);
								%>
								<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
										<div class="box-content">
											<p><strong>¿Es válido?:</strong><%=info.getValid()%><br/>
											<strong>Firmante:</strong><%=info.getFirstName()%><br/>		
											<strong>CA:</strong><%=info.getCaName()%><br/>
											<strong>IdFirma:</strong><%=info.getSignId()%></p>
										</div>
								</div>
								<%}%>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithTypeFileAndFormatSign</li>
									<li>checkOrignalDocumentSigned</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Volver</a></p>
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