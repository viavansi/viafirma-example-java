<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>


<%@page import="org.viafirma.cliente.exception.InternalException"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>

<%@page import="org.viafirma.cliente.ViafirmaClient"%>
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
				<h2>Método <code>addDocumentoFirmaEnLote</code></h2>
				
				<p>Añade un archivo a un lote para una firma conjunta. El método <code>addDocumentoFirmaEnLote</code> añade el archivo al lote que se le indica.</p>
				
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
					<li><code>String tempBatchCode</code> Código temporal que identifica al lote</li>
			    	<li><code>String nombreDocumento</code> Titulo del fichero</li>
			    	<li><code>TypeFile tipoFichero</code> Extension del fichero</li>
					<li><code>byte[] datos</code> Byte array de los datos del fichero</li>
				</ul>
			     
				<p>	
			     	Devuelve:
				</p>
			    
			    <ul class="parameters"> 
					<li><code>String</code> Código temporal que identifica al fichero dentro del lote</li>
				</ul>
				
				<!-- <p><a href="?addDocument" >Iniciar añadir documento</a></p>
					<%
					String tempBatchCode=null;
					String tempBatchCode2=null;
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					
					if(request.getParameter("addDocument")!=null){
					    
					}
					
					if(request.getParameter("addDocument")!=null){
					/* Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.*/
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
				
					ConfigureUtil.initViafirmaClient();
					//Iniciamos el lote indicandole el tipo de archivos que va a contener
					tempBatchCode = viafirmaClient.iniciarFirmaEnLotes(TypeFormatSign.XADES_EPES_ENVELOPED);
					%>
					<div style="text-align:center;">
						<p>El codigo que identifica al lote: <%=tempBatchCode%></p>
					</div>
					<%} %>
					<form>
						<p>
							Añadir fichero a lote:<br/>
							ID LOTE: 
							<input type="text" name="idLote"></input><br/>
							<input type="hidden" name="lote"/>	
							<input type="submit" value="Añadir fichero">
						</p>
					</form>
					
					<%
					if(request.getParameter("lote")!=null){
					    String idLote = request.getParameter("idLote");
					    byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));
					    tempBatchCode2 = viafirmaClient.addDocumentoFirmaEnLote(idLote,"prueba.xml",TypeFile.XML,datosAFirmar);
					%><p>El codigo que identifica al archivo dentro del lote despues de añadirlo:  <%=tempBatchCode2%></p>
					
					<%request.setAttribute("queryString","");
						//request.getRequestDispatcher("../apiExamples/addDocumentoFirmaEnLote.jsp").forward(request, response);
					} %>
					 -->
				<p>
					<a href="./index.jsp">&larr; Volver</a>
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