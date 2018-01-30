<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
					<h2>Método <code>getSignInfo</code></h2>
					
					<p>El método <code>getSignInfo</code> devuelve información sobre una firma.</p>
					
					<p>
						Recibe como paramentro:
					</p>
					<ul class="parameters">
						<li><code>String codFirma</code> Código identifica al archivo</li>
					</ul>
					
					<p>Devuelve:<p>
					<ul class="parameters">
						<li><code>FirmaInfoViafirma</code> Objeto FirmaInfoViafirma con toda la información de la firma</li>
					</ul>
							<!-- <br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
							<br/>
							<a href="?prepareFirma" >Generar id firma</a>
							
					
					<%
						ConfigureUtil.initViafirmaClient();
						if (request.getParameter("prepareFirma") != null) {
							String alias=ConfigureUtil.CERTALIAS; //Alias del certificado utilizado
							String pass=ConfigureUtil.CERTPASS; // pass del certificado utilizado.
							byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
							String idFirma=null;
							int size=0;
							try{
								idFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("prueba_by_server.xml",datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.CMS);
								%>
								<p>El codigo genererado es: <%=idFirma %></p>
								<%
								
							}catch(InternalException e){
								e.printStackTrace();
								%>
								<p>No se puede realizar la firma.<%=e.getMessage() %></p>
								<% 
							}
						}
					%>
						
						<form action="#">
						<p>
							Recuperar información del documento firmado:<br/>
							ID:<input type="text" name="id"></input><br/>
							<input type="hidden" name="getinfo"/>	
							<input type="submit">
						</p>
						</form>
					
						
					<%
						if (request.getParameter("getinfo") != null) {
							ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
							String idFirma=request.getParameter("id");
					
							FirmaInfoViafirma info=viafirmaClient.getSignInfo(idFirma);
							request.setAttribute("info",info);
						
						%>
						<div style="text-align:left;">
						<p><strong>¿Es válido?:</strong>${info.valid} </p>
						<p><strong>Firmante:</strong>${info.firstName} </p>		
						<p><strong>CA:</strong>${info.caName} </p>
						<p><strong>IdFirma:</strong>${info.signId} </p>
						</div>
						<%}%>-->
						
				<p>
					<a href="./">&larr; Volver</a>
				</p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../">Listado de ejemplos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>