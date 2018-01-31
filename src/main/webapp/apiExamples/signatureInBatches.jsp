<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory" %>
<%@page import="org.viafirma.cliente.ViafirmaClient" %>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="java.util.List" %>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="java.util.LinkedList"%>
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
				<h2>Método <code>signByServerEnLotes</code></h2>
				
				<p>Este ejemplo muestra como firma varios documentos de distinta naturaleza en un mismo lote</p>
				<p>El método <code>signByServerEnLotes</code> firma un lote de documentos previamente inicializados e incluidos.</p>
				<p>El identificador del documento está compuesto por el identificador final del lote más el identificador particular de cada uno de los documentos asociados a este lote y que es generado en el momento de añadirlos al mismo</p>
				<p>El estandar PDF signature no permite la firma en lotes de documentos PDF.</p>
				
				<p>Recibe como paramentro:</p>
			 	<ul class="parameters">
			 		<li><code>String batchSignId</code> Codigo temporal que identifica al lote</li>
			 		<li><code>String alias</code> Alias del certificado utilizado</li>
		     		<li><code>String password</code> Password del certificado utilizado</li>
		     	</ul>
		     	
		     	<p>Devuelve:</p>
		     	<ul class="parameters">
		     		<li><code>String</code> Identificador final de la firma en lote</li>
		     	</ul>
		     	<!-- 
		     	<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
		     	<p><a href="?firmarLote">Iniciar firma en lote</a></p>
			     
				<%
				ViafirmaClient client=ViafirmaClientFactory.getInstance();
				String alias=ConfigureUtil.CERTALIAS;//Alias del certificado utilizado
				String pass=ConfigureUtil.CERTPASS; // Pass del certificado utilizado.
				
				/* Si la clase ViafirmaClientFactory no se halla inicializada procederemos a hacerlo pasándole a su correspondiente método init las distintas URLS que apuntan a los Proveedores */
				if(request.getParameter("firmarLote")!=null){
					ConfigureUtil.initViafirmaClient();
				/* Comenzamos el proceso de Firma en Lotes */
				final String idTemporalLote=client.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
				client.addDocumentoFirmaEnLote(idTemporalLote,"Documento 1",TypeFile.TXT," Documento de tipo TXT".getBytes());
				client.addDocumentoFirmaEnLote(idTemporalLote,"Documento 2",TypeFile.XML,"<p>Documento de tipo XML</p>".getBytes());
				client.addDocumentoFirmaEnLote(idTemporalLote,"Documento 3",TypeFile.PDF,"Documento de tipo PDF".getBytes());
				%>
				<div style="text-align:center;">
					<p>El codigo que identifica al lote: <%=idTemporalLote%></p>
				</div>
				<%} %>
				<p>
				<form>
					Iniciar firma de lote:<br/>
					ID LOTE: 
					<input type="text" name="idLote"></input><br/>
					<input type="hidden" name="lote"/>	
					<input type="submit" value="Añadir fichero">
				</form>
				</p>
			<%
				if(request.getParameter("lote")!=null){
				    List<String>listIdentifiersDocuments=null;
				    String idLote = request.getParameter("idLote");
					try{
						final String idFinalFirmaLote=client.signByServerEnLotes(idLote,alias,pass);
						listIdentifiersDocuments=client.getOriginalDocumentsIds(idFinalFirmaLote);
					}catch(InternalException e){
						e.printStackTrace();
						listIdentifiersDocuments=new LinkedList();
						%>
						<p>No se puede realizar la firma.<%=e.getMessage() %></p>
						<% 
				}
				
				
				/* Comenzamos el proceso de recuperación de los documentos firmados */
				%><div style="text-align:left;">
				<%	
				for (String identifierDocument:listIdentifiersDocuments){
					Documento docu = client.getOriginalDocument(identifierDocument);%>
					<p>ID: <%=docu.getId()%>
					<br/>Nombre: <%=docu.getNombre()%>
					<br/>Tamaño: <%=docu.getSize()%>
					<br/>Tipo de Documento: <%=docu.getTipo()%></p>
					
					<%}%>
				</div>
				<%}%>-->
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