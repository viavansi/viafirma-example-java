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
									byte[] datosAComprobar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
									String alias= ConfigureUtil.CERTALIAS;
									String pass= ConfigureUtil.CERTPASS;
									String codFirma = viafirmaClient.signByServerWithTypeFileAndFormatSign("temp2.xml",datosAComprobar,alias,pass,TypeFile.XML,TypeFormatSign.XADES_EPES_ENVELOPED);
									byte[] datosFirmados = viafirmaClient.getDocumentoCustodiado(codFirma);
									// Enviamos a Viafirma el documento firmado y el identificador de la firma generado
									FirmaInfoViafirma info=viafirmaClient.checkDocumentSigned(datosFirmados,codFirma);
									%>
									<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
										<div class="box-content">
											<p><strong>¿Es válido?:</strong><%=info.getValid()%><br/></p>
											<p><strong>Firmante:</strong><%=info.getFirstName()%><br/></p>
											<p><strong>CA:</strong><%=info.getCaName()%><br/></p>
											<p><strong>IdFirma:</strong><%=info.getSignId()%></p>
										</div>
									</div>
								<%}%>
					</div>
					
					<div class="col width-40">
						<div class="box">
							<h3 class="box-title">Metodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li>signByServerWithTypeFileAndFormatSign</li>
									<li>getDocumentoCustodiado</li>
									<li>checkDocumentSigned</li>
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