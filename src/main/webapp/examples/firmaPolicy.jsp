<%@page import="java.util.Date"%>
<%@page import="com.viafirma.examples.util.BenchMarkTimeUtils"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="org.viafirma.cliente.util.Constantes"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="org.viafirma.cliente.firma.TypeFile"%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="../css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="../css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1 id="header"><a href=".."><img src="../images/content/logo.png" alt="Viafirma" /></a></h1>
			
			<div id="content">
				<h2>Firmas con Policy</h2>
				
				<p>La firma se realizará a través del applet de Viafirma, siendo necesaria la intervención del usuario para completar el proceso de firma</p>
				
				<div class="group">
					<div class="col width-99 append-01">
						<div class="box">
							<h3 class="box-title">Ejemplos de sello de firma</h3>
				
							<div class="box-content">
							<ul>
								<li>
									<a href="policy/firmarSelloGenerico.jsp">
										Firma pdf con sello genérico
									</a>
									<br/> 
										Firma de documento pdf con sello de firma generado por defecto, con texto autogenerado
										e información de validación por defecto.
								</li>
								<li>
									<a href="policy/firmarSelloGenericoText.jsp">
										Firma pdf con sello genérico añadiendo texto personalizado
									</a>
									<br/> 
										Firma de documento pdf con sello de firma generado por defecto, texto autogenerado
										e información de validación por defecto al que se le añade información de contacto, 
										localización o motivo de la firma.
								</li>
								<li>
									<a href="policy/firmarSelloSinMarca.jsp">
										Firma pdf con sello genérico sin información de la validez de la firma
									</a>
									<br/> 
										Firma de documento pdf con sello de firma generado por defecto, texto autogenerado en el que se oculta
										la información sobre la validez de la firma en el sello.
								</li>
								<li>
									<a href="policy/firmarSelloSinMarcaSinRect.jsp">
										Firma pdf con sello genérico sin información de la validez de la firma, ni datos del firmante
									</a>
									<br/> 
										Firma de documento pdf con sello de firma generado por defecto, ocultando el texto autogenerado en el que se oculta
										la información sobre la validez de la firma en el sello.
								</li>
								<li>
									<a href="policy/firmarSelloConImagen.jsp">
										Firma pdf con sello genérico con imagen de fondo
									</a>
									<br/> 
										Firma de documento pdf con sello de firma generado por defecto, con texto autogenerado en el que se oculta
										la información sobre la validez de la firma en el sello y se añade imagen de fondo al sello.
								</li>
								<li>
									<a href="policy/firmarSelloTexto.jsp">
										Firma pdf con sello genérico con texto personalizado
									</a>
									<br/> 
										Firma de documento pdf con sello que contiene el texto indicado mediante policy, en el que se pueden insertar
										marcas del tipo '[OID]' que serán sustituidos por la información contenida en el certificado.
								</li>
								<li>
									<a href="policy/firmarSelloQRBAR.jsp">
										Firma pdf con sello generado por viafirma
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, Bar Code, texto con información de la 
										firma e id de firma
								</li>
								<li>
									<a href="policy/firmarSelloTextQRBAR.jsp">
										Firma pdf con sello generado por viafirma con texto.
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, Bar Code, texto con información de la 
										firma que contiene el texto indicado mediante policy, en el que se pueden insertar marcas del tipo '[OID]' que serán sustituidos 
										por la información contenida en el certificado.
								</li>
								<li>
									<a href="policy/firmarSelloPDF417.jsp">
										Firma pdf con sello PDF417 generado por viafirma
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que solo contiene el código PDF417.
								</li>
								<li>
									<a href="policy/firmarSelloCSV.jsp">
										Firma pdf con sello generado por viafirma con URL de CSV personalizada
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, Bar Code, texto con información de la 
										firma e id de firma en el que se puede personalizar la URL de validación CSV.
								</li>
								<li>
									<a href="policy/firmarSelloRotado.jsp">
										Firma pdf con sello generado por viafirma rotado
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, Bar Code, texto con información de la 
										firma e id de firma en el que se indica como rotar el sello 90º o 270º.
								</li>
								<li>
									<a href="policy/firmarSelloTransparente.jsp">
										Firma pdf con sello generado por viafirma transparente
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, Bar Code, texto con información de la 
										firma e id de firma, en el que se indica como generar el sello con fondo transparente.
								</li>
								<li>
									<a href="policy/firmarSelloSinQRCode.jsp">
										Firma pdf con sello generado por viafirma ocultando el QRCode
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, texto con información de la 
										firma e id de firma en el que se indica como generar el sello ocultando en QRCode.
								</li>
								<li>
									<a href="policy/firmarSelloSinBarCode.jsp">
										Firma pdf con sello generado por viafirma ocultando el código de barras
									</a>
									<br/> 
										Firma de documento pdf con sello diseñado por viafirma que contiene el QRCode, texto con información de la 
										firma e id de firma en el que se indica como generar el sello ocultando el código de barras.
								</li>
								
								
								<li>
									<a href="policy/firmarSelloTodasPaginas.jsp">
										Firma pdf con sello de firma en todas las páginas del documento
									</a>
									<br/> 
										Firma de documento pdf con sello de firma en todas las páginas.
								</li>
								<li>
									<a href="policy/contraFirmaSelloPersonzalido.jsp">
										Contrafirma de documento pdf con sello
									</a>
									<br/> 
										En este ejemplo implementa la contrafirma de un documento pdf ya firmado y sellado haciendo uso del applet de Viafirma.
										Los diferentes firmantes apareceran en el nuevo sello generado
								</li>
								<li>
									<a href="policy/firmarSelloGenericoPAdES_BES.jsp">
										Firma pdf con sello genérico en PAdES_BES
									</a>
									<br/> 
										Firma de documento pdf con sello de firma generado por defecto, con texto autogenerado
										e información de validación por defecto. Se especifica por policy si incluye sellado de tiempo
										o no.
								</li>
							</ul>
						</div>
						</div>	
					</div>
				</div>
				
				<div class="group">
					<div class="col width-99 append-01">
						<div class="box">
							<h3 class="box-title">Ejemplos filtros de certificados por policy</h3>
				
							<div class="box-content">
								<ul>
									<li><a href="policy/filtroSN.jsp" >Filtro por serial number</a></li>
									<li><a href="policy/filtroCA.jsp" >Filtro por CA</a></li>
									<li><a href="policy/filtroSNyCA.jsp" >Filtro por SN y CA</a></li>
									<li><a href="policy/filtroSNyCA_operator.jsp" >Filtro por SN y CA operator</a></li>
									<li><a href="policy/genericFilter.jsp" >Filtro genérico</a></li>
<!-- 									<li><a href="policy/filtroListaFiltros.jsp" >Filtro por lista de fitros de certificado</a></li> -->
								</ul>
							</div>
						</div>	
					</div>
				</div>
				
				<div class="group">
					<div class="col width-99 append-01">
						<div class="box">
							<h3 class="box-title">Ejemplos especificando el algoritmo de firma por policy</h3>
				
							<div class="box-content">
								<ul>
									<li><a href="policy/firmarSHA1.jsp" >SHA1 con RSA</a></li>
									<li><a href="policy/firmarSHA256.jsp" >SHA256 con RSA</a></li>
									<li><a href="policy/firmarSHA384.jsp" >SHA384 con RSA</a></li>
									<li><a href="policy/firmarSHA512.jsp" >SHA512 con RSA</a></li>
								</ul>
							</div>
						</div>	
					</div>
				</div>
				
				<p>
					<a href="../index.jsp">&larr; Inicio</a>
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
	</div>
	</body>
</html>