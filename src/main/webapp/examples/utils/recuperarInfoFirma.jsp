<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
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
				<h2>Recupera información de una firma</h2>
				
				<div class="group">
					<div class="col width-53 append-02">
						<div class="box">
							<h3 class="box-title">Recuperar información firma</h3>
							<div class="box-content">
								<p>En este ejemplo se realiza la firma de un documento y se recupera la información relativa a la firma.</p>
								
								<p><a class="button" href="?prepareFirma">Recuperar información firma</a></p>
							</div>
						</div>
								<%
								if (request.getParameter("prepareFirma") != null) {
									ConfigureUtil.initViafirmaClient();
								
									String alias=ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
									String pass=ConfigureUtil.CERTPASS; // pass del certificado utilizado.
									ViafirmaClient viafirmaClient=ViafirmaClientFactory.getInstance();
								
									// Realizamos la firma de un documento
									byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
									String idFirma=null;
									int size=0;
									try{
									    Policy policy = new Policy();
										TypeFormatSign format = TypeFormatSign.CMS;
										    
										policy.setTypeFormatSign(format);
										policy.setTypeSign(TypeSign.ENVELOPED);

										Documento documento = new Documento("prueba_by_server.xml", datosAFirmar, TypeFile.XML, format); 
										idFirma = ViafirmaClientFactory.getInstance().signByServerWithPolicy(policy, documento, alias, pass);
									   
										
									}catch(InternalException e){
										e.printStackTrace();
										%>
										<p>No se puede realizar la firma.<%=e.getMessage() %></p>
										<% 
									}
									// Recuperamos la información del la firma
									FirmaInfoViafirma info=viafirmaClient.getSignInfo(idFirma);
								
								%>
								<div class="box">
										<h2 class="box-title">Ejemplo</h2> 
										<div class="box-content">
											<p><strong>¿Es válido?:</strong><%=info.getValid() %></p>
											<p><strong>Firmante:</strong><%=info.getFirstName() %></p>		
											<p><strong>CA:</strong><%=info.getCaName() %></p>
											<p><strong>IdFirma:</strong><%=info.getSignId() %></p>
										</div>
								</div>
								<%}%>
					</div>
					
					<div class="col width-45">
						<div class="box">
							<h3 class="box-title">Métodos utilizados</h3>
							<div class="box-content">
								<ul>
									<li><code>signByServerWithTypeFileAndFormatSign</code></li>
									<li><code>getSignInfo</code></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<p><a href="../../index.jsp">&larr; Inicio</a></p>
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