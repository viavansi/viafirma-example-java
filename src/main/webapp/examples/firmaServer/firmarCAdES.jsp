<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.xml.security.transforms.Transforms"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
				<h2>Firmas sin intervención del usuario</h2>
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Firma XML</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento XML en el servidor, en el formato CAdES elegido y con la modalidad elegida, sin la intervención directa del usuario.</p>
								<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
								
								<p>Selecciona formato CAdES
								<select name="cadesFormat" form="idForm">
  									<option value="CAdES_BES">CAdES_BES</option>
  									<option value="CAdES_EPES">CAdES_EPES</option>
  									<option value="CAdES_T">CAdES_T</option>
								</select>								
								</p>
								
								<p>Selecciona modo de firma
								<select name="typeSign" form="idForm">
  									<option value="ATTACHED">ATTACHED</option>
  									<option value="DETACHED">DETACHED</option>
								</select>
								
								<form action="" id="idForm">
									<input type="hidden" name="firmar" value="firmar">
									<input type="submit" value="Firmar">
								</form>
								
							</div>
						</div>
						<%
						
						if (request.getParameter("firmar") != null) {
							ConfigureUtil.initViafirmaClient();
							final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
							final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
							// Datos documento a firmar
							byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
							//Recuperamos el formato
							String cadesFormat = request.getParameter("cadesFormat");
							TypeFormatSign typeFormat = TypeFormatSign.valueOf(cadesFormat);
							//Recuperamos modalidad
							String sTypeSign = request.getParameter("typeSign");
							TypeSign typeSign = TypeSign.valueOf(sTypeSign);
															
							%>
							<div class="box">
							<h2 class="box-title">Ejemplo</h2> 
								<div class="box-content">
									<p>
										<%
										try{
											String idFirma;											
											//Policy Implementation
			 								Policy pol = new Policy();
			 								//Definimos el tipo de formato
											pol.setTypeFormatSign(typeFormat);
			 								//Definimos la modalidad de firma
			 								pol.setTypeSign(typeSign);
			 								//Definimos Documento
			 								Documento doc = new Documento("pruebaSigned.xml", datosAFirmar, TypeFile.XML, typeFormat);
			 								//Viafirma invocation
			 								//primera firma
			 								idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, doc, alias, pass);
			 								//segunda firma
			 								byte[] signed = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
			 								Documento docSigned = new Documento("pruebaSigned.xml", signed, TypeFile.XML, typeFormat);
			 								FileUtils.writeByteArrayToFile(new File("C:\\Temp\\firma1.p7s"), docSigned.getDatos());
			 								idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, docSigned, alias, pass);
			 								//documento "refirmado"
			 								byte[] datosFirmados = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);			 								
			 								FirmaInfoViafirma firmaInfo = ViafirmaClientFactory.getInstance().checkSignedDocumentValidityByFileType(datosFirmados,typeFormat);
			 								
			 								
			 								if(TypeSign.DETACHED.equals(typeSign)){
												MessageDigest md = MessageDigest.getInstance("SHA1");
												md.update(signed);
												byte[] bHash = md.digest();
												String hash = new String(Base64.encodeBase64(bHash));
			 									FirmaInfoViafirma infoDetached = ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidity(datosFirmados, hash, TypeFormatSign.CAdES_BES);
			 									%>
			 									<strong>(checkSignedHashDocumentValidity) is Valid:</strong><%=infoDetached.isValid()%><br/>
			 									<strong>(checkSignedHashDocumentValidity) is Signed:</strong><%=infoDetached.isSigned()%><br/>
			 									<%
			 								}else{
												%>
			 									<strong>(checkSignedDocumentValidityByFileType) is Signed:</strong><%=firmaInfo.isSigned()%><br/>
			 									<strong>(checkSignedDocumentValidityByFileType) is Valid:</strong><%=firmaInfo.isValid()%><br/>
												<%
											}%>
											<strong>Id de firma:</strong><%=idFirma%><br/>
											<strong><a href="<%=ConfigureUtil.URL_VIAFIRMA%>/v/<%=idFirma%>?d">Descargar documento firmado</a></strong>
										<%}catch(Exception e){%>
											<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
										<%}%>
									</p>
								</div>
							</div>
						<%}%>
					</div>
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
									<li>getDocumentoCustodiado</li>
									<li>checkSignedDocumentValidityByFileType</li>
									<li>checkSignedDetachedDocumentValidity (if Detached type)</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p>
					<a href="../firmaServer.jsp">&larr; Volver</a>
				</p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../../apiExamples/">Listado de métodos</a> - <small>Version 0.6</small>
				</p>
			</div>
		</div>
	</body>
</html>