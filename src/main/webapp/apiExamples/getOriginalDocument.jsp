<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
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
				<h2>Método <code>getOriginalDocument</code></h2>
				
				<p>El método <code>getOriginalDocument</code> recibe el codigo identificador y devuelve el documento original.</p>
				
				<p>
					Recibe como paramentro:
				</p>
				<ul class="parameters">
					<li><code>String signId</code> Código identifica a la transaccion</li>
				</ul>
				
				<p>
					Devuelve:
				</p>
				<ul class="parameters">
					<li><code>Documento</code> Documento original firmado en la transaccion indicada.</li>
				</ul>
		<!--	<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
				<p><a href="?prepareFirma" >Iniciar ejemplo de recuperacion</a></p>
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
					Recuperar original del documento firmado:<br/>
					ID:<input type="text" name="id"></input><br/>
					<input type="hidden" name="getinfo"/>	
					<input type="submit">
				</p>
			</form>
			
		<%
			ConfigureUtil.initViafirmaClient();
		
		
			if (request.getParameter("getinfo") != null) {
				ViafirmaClient viafirmaClient = ViafirmaClientFactory
						.getInstance();
				
				String idFirma=request.getParameter("id");
				
				// Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
				Documento original=viafirmaClient.getOriginalDocument(idFirma);
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename="+original.getNombre());
				ServletOutputStream ouputStream = response.getOutputStream();
				ouputStream.write(original.getDatos());
				ouputStream.flush();
				ouputStream.close();
			}
		%>
		 -->
				<p>
					<a href="./">&larr; Volver</a>
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