<%@page import="org.viafirma.cliente.firma.DigestMethod"%>
<%@page import="org.viafirma.cliente.firma.SignatureAlgorithm"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.apache.xml.security.transforms.Transforms"%>
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
								<p>En este ejemplo se realiza la firma de un documento XML en formato XADES_EPES en el servidor sin la intervención directa del usuario.</p>
								<p>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.</p>
								<p class="button">
									<a href="?firmarXML">Firmar documento XML en formato XAdES en servidor</a>
								</p>
								
								<p class="button">
									<a href="?firmarXML&signNode">Firmar XML en XAdES, firmando un nodo especifico</a>
								</p>
								<p class="button">
									<a href="?ContrafirmaXADES">Contrafirmar un documento ya firmado con XAdES</a>
								</p>
								
								<p class="button">
									<a href="?firmarXMLDetached">Firma DETACHED de un documento XML con Viafirma</a>
								</p>
								
							</div>
						</div>
								<%
									if (request.getParameter("firmarXML") != null) {
										ConfigureUtil.initViafirmaClient();
										final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
										final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
										String tipoFirma=null;
								
										tipoFirma="Firma en formato XAdES de un archivo XML";
											 
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
														String idFirma;
														if (request.getParameter("signNode") == null) {
														  //Policy Implementation
				 											Policy pol = new Policy();
				 											//Definimos el tipo de formato (los formatos por defecto son enveloped, pero en el siguiente parámetro seteamos el tipo DETACHED)
															pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
				 											//Definimos la firma como DETACHED
				 											pol.setTypeSign(TypeSign.ENVELOPED);
				 											//pol.setTypeSign(TypeSign.ATTACHED);
				 											//Policy parameters definition
				 											//Document definition
				 											Documento doc = new Documento("prueba.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
				 											//Viafirma invocation
				 											idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, doc, alias, pass);
														}else{
															//Policy Implementation
				 											Policy pol = new Policy();
				 											//Definimos el tipo de formato (los formatos por defecto son enveloped, pero en el siguiente parámetro seteamos el tipo DETACHED)
															pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
				 											//Definimos la firma como DETACHED
				 											pol.setTypeSign(TypeSign.DETACHED);
				 											//Policy parameters definition
				 											//Indicamos el ID del nodo que va a ser firmado
				 											pol.addParameter(PolicyParams.NODE_ID_TO_SIGN.getKey(), "N1");
				 											//Indicamos el tipo de firma DETACHED (en este caso Internally)
				 											pol.addParameter(PolicyParams.DETACHED_TYPE.getKey(), PolicyParams.DetachedType.INTERNALLY.name());
				 											//Document definition
				 											Documento doc = new Documento("pruebaSigned.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
				 											//Viafirma invocation
				 											idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, doc, alias, pass);
														}														
														%>
														<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
														<strong>Id de firma:</strong><%=idFirma%><br/>
														<%
															byte[] signedFileBinary = ViafirmaClientFactory.getInstance().getDocumentoCustodiado(idFirma);
														%>
														<strong>Tamaño de documento firmado: </strong><%=signedFileBinary.length %> bytes<br/> 														
														<strong><a href="<%=ConfigureUtil.URL_VIAFIRMA%>/v/<%=idFirma%>?d">Descargar documento firmado</a></strong><br/>

													<%}catch(Exception e){
														%>
														<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
													<%}%>
												</p>
											</div>
										</div>
										<%	
										}else if (request.getParameter("firmarXMLDetached") != null) {
											ConfigureUtil.initViafirmaClient();
											final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
											final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
											String tipoFirma=null;
									
											tipoFirma="Firma en formato XAdES DETACHED de un archivo XML";
												 
											// Datos documento a firmar
											byte [] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
											//Creamos el documento
											Documento doc = new Documento("exampleSign.pdf",datosAFirmar,TypeFile.PDF,TypeFormatSign.XADES_EPES_ENVELOPED);

											//Seteamos la politica
											Policy pol = new Policy();
											pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
											pol.setTypeSign(TypeSign.DETACHED);
											
											// Indicamos a la plataforma que deseamos firmar el fichero
											
											%>
											<div class="box">
											<h2 class="box-title">Ejemplo</h2> 
												<div class="box-content">
													<p>
														<%
														try{
															String idFirma;
					 											//No se especifica nodo, hacemos firma normal en servidor (del nodo raiz)
																idFirma=ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol,doc,alias,pass);
					 											
														%>
															<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
															<strong>Id de firma:</strong><%=idFirma%><br/>
															<strong><a href="<%=ConfigureUtil.URL_VIAFIRMA%>/v/<%=idFirma%>?d">Descargar documento firmado</a>
														<%}catch(Exception e){
															%>
															<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
														<%}%>
													</p>
												</div>
											</div>
										<%	
											}else if(request.getParameter("ContrafirmaXADES")!=null){
												ConfigureUtil.initViafirmaClient();
												final String alias = ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
												final String pass = ConfigureUtil.CERTPASS; //Pass del certificado utilizado.
												
												String tipoFirma = "Contrafirma en formato XAdES de un archivo XML ya firmado con XAdES";
												%> 
												<div class="box">
														<h2 class="box-title">Resultado</h2> 
														<div class="box-content">
															<p>
												<%
												try{
 			 										byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/firmaXades.xml"));	
													
													List<String> firmasPreparadas = new LinkedList<String>();
													Policy pol = new Policy();
													
	//		 							        	Documento doc = new Documento("nombredoc", datosAFirmar, TypeFile.PDF, TypeFormatSign.XADES_EPES_ENVELOPED);
	//		 							        	pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
	//		 							        	pol.setTypeSign(TypeSign.ENVELOPED);
										        	
										        	Documento doc = new Documento("signed.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
										        	pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
										        	pol.setTypeSign(TypeSign.ENVELOPED);
										        	pol.addParameter(PolicyParams.XML_CANONIZATION_TRANSFORM.getKey(), Transforms.TRANSFORM_C14N_EXCL_OMIT_COMMENTS);
										        	
										        	String idFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol, doc, alias, pass);
										        	%>
										        	
																<strong>Tipo de firma:</strong><%=tipoFirma %><br/>
																<strong>Id de firma:</strong><%=idFirma%><br/>
																<strong><a href="<%=ConfigureUtil.URL_VIAFIRMA%>/v/<%=idFirma%>?d">Descargar documento firmado</a></strong>
												<%}catch(Exception e){	%>
																<strong>Se ha poducido un error en la firma:</strong><%=e.getMessage()%><br/>
												<%}%>
															</p>
														</div>
													</div>
										<%	}
															%>
					</div>
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
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