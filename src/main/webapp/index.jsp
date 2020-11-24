<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="images/content/logo.png" alt="Viafirma" /></a></h1>
			<div id="content">
				
				<p class="message">La aplicación de ejemplo está actualmente configurada para utilizar:<br/>
		
				URL Viafirma Platform:<strong><%=ConfigureUtil.getViafirmaServer() %></strong><br/>
				URL WS Viafirma Platform:<strong><%=ConfigureUtil.getViafirmaServerWS() %></strong><br/>
				API Key:<strong><%=ConfigureUtil.getApiKey() %></strong><br/>
				API Pass:<strong><%=ConfigureUtil.getApiPass() %></strong><br/>
				<a href="changeServer.jsp">Administrar ejemplo</a>
				
				</p>
				
				
				
				<div class="group">
					<div class="col width-49 append-01">
						<div class="box">
							<h2 class="box-title">Autenticación</h2>
							
							<div class="box-content">
								<ul>
									<li><a href="examples/exampleAuthenticationPolicy.jsp" >Autenticar al usuario</a></li>
									<li><a href="examples/exampleAuthenticationPolicyAutoSend.jsp" >Autenticar al usuario con selección automática de certificado</a></li>
								    <li><a href="exampleFilter/exampleAuthentication.jsp" >Autenticar al usuario controlado por filtro </a></li>
                                    <li><a href="examples/exampleAuthenticationViafirmaDesktop.jsp" >Autenticar al usuario invocando a Viafirma Desktop por protocolo</a></li>
                                    <li><a href="examples/exampleAuthenticationSSLClientAuth.jsp" >Autenticar al usuario sin cliente rico (SSL)</a></li>
								</ul>
							</div>
						</div>
					</div>
					
					<div class="col width-49 prepend-01">
						<div class="box">
							<h2 class="box-title">Firma</h2>
							
							<div class="box-content">
								<ul>
									<li><a href="examples/firmaUsuario.jsp" >Firmar documento con intervención del usuario</a></li>
									<li><a href="examples/firmaServer.jsp" >Firmar documento sin intervención del usuario</a></li>
									<li><a href="examples/exampleSignatureViafirmaDesktop.jsp" >Firmar invocando a Viafirma Desktop por protocolo</a></li>
									<li><a href="examples/exampleSignatureViafirmaDesktopLoop.jsp" >Firmar varios documentos en bucle invocando a Viafirma Desktop por protocolo</a></li>
									<li><a href="examples/firmaPolicy.jsp" >Otros ejemplos de firmas</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="box">
					<h2 class="box-title">Métodos de utilidad</h2>
					
					<div class="box-content">
						<ul>
							<li><a href="examples/utils/generarQRBarCode.jsp" >Generación de resguardo de seguimiento con código QR</a></li>
<!-- 		Deprecated					<li><a href="examples/utils/compruebaDocumentoFirmado.jsp" >Verificación de un documento firmado</a></li> -->
<!-- 		Deprecated					<li><a href="examples/utils/compruebaDocumentoOriginal.jsp" >Verificación de correspondencia entre el documento original y el firmado</a></li> -->
<!-- 		Deprecated					<li><a href="examples/utils/validarFirma.jsp">Validez de firma en un documento</a></li> -->
<!-- 		Deprecated					<li><a href="examples/utils/comprobarDetachedSinReferenciaDeclarada.jsp" >Verificación de un documento firmado en tipo DETACHED y sin referencia al original</a></li> -->
							<li><a href="examples/utils/recuperarDocumento.jsp" >Recuperación de un documento custodiado</a></li>
							<li><a href="examples/utils/recuperarDocumentoOriginal.jsp" >Recuperación del original de un documento firmado</a></li>
							<li><a href="examples/utils/recuperarDocumentosOriginales.jsp" >Recuperación del listado de firmas de un lote</a></li>
							<li><a href="examples/utils/recuperarInfoFirma.jsp" >Recupera información de una firma</a></li>
<!-- 		Deprecated					<li><a href="examples/utils/validarCertificadoCliente.jsp" >Comprobación de validez de certificado cliente (clave pública)</a></li> -->
<!-- 		Deprecated					<li><a href="examples/utils/validarCertificadoServidor.jsp" >Comprobación de validez de certificado en el servidor</a></li> -->
							<li><a href="examples/utils/valideSignUploaded.jsp">Validez de firma de un documento adjuntado</a></li>
							<li><a href="examples/utils/valideCertificateUploaded.jsp">Validez de certificado cliente (clave pública)</a></li>
							<li><a href="examples/utils/valideServerCert.jsp" >Validez de certificado servidor</a>
						</ul>
					</div>
				</div>
				
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="https://doc.viafirma.com/viafirma-platform/integration/">Manual de integración de viafirma platform</a> 
				</p>
				<p>
					<small>3.1.1</small>
				</p>
			</div>
		</div>
	</body>
</html>