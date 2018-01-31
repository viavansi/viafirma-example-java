<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%-- <%@page import="org.viafirma.cliente.firma.TypeSign"%> --%>
<%-- <%@page import="org.viafirma.cliente.firma.Policy"%> --%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
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
				<h2>Verificación de un documento firmado</h2>
				
				<div class="group">
					<div class="col width-58 append-02">
						<div class="box">
							<h3 class="box-title">Verificar que el documento está firmado</h3>
							
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento y se recupera el documento custodiado para posteriormente verificar su firma.</p>
								
								<p><a class="button" href="?check">Verificar documento de prueba</a></p>
							</div>
						</div>
								<%
								if(request.getParameter("check")!=null){
							
									if (!ViafirmaClientFactory.isInit()){
										ViafirmaClientFactory.init(
												ConfigureUtil.getViafirmaServer(),
												ConfigureUtil.getViafirmaServerWS(),
												ConfigureUtil.getApiKey(),
												ConfigureUtil.getApiPass());
									}
									ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
// 									byte[] datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/exampleSign.pdf"));
									byte[] datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
									String alias= ConfigureUtil.CERTALIAS;
									String pass= ConfigureUtil.CERTPASS;
									
									
									//Creamos el documento
// 									Documento doc = new Documento("exampleSign.pdf",datosAComprobar,TypeFile.PDF,TypeFormatSign.XADES_EPES_ENVELOPED);
									Documento doc = new Documento("prueba.xml",datosAComprobar,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);


									//Seteamos la politica
									Policy pol = new Policy();
									pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
									pol.setTypeSign(TypeSign.DETACHED);
// 									//Parametros de politica
// // 									Map<String,String> params = new HashMap<String, String>();
// // 									params.put(PolicyParams.DETACHED_REFERENCE_URL.getKey(), "/home/viavansi/git/ejemploViafirma/src/main/resources/");
// // 									pol.setParameters(params);
									
									
									String codFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(pol,doc,alias,pass);
									byte[] datosFirmados = viafirmaClient.getDocumentoCustodiado(codFirma);
									
// 									// Enviamos a Viafirma el documento firmado y el identificador de la firma generado
									Boolean valido = viafirmaClient.checkSignedDetachedDocumentValidity(datosFirmados,datosAComprobar);
									
									String message = "";
									if(valido){
										message = "La firma es válida y corresponde al documento original";
									}else{
										message = "Se han producido errores en la validación, la firma NO es válida";
									}
									%>
									<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
										<div class="box-content">
											<p><strong>IdFirma:</strong><%=codFirma%></p>
											<p><strong>¿Es válido?:</strong>  <%=message%>  <br/></p>
										</div>
									</div>
								<%}%>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Metodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithPolicy</li>
									<li>getDocumentoCustodiado</li>
									<li>checkSignedDetachedDocumentValidity</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Volver</a></p>
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