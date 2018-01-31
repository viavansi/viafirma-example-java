<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>

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
				<h2>Recuperación del original de un documento firmado</h2>
				
				<div class="group">
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Recuperar documento original</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento y se recupera el documento original que fue firmado.</p>
								
								<p><a class="button" href="?recuperarOrig">Iniciar recuperación documento original</a></p>
							</div>
						</div>
								<%
									if(request.getParameter("recuperarOrig")!=null){
										/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
										ConfigureUtil.initViafirmaClient();
										String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
										String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
										ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
										
										// Firmamos un documento
										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
										String codFirma=null;
										try{
										    
										    Policy policy = new Policy();
											TypeFormatSign format = TypeFormatSign.XADES_EPES_ENVELOPED;
											    
											policy.setTypeFormatSign(format);
											policy.setTypeSign(TypeSign.ENVELOPED);

											Documento documento = new Documento("exampleSign.pdf", datosAFirmar, TypeFile.PDF, format); 
											codFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
										    
										}catch(InternalException e){
											%>
											<p>No se puede realizar la firma.<%=e.getMessage() %></p>
											<% 
											e.printStackTrace();
										}
									
								 	// Una vez realizada la firma recuperamos del servidor el documento original a través del codigo de firma.
									Documento docu = viafirmaClient.getOriginalDocument(codFirma);
									%>
								<div class="box">
									<h2 class="box-title">Ejemplo</h2> 
									<div class="box-content">
										<p><strong>El tamaño del archivo recuperado es:</strong><%=docu.getSize() %><br/>
										<strong>El identificador es:</strong><%=docu.getId()%>
										</p>
										<p class="descarga">
												<a class="descarga" target="_blank" href="../../utils/downloads.jsp?original&id=<%=codFirma%>" title="Descargar Documento">Descarga de documento original</a> 				
										</p>
									</div>
								</div>										
								<%
								}
								%>
					</div>
					
					<div class="col width-45">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
									<li>getOriginalDocument</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Inicio</a></p>
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