<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

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
				<h2>Método <code>xadesAResign</code></h2>
				
				<p>El método <code>xadesAResign</code> vuelve a firmar con formato XADES A un documento firmado con XADES XL.</p>   
				
				<p>
					Con este metodo se permitira que un documento firmado con formato XADES XL actualice su encriptacion volviendo a ser firmado con formato XADES A.
				</p>
				<p>
					Tras preparar el documento, se le pasa el id temporal generado al metodo para habilitar la multifirma.
					El String que devuelve es el nuevo id del documento, este será utilizado para referenciar al archivo en proximas firmas. 
				</p>
				<p>
					Recibe como paramentro:
				</p>
				
				<ul class="parameters">
			 		<li><code>byte[] documento</code> Byte array del documento firmado con XADES XL</li>
			 	</ul>
				
				<p>Devuelve:</p>
			 	<ul class="parameters">
			 		<li><code>byte[]</code> Byte array del documento firmado con XADES A</li>
				</ul>
				<%
				if (request.getParameter("xadesAResign") != null) {
					//Firma el documento de ejemplo con el certificado indicado en el alias devolviendo el ID de la firma.
					String alias=ConfigureUtil.CERTALIAS;// Alias del certificado utilizado
					String pass=ConfigureUtil.CERTPASS;// Pass del certificado utilizado.
					
					ConfigureUtil.initViafirmaClient();
					ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
					
		    		String idFirmaServidor=request.getParameter("id");
		    		byte[] documento=viafirmaClient.getDocumentoCustodiado(idFirmaServidor);
		    		documento=viafirmaClient.xadesAResign(documento);
		    %>		
		   		<p class="descarga">
					<a class="descarga" target="_blank" href="../utils/downloads.jsp?firmado&id=<%=idFirmaServidor%>" title="Descargar documento refirmado">Descargar documento refirmado</a> 				
				</p>
				<%
		    		response.setContentType("text/xml");
		    		response.setHeader("Content-Disposition","attachment;filename="+"xadesA.xml");
		    	    response.setContentLength( documento.length );
		    		InputStream in = new ByteArrayInputStream(documento);
		    		ServletOutputStream outputStream = response.getOutputStream();
		    		byte[] outputByte = new byte[4096];
		    		//copy binary contect to output stream
		    		while(in.read(outputByte, 0, 4096) != -1)
		    		{
		    			outputStream.write(outputByte, 0, 4096);
		    		}
		    		in.close();
		    		outputStream.flush();
		    		outputStream.close();
		    		
		    	}
					    
					    
					    
					%>  <!--
					<form action="#">
							<p>
						    	Refirmar en XADES-A:<br/>
						    	ID:<br/><input type="text" name="id"></input><br/>
						    	<input type="hidden" name="xadesAResign"/>	
						    	<input type="submit">
					    	</p>	
					    </form>
				
				
					<div style="text-align:center;height:100px;">
					<p><a href="?firmar">Iniciar firma de varios documentos</a></p>
					</div>
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