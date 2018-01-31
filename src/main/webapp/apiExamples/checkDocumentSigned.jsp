<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>

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
					<h2>Método <code>checkDocumentSigned</code></h2>
					
					<p>El método <code>checkDocumentSigned</code> compara un documento firmado con uno firmado y custodiado para comprobar su integridad.</p>
					
					<p>
						Recibe como paramentro:
					</p>
					
					<ul class="parameters">
						<li><code>byte[] data</code> Byte array del documento</li>
						<li><code>String id</code> Código del documento custodiado</li>
					</ul>
					
					<p>Devuelve:<p>
					<ul class="parameters">
						<li><code>FirmaInfoViafirma</code> Informacion de la firma indicando su validez</li>
					</ul>
						 <!--<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
						 <p><a href="?check">Comprobar valido</a><a href="?checkNo">Comprobar no valido</a></p>-->
						 
						 <p>
							<a href="./" >&larr; Volver</a>
						</p>
						<%
						if(request.getParameter("check")!=null || request.getParameter("checkNo")!=null){
				
							ConfigureUtil.initViafirmaClient();
							
							ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
							FirmaInfoViafirma info= new FirmaInfoViafirma();
							/* Recupera los datos del documento XML que ya debe haber sido firmado y custodiado con Viafirma.*/
							/* Si no ha firmado este documento con Viafirma, acceda a viafirma y firme el documento, una vez firmado obtendra un identificador*/
							/* de firma que podra utilizar en este ejemplo para validar el funcionamiento del método checkDocumentSigned.*/
							byte[] datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
							byte[] datosAComprobar2 = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba2.xml"));
							String alias= ConfigureUtil.CERTALIAS;
							String pass= ConfigureUtil.CERTPASS;
							String codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign("temp2.xml",datosAComprobar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
							byte[] datosFirmados = viafirmaClient.getDocumentoCustodiado(codFirma);
							
							/* Enviamos a Viafirma el documento firmado, y el identificador de firma generado al firmar este documento para que viafirma */
							/* Nos indique si el documento es o no válido */
							if(request.getParameter("check")!=null){
								info=ViafirmaClientFactory.getInstance().checkDocumentSigned(datosFirmados,codFirma);
							}else{
							    info=ViafirmaClientFactory.getInstance().checkDocumentSigned(datosAComprobar2,codFirma);
							}
						%>
						
						<p><strong>¿Es válido?:</strong><%=info.getValid()%><br/><br/>
						<strong>Firmante:</strong><%=info.getFirstName()%><br/>		
						<strong>CA:</strong><%=info.getCaName()%><br/>
						<strong>IdFirma:</strong><%=info.getSignId()%></p>
						<%} %>
						
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
