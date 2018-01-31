<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory" %>
<%@page import="org.viafirma.cliente.ViafirmaClient" %>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="java.util.List" %>
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
				<h2>Método <code>getOriginalDocumentsIds</code></h2>
				
				<p>El método <code>getOriginalDocumentsIds</code> recibe el codigo identificador del lote y devuelve un listado de los ids de los documentos.</p>
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
					<li><code>String codFirmaLotes</code> Código identifica al lote</li>
				</ul>
				
				<p>Devuelve:</p>
				
				<ul class="parameters">
					<li><code>List&lt;String&gt;</code> Lista con los distintos identificadores de los documentos</li>
				</ul>
			
			      <!-- 
					<br>Para su correcto funcionamiento el certificado debe estar instalado en el servidor.<br/>
					<br/>
			
						Cualquier proceso del listado hace uso de este metodo.<br/>
						LISTADO O ACCESO A LISTADO
						<p><a href="?lote" >Generar codigo ejemplo de lote</a></p>
						
					<%
				ViafirmaClient client=ViafirmaClientFactory.getInstance();
				/* Si la clase ViafirmaClientFactory no se halla inicializada procederemos a hacerlo pasándole a su correspondiente método init las distintas URLS que apuntan a los Proveedores */
				if(request.getParameter("lote")!=null){
				
					ConfigureUtil.initViafirmaClient();
					
				String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
				String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
				
				/* Comenzamos el proceso de Firma en Lotes */
				String idFinalFirmaLote="";
				final String idTemporalLote=client.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
				client.addDocumentoFirmaEnLote(idTemporalLote,"Documento 1",TypeFile.TXT,"Documento de tipo TXT".getBytes());
				client.addDocumentoFirmaEnLote(idTemporalLote,"Documento 2",TypeFile.XML,"<p>Documento de tipo XML</p>".getBytes());
				client.addDocumentoFirmaEnLote(idTemporalLote,"Documento 3",TypeFile.PDF,"Documento de tipo PDF".getBytes());
				List<String>listIdentifiersDocuments=null;
				try{
					idFinalFirmaLote=client.signByServerEnLotes(idTemporalLote,alias,pass);
				}catch(InternalException e){
					e.printStackTrace();
					%>
					<p>No se puede realizar la firma.<%=e.getMessage() %></p>
					<% 
				}
				%>El codigo de lote de ejemplo es: <%=idFinalFirmaLote%>
			<%}%>
			
			<form action="#">
				Recuperar los documentos originales del lote firmado:<br/>
				ID LOTE:<input type="text" name="id"></input><br/>
				<input type="hidden" name="getinfo"/>	
				<input type="submit">
			</form>
				<%
				
			    if(request.getParameter("id")!=null){
				 // Una vez realizada la firma recuperamos el documento firmado en servidor.
					// recuperamos el documento custodiado.
					String idFinalFirmaLote = request.getParameter("id");
					List<String>listIdentifiersDocuments=null;
					listIdentifiersDocuments=client.getOriginalDocumentsIds(idFinalFirmaLote);
					/* Comenzamos el proceso de recuperación de los documentos firmados */
				
				for (String identifierDocument:listIdentifiersDocuments){
					Documento docu = client.getOriginalDocument(identifierDocument);%>
					<p>ID: <%=docu.getId()%></p>
					<p>Nombre: <%=docu.getNombre()%></p>
					<p>Tamaño: <%=docu.getSize()%></p>
					<p>Tipo de Documento: <%=docu.getTipo()%></p>
				<%}
				}%>-->
				
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