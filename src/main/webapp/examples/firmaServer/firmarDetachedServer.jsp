<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.security.DigestInputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.security.DigestOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%-- <%@page import="org.viafirma.cliente.firma.TypeSign"%> --%>
<%-- <%@page import="org.viafirma.cliente.firma.Policy"%> --%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
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
								<p class="button">
									<a href="?upgradeDetachedInternally">Upgrade XAdES detached internally</a>
								</p>
								<p class="button">
									<a href="?upgradeDetachedExternally">Upgrade XAdES detached externally</a>
								</p>
							</div>
						</div>
								<%
if (request.getParameter("upgradeDetachedInternally") != null) {
	ConfigureUtil.initViafirmaClient();
	final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
	final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
	String tipoFirma=null;
								
	tipoFirma="Firma en formato XAdES de un Hash";
											 
	// Datos documento a firmar
	byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/pruebadetached.xml"));
										
	// Indicamos a la plataforma que deseamos firmar el fichero
										
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
	try{
		Policy pol = new Policy();
		pol.setTypeFormatSign(TypeFormatSign.XADES_BES);
		pol.setTypeSign(TypeSign.DETACHED);
		pol.addParameter(PolicyParams.DETACHED_TYPE.getKey(), PolicyParams.DetachedType.INTERNALLY.name());
		pol.addParameter(PolicyParams.NODE_ID_TO_SIGN.getKey(), "N1");
		Documento documento = new Documento("original.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_BES);
														
		// Iniciamos la firma enviando alias y pass
		String idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, documento, alias, pass);
														
		pol = new Policy();
		pol.setTypeFormatSign(TypeFormatSign.XADES_A_ENVELOPED);
		documento = new Documento("signed.xml", ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma), TypeFile.XML, TypeFormatSign.XADES_BES);
		String idUpgrade=ViafirmaClientFactory.getInstance().upgradeSignature(pol, documento);
		byte[] xades_BES_upgraded_to_A = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idUpgrade);
		FirmaInfoViafirma info =  ViafirmaClientFactory.getInstance().checkSignedDocumentValidityByFileType(xades_BES_upgraded_to_A, TypeFormatSign.XADES_A_ENVELOPED);

														%>
														<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
														
														<strong>Validación:</strong><%=info.isValid()?"Firma válida":"Firma NO válida"%><br/>
														<strong>Id de firma:</strong><%=idUpgrade%><br/>
	<%}catch(Exception e){
														%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
	<%}%>
												</p>
											</div>
										</div>
										<%	
}else if (request.getParameter("upgradeDetachedExternally") != null) {
	ConfigureUtil.initViafirmaClient();
	final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
	final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
	String tipoFirma=null;
									
	tipoFirma="Firma en formato XAdES";
												 
	// Datos documento a firmar
	byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
											
											%>
											<div class="box">
											<h2 class="box-title">Ejemplo</h2> 
												<div class="box-content">
													<p>
														<%
	try{
	    //Firma XL
	    Policy pol = new Policy();													
		pol.setTypeFormatSign(TypeFormatSign.XADES_XL_ENVELOPED);
		pol.setTypeSign(TypeSign.DETACHED);
		pol.addParameter(PolicyParams.DETACHED_TYPE.getKey(), PolicyParams.DetachedType.EXTERNALLY.name());
		Documento documento = new Documento("original.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_XL_ENVELOPED);
		String idFirmaXL=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, documento, alias, pass);
		byte[] xades_XL = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirmaXL);
															
		//Resellado _A										
		String originalHash=new String(org.apache.commons.codec.binary.Base64.encodeBase64(DigestUtils.sha(datosAFirmar)));
		pol.addParameter(PolicyParams.ORIGINAL_HASH.getKey(), originalHash);
		pol.setTypeFormatSign(TypeFormatSign.XADES_A_ENVELOPED);
		
		documento = new Documento("signed.xml", xades_XL, TypeFile.XML, TypeFormatSign.XADES_A_ENVELOPED);													
		String idFirmaA1=ViafirmaClientFactory.getInstance().upgradeSignature(pol, documento, new ByteArrayInputStream(datosAFirmar));
		byte[] xades_XL_upgraded_to_A = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirmaA1);
		boolean info =  ViafirmaClientFactory.getInstance().checkSignedDetachedDocumentValidity(xades_XL_upgraded_to_A, datosAFirmar);
															


															%>
															<strong>Tipo de firma:</strong><%=tipoFirma %><br/>

															<strong>Validación:</strong><%=info?"Firma válida":"Firma NO válida"%><br/>
															<strong>Id de firma:</strong><%=idFirmaA1%><br/>

	<%}catch(Exception e){
	    e.printStackTrace();
															%>
															<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
	<%}%>
													</p>
												</div>
											</div>											
										<%	
}										
								%>
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
					<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>