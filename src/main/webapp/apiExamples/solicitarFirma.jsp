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
				<h2>Método <code>solicitarFirmar</code></h2>
				
				<p class="message">
				<strong>NO</strong> es posible realizar un lote en pdf de archivos pdf.
				</p>
				
				<p>El método <code>solicitarFirmar</code> envía al usuario a la pantalla de firma donde se cargara el Applet de firma.</p>   
				
				<p>
					Recibe como paramentro:
				</p>
				<ul class="parameters">
					<li><code>String idFirma</code> Código temporal que identifica al archivo</li>
			     	<li><code>HttpServletRequest request</code> Request</li>
			     	<li><code>HttpServletResponse response</code> Response</li>
		     		<li><code>String uriRetorno</code> [Opcional] Direccion de retorno cuando termine el proceso de firma</li>
				</ul>
			<!--			<div style="text-align:center;height:100px;">-->
			<!--			Cualquier proceso de firma hace uso de este metodo.-->
			<!--			LISTADO O ACCESO A LISTADO-->
			<!--			</div>-->
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