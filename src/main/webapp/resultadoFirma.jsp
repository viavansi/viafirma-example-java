<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.vo.FirmaInfoViafirma"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%><html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Examples</title>
		
		<link rel="stylesheet" href="css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href="."><img src="images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">	
				<h2>Resultado del proceso de firma</h2>

				<p>Tiempo empleado: <%=BenchMarkTimeUtils.getBenchMarkSeconds()%>s</p>
				<p><strong>Sellado de tiempo:</strong>${resultado.signTimeStamp}</p>
				<p><strong>Código de firma:</strong>${resultado.signId}</p>
				<!--  Soporte para Viafirma -->
				
				<p>
					<strong>Otros datos:</strong>
				</p>
				<%if(request.getAttribute("error")!=null ){%>
					<p>${error}. Operación cancelada</p>
				<%}else{ %>
					
					<% 
					FirmaInfoViafirma firmaInfoViafirma=(FirmaInfoViafirma)request.getAttribute("resultado");
					String[] ids=firmaInfoViafirma.getSignId().split(";");
					for(int i=0;i<ids.length;i++){
						String id=ids[i];
					//for(String id:ids){
// 						FirmaInfoViafirma firmaInfo = viafirmaClient.getSignInfo(id);
						Map map = firmaInfoViafirma.getProperties();
						ArrayList caName;
						if(map.get("caName") instanceof ArrayList){
							caName = (ArrayList)map.get("caName");
						}else{
							caName = new ArrayList();
							caName.add(map.get("caName"));
						}
						if( caName == null){
					%>
<!-- 					<table> -->
<!-- 							<tr><th class="width-20">First Name</th><td>${resultado.properties.firstName}</td></tr> -->
<!-- 							<tr><th class="width-20">Last Name</th><td>${resultado.properties.lastName}</td></tr> -->
<!-- 							<tr><th class="width-20">Number User Id</th><td>${resultado.properties.numberUserId}</td></tr> -->
<!-- 							<tr><th class="width-20">E-mail</th><td>${resultado.properties.email}</td></tr> -->
<!-- 							<tr><th class="width-20">Ca Name</th><td>${resultado.properties.caName}</td></tr> -->
<!-- 							<tr><th class="width-20">Oids</th><td>${resultado.properties.oids}</td></tr> -->
<!-- 							<tr><th class="width-20">Type Certificate</th><td>${resultado.properties.typeCertificate}</td></tr> -->
<!-- 							<tr><th class="width-20">Type Legal</th><td>${resultado.properties.typeLegal}</td></tr> -->
<!-- 					</table> -->
					<%							
						}else if(caName.size() > 0 && caName.get(0) != null){
					%>
					
					<table>
							<tr><th class="width-20">First Name</th><td>${resultado.properties.firstName}</td></tr>
							<tr><th class="width-20">Last Name</th><td>${resultado.properties.lastName}</td></tr>
							<tr><th class="width-20">Number User Id</th><td>${resultado.properties.numberUserId}</td></tr>
							<tr><th class="width-20">E-mail</th><td>${resultado.properties.email}</td></tr>
							<tr><th class="width-20">Ca Name</th><td>${resultado.properties.caName}</td></tr>
							<tr><th class="width-20">Oids</th><td>${resultado.properties.oids}</td></tr>
							<tr><th class="width-20">Type Certificate</th><td>${resultado.properties.typeCertificate}</td></tr>
							<tr><th class="width-20">Type Legal</th><td>${resultado.properties.typeLegal}</td></tr>
							<%if(firmaInfoViafirma.getProperties().get("politics_default_url") != null){ %>
								<tr><th class="width-20">Url Policy</th><td><a href="<%=firmaInfoViafirma.getProperties().get("politics_default_url")%>"><%=firmaInfoViafirma.getProperties().get("politics_default_url")%></a></td></tr>
							<%} %>
					</table>
					<%} %>
					
					<p class="codBarras">
						<img alt="Imagen QR de justificante del resultado de la firma del fichero" width="500" src="<%=ConfigureUtil.getViafirmaServer() %>/downloadComprobanteQR?codFirma=<%=id%>&amp;tipo=png" title="Imagen QR de justificante del resultado de la firma del fichero" />
					</p>
				
<!-- 					<p class="ValidarFirma"> -->
<%-- 						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>" title="Validar Firma">Validar Firma</a> 				 --%>
<!-- 					</p> -->
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>?j" title="Descargar Comprobante">Descarga de comprobante de firma</a> 				
					</p>
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="<%=ConfigureUtil.getViafirmaServer()%>/v/<%=id%>?d" title="Descargar Documento firmado">Descarga de documento firmado</a> 				
					</p>	
					<p class="descargaComprobante">
						<a class="descarga" target="_blank" href="utils/downloads.jsp?original&id=<%=id%>" title="Descargar Documento original">Descarga de documento original</a> 				
					</p>
						
						<%
							if(session.getAttribute("idMultifirma")!=null){
								String idMultifirma = (String)session.getAttribute("idMultifirma");
								session.removeAttribute("idMultifirma");
						%>	
							<p class="multifirma">
								Para volver a firmar este fichero siga este enlace:
								<a href="examples/firmaUsuario/firmarTexto.jsp?firmarTexto&&idMultifirma=<%=idMultifirma %>" title="Volver a firmar con otro firmante">Volver a firmar el fichero con otro firmante</a>
							</p>
						<%
							}	
						}
						%>
					<%
					}
					%>
				<p>
					<a href="index.jsp">&larr; Inicio</a>
				</p> 
			</div>
			<div id="footer">
				<p class="left">
					Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte más información técnica en <a href="http://developers.viafirma.com/">Viafirma Developers</a> 
				</p>
				<p>
					<a href="apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
				</p>
			</div>
		</div>
	</body>
</html>