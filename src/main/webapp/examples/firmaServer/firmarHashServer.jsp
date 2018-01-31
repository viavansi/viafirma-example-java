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
								<p>En este ejemplo se realiza la firma de un documento del cual solo se conoce el hash, 
								se pasa el hash como datos del documento, durante la firma no se calcula hash del documento, 
								se usa el hash pasado.
								</p>
								
								<p>Para la validación será necesario utilizar métodos de específicos que reciben 
								el hash del fichero original, por tanto no se realiza el cálculo del hash del 
								documento original, sino que se utiliza el hash pasado</p>	
															
								<p class="button">
									<a href="?firmarHashXAdES">Firma XAdES conociendo solo el Hash del documento original</a>
								</p>
								<p class="button">
									<a href="?firmarHashCAdES">Firma CAdES conociendo solo el Hash del documento original</a>
								</p>
								<p class="button">
									<a href="?firmarHashXLToA">Pasar XADES-XL a XADES-A conociendo solo el Hash del documento original</a>
								</p>
								<p class="button">
									<a href="?firmarHashXLToA_noHash">Pasar XADES-XL a XADES-A conociendo el documento original</a>
								</p>
								
							</div>
						</div>
								<%
									if (request.getParameter("firmarHashXAdES") != null) {
										ConfigureUtil.initViafirmaClient();
										final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
										final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
										String tipoFirma=null;
								
										tipoFirma="Firma en formato XAdES de un Hash";
											 
										// Datos documento a firmar
										byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
										
										// Indicamos a la plataforma que deseamos firmar el fichero
										
										%>
										<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
											<div class="box-content">
												<p>
													<%
													try{
														String hashOriginal = new String(org.apache.commons.codec.binary.Base64.encodeBase64(DigestUtils.sha(datosAFirmar)));
														
														//Creamos Policy y Documento
														Policy policy = new Policy();
														policy.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
														policy.setTypeSign(TypeSign.DETACHED);
					    
														Documento documento = new Documento("hashSigned", hashOriginal.getBytes(), TypeFile.hash, TypeFormatSign.XADES_EPES_ENVELOPED);
														
														// Iniciamos la firma enviando alias y pass
														String idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
														
														//Validamos la firma
														byte[] signedDoc = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
														FirmaInfoViafirma info = ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidity(signedDoc, hashOriginal, TypeFormatSign.XADES_EPES_ENVELOPED);
														
														%>
														<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
														<strong>Validación:</strong><%=info.isValid()?"Firma válida":"Firma NO válida"%><br/>
														<strong>Id de firma:</strong><%=idFirma%><br/>
													<%}catch(Exception e){
														%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
													<%}%>
												</p>
											</div>
										</div>
										<%	
										}else if (request.getParameter("firmarHashCAdES") != null) {
											ConfigureUtil.initViafirmaClient();
											final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
											final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
											String tipoFirma=null;
									
											tipoFirma="Firma en formato CAdES de un Hash";
												 
											// Datos documento a firmar
											byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
											
											// Indicamos a la plataforma que deseamos firmar el fichero
											
											%>
											<div class="box">
											<h2 class="box-title">Ejemplo</h2> 
												<div class="box-content">
													<p>
														<%
														try{
															String hashOriginal = new String(org.apache.commons.codec.binary.Base64.encodeBase64(DigestUtils.sha(datosAFirmar)));
															
															//Creamos Policy y Documento
															Policy policy = new Policy();
															policy.setTypeFormatSign(TypeFormatSign.CAdES_EPES);
															policy.setTypeSign(TypeSign.DETACHED);
						    
															Documento documento = new Documento("hashSigned", hashOriginal.getBytes(), TypeFile.hash, TypeFormatSign.CAdES_EPES);
															
															// Iniciamos la firma enviando alias y pass
															String idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
															
															//Validamos la firma
															FirmaInfoViafirma info = ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidityById(idFirma, hashOriginal, TypeFormatSign.CAdES_EPES);

															%>
															<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
															<strong>Validación:</strong><%=info.isValid()?"Firma válida":"Firma NO válida"%><br/>
															<strong>Id de firma:</strong><%=idFirma%><br/>
														<%}catch(Exception e){
															%>
															<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
														<%}%>
													</p>
												</div>
											</div>											
											<%	
											}else if(request.getParameter("firmarHashXLToA")!= null) {
												ConfigureUtil.initViafirmaClient();
												final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
												final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
												String tipoFirma=null;
										
												tipoFirma="Firma en formato XADES-A de un Hash";
													 
												// Datos documento a firmar
												
												// Indicamos a la plataforma que deseamos firmar el fichero
												
												%>
												<div class="box">
												<h2 class="box-title">Ejemplo</h2> 
													<div class="box-content">
														<p>
															<%
															try{
																
															    //FIRMA _XL
															    
																//Flujo de entrada del documento original
																InputStream datosAFirmar = getClass().getResourceAsStream("/prueba.xml");
																//Flujo de entrada del documento original
																InputStream datosAFirmarParaHash = getClass().getResourceAsStream("/prueba.xml");
																MessageDigest messageDigest=MessageDigest.getInstance("SHA1");
																DigestInputStream digestInputStream=new DigestInputStream(datosAFirmarParaHash,messageDigest);
																//Leemos el digestInputStream																
																while (digestInputStream.read() != -1){}
																digestInputStream.close();
																//Realizamos un digest para solo enviar el HASH al servidor
																String hashOriginal = new String(org.apache.commons.codec.binary.Base64.encodeBase64(digestInputStream.getMessageDigest().digest()));
																//Creamos Policy y Documento
																Policy policy = new Policy();
																policy.setTypeFormatSign(TypeFormatSign.XADES_XL_ENVELOPED);
																policy.setTypeSign(TypeSign.DETACHED);
							    								Documento documento = new Documento("hashSigned", hashOriginal.getBytes(), TypeFile.hash, TypeFormatSign.XADES_XL_ENVELOPED);
																// Iniciamos la firma enviando alias y pass
																String idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
																byte[] signedXL=ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
																//Validamos la firma
																FirmaInfoViafirma info = ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidityById(idFirma, hashOriginal, TypeFormatSign.XADES_XL_ENVELOPED);
																
																
																
																
																//RESELLA CON _A
																
																//Una vez realizada la firma XADES-XL en servidor la completamos en formato XADES-A
																policy = new Policy();
																policy.setTypeFormatSign(TypeFormatSign.XADES_A_ENVELOPED);
																policy.setTypeSign(TypeSign.DETACHED);
																//Seteamos el nivel actual de la firma del documento
																policy.setPreviousTypeFormatSign(TypeFormatSign.XADES_XL_ENVELOPED);
																documento = new Documento("hashSigned", signedXL, TypeFile.hash, TypeFormatSign.XADES_A_ENVELOPED);
																//Seteamos el inpustream del documento original. El original NO viajara al servidor
																documento.setTemp(datosAFirmar);
																// Iniciamos la firma enviando alias y pass
																idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
																FirmaInfoViafirma info2 = ViafirmaClientFactory.getInstance().checkSignedHashDocumentValidityById(idFirma, hashOriginal, TypeFormatSign.XADES_A_ENVELOPED);

																%>
																<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
																<strong>Validación:</strong><%=info.isValid()?"Firma válida":"Firma NO válida"%><br/>
																<strong>Validación:</strong><%=info2.isValid()?"Firma válida":"Firma NO válida"%><br/>
																<strong>Id de firma:</strong><%=idFirma%><br/>
															<%}catch(Exception e){
																%>
																<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
															<%}%>
														</p>
													</div>
												</div>											
												<%
											}else if(request.getParameter("firmarHashXLToA_noHash")!= null) {
												ConfigureUtil.initViafirmaClient();
												final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
												final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
												String tipoFirma=null;
										
												tipoFirma="Firma en formato XADES-A de un Hash";
													 
												// Datos documento a firmar
												
												// Indicamos a la plataforma que deseamos firmar el fichero
												
												%>
												<div class="box">
												<h2 class="box-title">Ejemplo</h2> 
													<div class="box-content">
														<p>
															<%
															try{
																
															    //FIRMA _XL
															    
																//Flujo de entrada del documento original (lo creamos para reutilizar despues en el XAdES_A)
																InputStream original = getClass().getResourceAsStream("/exampleSign.pdf");
																//Flujo de entrada del documento original (se consume este inputStream al enviar a firmar)
																byte[] datosAFirmarParaXL = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
// 																MessageDigest messageDigest=MessageDigest.getInstance("SHA1");
// 																DigestInputStream digestInputStream=new DigestInputStream(datosAFirmarParaHash,messageDigest);
																//Leemos el digestInputStream																
// 																while (digestInputStream.read() != -1){}
// 																digestInputStream.close();
																//Realizamos un digest para solo enviar el HASH al servidor
// 																String hashOriginal = new String(org.apache.commons.codec.binary.Base64.encodeBase64(digestInputStream.getMessageDigest().digest()));
																//Creamos Policy y Documento
																Policy policy = new Policy();
																policy.setTypeFormatSign(TypeFormatSign.XADES_XL_ENVELOPED);
																policy.setTypeSign(TypeSign.DETACHED);
							    								Documento documento = new Documento("doc_xl.xml", datosAFirmarParaXL, TypeFile.pdf, TypeFormatSign.XADES_XL_ENVELOPED);
																// Iniciamos la firma enviando alias y pass
																String idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
																byte[] signedXL=ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
																//Validamos la firma
																boolean info = ViafirmaClientFactory.getInstance().checkSignedDetachedDocumentValidity(signedXL, datosAFirmarParaXL);
																
																
																
																
																//RESELLA CON _A
																
																//Una vez realizada la firma XADES-XL en servidor la completamos en formato XADES-A
																policy = new Policy();
																policy.setTypeFormatSign(TypeFormatSign.XADES_A_ENVELOPED);
																policy.setTypeSign(TypeSign.DETACHED);
																//Seteamos el nivel actual de la firma del documento
																policy.setPreviousTypeFormatSign(TypeFormatSign.XADES_XL_ENVELOPED);
																documento = new Documento("doc_a.xml", signedXL, TypeFile.hash, TypeFormatSign.XADES_A_ENVELOPED);
																//Seteamos el inpustream del documento original. El original NO viajara al servidor
																documento.setTemp(original);
																// Iniciamos la firma enviando alias y pass
																idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
																byte[] a_signed = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
																boolean info2 = ViafirmaClientFactory.getInstance().checkSignedDetachedDocumentValidity(a_signed, datosAFirmarParaXL);																

																%>
																<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
																<strong>Validación XL as detached:</strong><%=info?"Firma válida":"Firma NO válida"%><br/>
																<strong>Validación A as detached:</strong><%=info2?"Firma válida":"Firma NO válida"%><br/>
																<strong>Id de firma:</strong><%=idFirma%><br/>
															<%}catch(Exception e){
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
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
									<li>Policy:</li>
									<ol>
										<li>TypeFormatSign: CAdES or XAdES</li>
										<li>TypeSign.DETACHED</li>
									</ol>
									<li>Documento:</li>
									<ol>
										<li>TypeFormatSign: CAdES or XAdES</li>
										<li>TypeFile.hash</li>
									</ol>
									
									<li>checkSignedHashDocumentValidityById</li>
									<li>checkSignedHashDocumentValidity</li>
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
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="https://doc.viafirma.com/viafirma-platform/integration/">Manual de integración de viafirma platform</a> 
				</p>
				<p>
					<small>3.0.0</small>
				</p>
			</div>
		</div>
	</body>
</html>