<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>

<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
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
				<h2>Método <code>getDocumentoCustodiado</code></h2>
				
				<p>El método <code>getDocumentoCustodiado</code> recibe el codigo identificador y devuelve el documento fimado.</p>
				
				<p>
					Recibe como parámetro:
				</p>
				
				<ul class="parameters">
					<li><code>String codFirma</code> Código identifica al archivo</li>
				</ul>
				
				<p>Devuelve:</p>
				<ul class="parameters">
					<li><code>Byte[]</code> Array de bytes del archivo</li>
				</ul>
				
				<!-- <br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
					<br/><br/>
					<a href="?prepareFirma" >Iniciar ejemplo de recuperacion</a>
					
						<div style="text-align:center;height:100px;">
						Cualquier proceso de firma hace uso de este metodo.<br/>
						LISTADO O ACCESO A LISTADO
						</div>
						<%
						if(request.getParameter("codigoFirma")!=null){
						 // Una vez realizada la firma recuperamos el documento firmado en servidor.
							// recuperamos el documento custodiado.
							String codFirma = request.getParameter("codFirma");
							byte [] datos=ViafirmaClientFactory.getInstance().getDocumentoCustodiado(codFirma);
							int size=datos.length;
							%>
							<p>El tamaño del archivo recuperado es: <%=size %></p>
							<p class="descarga">
									<a class="descarga" target="_blank" href="../utils/downloads.jsp?firmado&id=<%=codFirma%>" title="Descargar Documento">Descarga de documento firmado</a> 				
							</p>
							<%
							
						}
						
						
						if(request.getParameter("prepareFirma")!=null){
						/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
						ConfigureUtil.initViafirmaClient();
						
						String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
						String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
						byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
						String idFirma=null;
						int size=0;
						try{
							idFirma=ViafirmaClientFactory.getInstance().signByServerWithTypeFileAndFormatSign("prueba_byserver.xml",datosAFirmar,alias,pass,TypeFile.XML,TypeFormatSign.CMS);
							%>
							<p>El codigo de firma guardada es el: <%=idFirma %></p>
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
								Recuperar documento custodiado:<br/>
								ID FIRMA: 
								<input type="text" name="codFirma"></input><br/>
								<input type="hidden" name="codigoFirma"/>	
								<input type="submit" value="Recuperar">
							</p>
						</form>
						
					 -->	
				<p>
					<a href="./">&larr; Volver</a>
				</p>
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>