<%-- <%@page import="org.viafirma.cliente.util.PolicyParams"%> --%>
<%@page import="org.apache.xml.security.utils.Base64"%>
<%@page import="org.viafirma.cliente.firma.DigestMethod"%>
<%@page import="org.viafirma.cliente.firma.SignatureAlgorithm"%>
<%@page import="org.viafirma.cliente.util.OptionalRequest"%>
<%@page import="org.viafirma.cliente.vo.UsuarioGenericoViafirma"%>
<%@page import="org.viafirma.cliente.firma.Policy"%>
<%@page import="org.viafirma.cliente.firma.TypeSign"%>
<%@page import="org.viafirma.cliente.util.PolicyParams"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%-- <%@page import="org.viafirma.cliente.firma.TypeSign"%> --%>
<%@page import="org.viafirma.cliente.firma.TypeFormatSign"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%-- <%@page import="org.viafirma.cliente.firma.Policy"%> --%>
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
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Viafirma - Kit para desarrolladores</title>

<link rel="stylesheet" href="../../css/framework.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="../../css/styles.css" type="text/css"
	media="screen" />
</head>
<body>
	<div id="wrapper">
		<h1 id="header">
			<a href="../../"><img src="../../images/content/logo.png"
				alt="Viafirma" /></a>
		</h1>

		<div id="content">
			<h2>Firmas con intervención del usuario</h2>

			<div class="group">
				<div class="col width-53 append-02">
					<div class="box">
						<h3 class="box-title">Firma XML</h3>
						<div class="box-content">
							<p>En este ejemplo se realiza la firma de un documento XML
								con formato XAdES_EPES en Viafirma con la intervención directa
								del usuario.</p>

							<p class="button">
								<a href="?firmarXML">Firma XAdES de documento XML con
									Viafirma</a>
							</p>

							<p class="button">
								<a href="?firmarXML&signNode">Firmar XML en XAdES, firmando
									un nodo especifico</a>
							</p>
							<p class="button">
								<a href="?firmarXMLDsigDetached">Firmar PDF en XMLDSIG
									detached</a>
							</p>
							<p class="button">
								<a href="?ContrafirmaXADES">Contrafirmar un documento ya
									firmado con XAdES</a>
							</p>
							<p class="button">
								<a href="?internallyXADES">XAdES internally detached
									previamente construida sobre el fichero de contenido</a>
							</p>
							<p class="button">
								<a href="?counterSignature=true&XADES_EPES_ENVELOPED=true">Contrafirma
									de documento xml en base64 en formato XADES_EPES_ENVELOPED</a>
							</p>

							<%
							    ConfigureUtil.initViafirmaClient();
							    if (request.getParameter("counterSignature") != null && request.getParameter("XADES_EPES_ENVELOPED") != null) {

							        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();

							        String contentB64 = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjxlbmlleHA6ZXhwZWRpZW50ZSB4bWxuczpkcz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnIyIgeG1sbnM6ZW5pY29uZXhwaW5kPSJodHRwOi8vYWRtaW5pc3RyYWNpb25lbGVjdHJvbmljYS5nb2IuZXMvRU5JL1hTRC92MS4wL2V4cGVkaWVudGUtZS9pbmRpY2UtZS9jb250ZW5pZG8iIHhtbG5zOmVuaWRvYz0iaHR0cDovL2FkbWluaXN0cmFjaW9uZWxlY3Ryb25pY2EuZ29iLmVzL0VOSS9YU0QvdjEuMC9kb2N1bWVudG8tZSIgeG1sbnM6ZW5pZG9jbWV0YT0iaHR0cDovL2FkbWluaXN0cmFjaW9uZWxlY3Ryb25pY2EuZ29iLmVzL0VOSS9YU0QvdjEuMC9kb2N1bWVudG8tZS9tZXRhZGF0b3MiIHhtbG5zOmVuaWRzPSJodHRwOi8vYWRtaW5pc3RyYWNpb25lbGVjdHJvbmljYS5nb2IuZXMvRU5JL1hTRC92MS4wL2Zpcm1hIiB4bWxuczplbmlleHA9Imh0dHA6Ly9hZG1pbmlzdHJhY2lvbmVsZWN0cm9uaWNhLmdvYi5lcy9FTkkvWFNEL3YxLjAvZXhwZWRpZW50ZS1lIiB4bWxuczplbmlleHBpbmQ9Imh0dHA6Ly9hZG1pbmlzdHJhY2lvbmVsZWN0cm9uaWNhLmdvYi5lcy9FTkkvWFNEL3YxLjAvZXhwZWRpZW50ZS1lL2luZGljZS1lIiB4bWxuczplbmlleHBtZXRhPSJodHRwOi8vYWRtaW5pc3RyYWNpb25lbGVjdHJvbmljYS5nb2IuZXMvRU5JL1hTRC92MS4wL2V4cGVkaWVudGUtZS9tZXRhZGF0b3MiIHhtbG5zOmVuaWZpbGU9Imh0dHA6Ly9hZG1pbmlzdHJhY2lvbmVsZWN0cm9uaWNhLmdvYi5lcy9FTkkvWFNEL3YxLjAvZG9jdW1lbnRvLWUvY29udGVuaWRvIiB4bWxuczp4c2k9Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvWE1MU2NoZW1hLWluc3RhbmNlIiBJZD0iSURfRVhQXzAxIiB4c2k6c2NoZW1hTG9jYXRpb249Imh0dHA6Ly9hZG1pbmlzdHJhY2lvbmVsZWN0cm9uaWNhLmdvYi5lcy9FTkkvWFNEL3YxLjAvZXhwZWRpZW50ZS1lIj4gIA0KICA8ZW5pZXhwaW5kOmluZGljZSBJZD0iSURYX0VYUF8wMSI+IA0KICAgIDxlbmlleHBpbmQ6SW5kaWNlQ29udGVuaWRvIElkPSJJRFhfSUNfMDEiPiANCiAgICAgIDxlbmljb25leHBpbmQ6RmVjaGFJbmRpY2VFbGVjdHJvbmljbz4yMDExLTAxLTEyVDA5OjMwOjQ3WjwvZW5pY29uZXhwaW5kOkZlY2hhSW5kaWNlRWxlY3Ryb25pY28+ICANCiAgICAgICAgDQogICAgICA8ZW5pY29uZXhwaW5kOkRvY3VtZW50b0luZGl6YWRvPiANCiAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPkVTX0UwMDAxMDIwN18yMDEwX01QUjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDIwMTwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JEb2N1bWVudG8+ICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpWYWxvckh1ZWxsYT5jNzIzYmUxOWJiMjI5MWY4ZDU1ZDZhYWQwYzA3YTc1NTgwMWVkZmYzPC9lbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+ICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpGdW5jaW9uUmVzdW1lbj5TSEEtMTwvZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPiAgDQogICAgICAgIDxlbmljb25leHBpbmQ6RmVjaGFJbmNvcnBvcmFjaW9uRXhwZWRpZW50ZT4yMDExLTAxLTEyVDA5OjMwOjQ3WjwvZW5pY29uZXhwaW5kOkZlY2hhSW5jb3Jwb3JhY2lvbkV4cGVkaWVudGU+IA0KICAgICAgPC9lbmljb25leHBpbmQ6RG9jdW1lbnRvSW5kaXphZG8+ICANCiAgICAgICAgDQogICAgICA8ZW5pY29uZXhwaW5kOkRvY3VtZW50b0luZGl6YWRvPiANCiAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPkVTX0UwMDAxMDIwN18yMDEwX01QUjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDIwMjwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JEb2N1bWVudG8+ICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpWYWxvckh1ZWxsYT5mZjIwZjEzNDI5NzhmMTI5NWExYTYwY2YzMmI1NjM3NjNjY2ZjOTBjPC9lbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+ICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpGdW5jaW9uUmVzdW1lbj5TSEEtMTwvZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPiAgDQogICAgICAgIDxlbmljb25leHBpbmQ6RmVjaGFJbmNvcnBvcmFjaW9uRXhwZWRpZW50ZT4yMDExLTAxLTEyVDA5OjMwOjQ3WjwvZW5pY29uZXhwaW5kOkZlY2hhSW5jb3Jwb3JhY2lvbkV4cGVkaWVudGU+IA0KICAgICAgPC9lbmljb25leHBpbmQ6RG9jdW1lbnRvSW5kaXphZG8+ICANCiAgICAgICAgDQogICAgICA8ZW5pY29uZXhwaW5kOkV4cGVkaWVudGVJbmRpemFkbz4gDQogICAgICAgIDxlbmljb25leHBpbmQ6RmVjaGFJbmRpY2VFbGVjdHJvbmljbz4yMDEwLTEyLTEyVDA5OjMwOjQ3WjwvZW5pY29uZXhwaW5kOkZlY2hhSW5kaWNlRWxlY3Ryb25pY28+ICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpEb2N1bWVudG9JbmRpemFkbz4gDQogICAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPkVTX0UwMDAxMDIwN18yMDEwX01QUjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDIwMzwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JEb2N1bWVudG8+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOlZhbG9ySHVlbGxhPjY1NWNmMTgwYzc4OWMwN2Y1Y2MyYmJhIDBiNzNiNTQxYWJiOTcyZWRiPC9lbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPlNIQS0xPC9lbmljb25leHBpbmQ6RnVuY2lvblJlc3VtZW4+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZlY2hhSW5jb3Jwb3JhY2lvbkV4cGVkaWVudGU+MjAxMC0xMC0xMVQwOTozMDo0N1o8L2VuaWNvbmV4cGluZDpGZWNoYUluY29ycG9yYWNpb25FeHBlZGllbnRlPiANCiAgICAgICAgPC9lbmljb25leHBpbmQ6RG9jdW1lbnRvSW5kaXphZG8+ICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpEb2N1bWVudG9JbmRpemFkbz4gDQogICAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPkVTX0UwMDAxMDIwN18yMDEwX01QUjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDIwNDwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JEb2N1bWVudG8+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOlZhbG9ySHVlbGxhPjkyN2M3ODM3NTlmZTQxM2YxMTAgY2ZhZmQ0ZDk4OGFiZWNmMmZkNjMyPC9lbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPlNIQS0xPC9lbmljb25leHBpbmQ6RnVuY2lvblJlc3VtZW4+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZlY2hhSW5jb3Jwb3JhY2lvbkV4cGVkaWVudGU+MjAxMC0xMS0xOFQwOTozMDo0N1o8L2VuaWNvbmV4cGluZDpGZWNoYUluY29ycG9yYWNpb25FeHBlZGllbnRlPiANCiAgICAgICAgPC9lbmljb25leHBpbmQ6RG9jdW1lbnRvSW5kaXphZG8+IA0KICAgICAgPC9lbmljb25leHBpbmQ6RXhwZWRpZW50ZUluZGl6YWRvPiAgDQogICAgICAgIA0KICAgICAgPGVuaWNvbmV4cGluZDpDYXJwZXRhSW5kaXphZGE+IA0KICAgICAgICA8ZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JDYXJwZXRhPkVTX0UwMDAyNTE4NV8yMDEwIF9DUlAwMDA3MDAyPC9lbmljb25leHBpbmQ6SWRlbnRpZmljYWRvckNhcnBldGE+ICANCiAgICAgICAgICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpEb2N1bWVudG9JbmRpemFkbz4gDQogICAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPkVTX0UwMDAxMDIwN18yMDEwX01QUjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDIwNTwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JEb2N1bWVudG8+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOlZhbG9ySHVlbGxhPjI4MDIxYTI1NmUxOTFmOWEwZiA4ZDhlNmQwNWU3YmVjOTc4OTYzZThlPC9lbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPlNIQS0xPC9lbmljb25leHBpbmQ6RnVuY2lvblJlc3VtZW4+ICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZlY2hhSW5jb3Jwb3JhY2lvbkV4cGVkaWVudGU+MjAxMC0xMC0xMVQwOTozMDo0N1o8L2VuaWNvbmV4cGluZDpGZWNoYUluY29ycG9yYWNpb25FeHBlZGllbnRlPiANCiAgICAgICAgPC9lbmljb25leHBpbmQ6RG9jdW1lbnRvSW5kaXphZG8+ICANCiAgICAgICAgICANCiAgICAgICAgPGVuaWNvbmV4cGluZDpFeHBlZGllbnRlSW5kaXphZG8+IA0KICAgICAgICAgIDxlbmljb25leHBpbmQ6RmVjaGFJbmRpY2VFbGVjdHJvbmljbz4yMDEwLTEyLTEyVDA5OjMwOjQ3WjwvZW5pY29uZXhwaW5kOkZlY2hhSW5kaWNlRWxlY3Ryb25pY28+ICANCiAgICAgICAgICAgIA0KICAgICAgICAgIDxlbmljb25leHBpbmQ6RG9jdW1lbnRvSW5kaXphZG8+IA0KICAgICAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPkVTX0UwMDAxMDIwN18yMDEwX01QUjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAxMDIwNjwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JEb2N1bWVudG8+ICANCiAgICAgICAgICAgIDxlbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+MjU1ZjY3MGM5OWVhYjc1MDAgZGI2MDUwZGUyZTE5MWI1MmFmNWRmMjY8L2VuaWNvbmV4cGluZDpWYWxvckh1ZWxsYT4gIA0KICAgICAgICAgICAgPGVuaWNvbmV4cGluZDpGdW5jaW9uUmVzdW1lbj5TSEEtMTwvZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPiAgDQogICAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZlY2hhSW5jb3Jwb3JhY2lvbkV4cGVkaWVudGU+MjAxMC0xMC0xMVQwOTozMDo0N1o8L2VuaWNvbmV4cGluZDpGZWNoYUluY29ycG9yYWNpb25FeHBlZGllbnRlPiANCiAgICAgICAgICA8L2VuaWNvbmV4cGluZDpEb2N1bWVudG9JbmRpemFkbz4gDQogICAgICAgIDwvZW5pY29uZXhwaW5kOkV4cGVkaWVudGVJbmRpemFkbz4gIA0KICAgICAgICAgIA0KICAgICAgICA8ZW5pY29uZXhwaW5kOkNhcnBldGFJbmRpemFkYT4gDQogICAgICAgICAgPGVuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yQ2FycGV0YT5FU19FMDAwMjUxIDg1XzIwMTBfQ1JQMDAwNzAwMzwvZW5pY29uZXhwaW5kOklkZW50aWZpY2Fkb3JDYXJwZXRhPiAgDQogICAgICAgICAgICANCiAgICAgICAgICA8ZW5pY29uZXhwaW5kOkV4cGVkaWVudGVJbmRpemFkbz4gDQogICAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZlY2hhSW5kaWNlRWxlY3Ryb25pY28+MjAxMC0xMi0xMlQwOTozMDo0N1o8L2VuaWNvbmV4cGluZDpGZWNoYUluZGljZUVsZWN0cm9uaWNvPiAgDQogICAgICAgICAgICAgIA0KICAgICAgICAgICAgPGVuaWNvbmV4cGluZDpEb2N1bWVudG9JbmRpemFkbz4gDQogICAgICAgICAgICAgIDxlbmljb25leHBpbmQ6SWRlbnRpZmljYWRvckRvY3VtZW50bz5FU19FMDAwMTAyMDdfMjAxMF9NUFIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMTAyMDc8L2VuaWNvbmV4cGluZDpJZGVudGlmaWNhZG9yRG9jdW1lbnRvPiAgDQogICAgICAgICAgICAgIDxlbmljb25leHBpbmQ6VmFsb3JIdWVsbGE+NjE3YWYwOGJlYTkxMmU5IDI3MzFmZDI2NTMyZGI2ZWI0M2ExOGY5NGY8L2VuaWNvbmV4cGluZDpWYWxvckh1ZWxsYT4gIA0KICAgICAgICAgICAgICA8ZW5pY29uZXhwaW5kOkZ1bmNpb25SZXN1bWVuPlNIQS0xPC9lbmljb25leHBpbmQ6RnVuY2lvblJlc3VtZW4+ICANCiAgICAgICAgICAgICAgPGVuaWNvbmV4cGluZDpGZWNoYUluY29ycG9yYWNpb25FeHBlZGllbnRlPjIwMTAtMTAtMTFUMDk6MzA6NDdaPC9lbmljb25leHBpbmQ6RmVjaGFJbmNvcnBvcmFjaW9uRXhwZWRpZW50ZT4gDQogICAgICAgICAgICA8L2VuaWNvbmV4cGluZDpEb2N1bWVudG9JbmRpemFkbz4gDQogICAgICAgICAgPC9lbmljb25leHBpbmQ6RXhwZWRpZW50ZUluZGl6YWRvPiANCiAgICAgICAgPC9lbmljb25leHBpbmQ6Q2FycGV0YUluZGl6YWRhPiANCiAgICAgIDwvZW5pY29uZXhwaW5kOkNhcnBldGFJbmRpemFkYT4gDQogICAgPC9lbmlleHBpbmQ6SW5kaWNlQ29udGVuaWRvPiAgDQogICAgPGVuaWRzOmZpcm1hcz4gDQogICAgICA8ZW5pZHM6ZmlybWE+IA0KICAgICAgICA8ZW5pZHM6VGlwb0Zpcm1hPlRGMDM8L2VuaWRzOlRpcG9GaXJtYT4gIA0KICAgICAgICA8ZW5pZHM6Q29udGVuaWRvRmlybWE+IA0KICAgICAgICAgIDxlbmlkczpGaXJtYUNvbkNlcnRpZmljYWRvPjxkczpTaWduYXR1cmUgeG1sbnM6eGE9Imh0dHA6Ly91cmkuZXRzaS5vcmcvMDE5MDMvdjEuMy4yIyIgSWQ9InNpZ25hdHVyZWFlc19xZ2cwMGZiaHAxNDk2MDYxNTYyNTExIj4NCjxkczpTaWduZWRJbmZvPg0KPGRzOkNhbm9uaWNhbGl6YXRpb25NZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy14bWwtYzE0bi0yMDAxMDMxNSI+PC9kczpDYW5vbmljYWxpemF0aW9uTWV0aG9kPg0KPGRzOlNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNyc2Etc2hhMSI+PC9kczpTaWduYXR1cmVNZXRob2Q+DQo8ZHM6UmVmZXJlbmNlIElkPSJSZWZlcmVuY2UtSURYX0lDXzAxIiBVUkk9IiNJRFhfSUNfMDEiPg0KPGRzOlRyYW5zZm9ybXM+DQo8ZHM6VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiPjwvZHM6VHJhbnNmb3JtPg0KPGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnL1RSLzIwMDEvUkVDLXhtbC1jMTRuLTIwMDEwMzE1Ij48L2RzOlRyYW5zZm9ybT4NCjwvZHM6VHJhbnNmb3Jtcz4NCjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSI+PC9kczpEaWdlc3RNZXRob2Q+DQo8ZHM6RGlnZXN0VmFsdWU+b3F3bFk1MUozcS9QRFc4TTlnR1NVNUZWY0h3PTwvZHM6RGlnZXN0VmFsdWU+DQo8L2RzOlJlZmVyZW5jZT4NCjxkczpSZWZlcmVuY2UgVVJJPSIjS2V5SW5mb2Flc19xZ2cwMGZiaHAxNDk2MDYxNTYyNTExIj4NCjxkczpUcmFuc2Zvcm1zPg0KPGRzOlRyYW5zZm9ybSBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnL1RSLzIwMDEvUkVDLXhtbC1jMTRuLTIwMDEwMzE1Ij48L2RzOlRyYW5zZm9ybT4NCjwvZHM6VHJhbnNmb3Jtcz4NCjxkczpEaWdlc3RNZXRob2QgQWxnb3JpdGhtPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjc2hhMSI+PC9kczpEaWdlc3RNZXRob2Q+DQo8ZHM6RGlnZXN0VmFsdWU+b0ZTNHZDK1JxUFFhZHZDbWdkYWVpVTBVWFAwPTwvZHM6RGlnZXN0VmFsdWU+DQo8L2RzOlJlZmVyZW5jZT4NCjxkczpSZWZlcmVuY2UgVHlwZT0iaHR0cDovL3VyaS5ldHNpLm9yZy8wMTkwMyNTaWduZWRQcm9wZXJ0aWVzIiBVUkk9IiNTaWduZWRQcm9wZXJ0aWVzYWVzX3FnZzAwZmJocDE0OTYwNjE1NjI1MTEiPg0KPGRzOlRyYW5zZm9ybXM+DQo8ZHM6VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiPjwvZHM6VHJhbnNmb3JtPg0KPC9kczpUcmFuc2Zvcm1zPg0KPGRzOkRpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyNzaGExIj48L2RzOkRpZ2VzdE1ldGhvZD4NCjxkczpEaWdlc3RWYWx1ZT5rbHhOajJ6algxVDZRVUxlbE92NDRjNzdnOTg9PC9kczpEaWdlc3RWYWx1ZT4NCjwvZHM6UmVmZXJlbmNlPg0KPC9kczpTaWduZWRJbmZvPg0KPGRzOlNpZ25hdHVyZVZhbHVlIElkPSJTaWduYXR1cmVWYWx1ZWFlc19xZ2cwMGZiaHAxNDk2MDYxNTYyNTExIj4NCmdqZEpMT090QkdwT3lIMVJpSnRKbHZCQ3BISXRMenNhYWlkVkJUbkluN3laZkJ5VUc2RENmMGx6RnA5cG1kODV3Q3VUR3FDNmdkdncNCmpvYWNtWGYwc2ZqSGZCWlhhcEJibXZ1cVF3eGNUVkY0WkRTWC83V005MEtUSG0wUjNvZkZ4bWc5MERYUWtIeUJTTkZOZy9xMnY0bGsNClU1aVZMSFN0ZjBmOUZnLzJQRlVEQlkydTJBWXFmK01HdWlkVUNiSzM5SU9vUE9FakhGNFduazY3SllKRmlFeEF2QUhUNjFSRzREOXUNCklMdzFGT01uL1dFYkRmTDRBcVdlTTdnNFlwTXpKUHdYMldCSTVpUkcxczUrdUhINFJGUDBOalNxYUlnQnk1alJrVlAvNGZaMXROdnINClBlWWlvanRwV2J2UUVwa3lOUGJoM2d1UG5ZZlFnU0NkelBWWWNRPT0NCjwvZHM6U2lnbmF0dXJlVmFsdWU+DQo8ZHM6S2V5SW5mbyBJZD0iS2V5SW5mb2Flc19xZ2cwMGZiaHAxNDk2MDYxNTYyNTExIj4NCjxkczpYNTA5RGF0YT4NCjxkczpYNTA5Q2VydGlmaWNhdGU+DQpNSUlIVERDQ0JqU2dBd0lCQWdJUUNRS1puNFNHeXFWWUljbWphL3FrbVRBTkJna3Foa2lHOXcwQkFRc0ZBREJMTVFzd0NRWURWUVFHDQpFd0pGVXpFUk1BOEdBMVVFQ2d3SVJrNU5WQzFTUTAweERqQU1CZ05WQkFzTUJVTmxjbVZ6TVJrd0Z3WURWUVFEREJCQlF5QkdUazFVDQpJRlZ6ZFdGeWFXOXpNQjRYRFRFMk1URXdPREV5TkRnek5Wb1hEVEl3TVRFd09ERXlORGd6TlZvd2dZVXhDekFKQmdOVkJBWVRBa1ZUDQpNUmd3RmdZRFZRUUZFdzlKUkVORlV5MDVPVGs1T1RrNU9WSXhFREFPQmdOVkJDb01CMUJTVlVWQ1FWTXhHakFZQmdOVkJBUU1FVVZKDQpSRUZUSUVORlVsUkpSa2xEUVVSUE1TNHdMQVlEVlFRRERDVkZTVVJCVXlCRFJWSlVTVVpKUTBGRVR5QlFVbFZGUWtGVElDMGdPVGs1DQpPVGs1T1RsU01JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBdnJhTHczTkRsQ2h1ODEzS3hnbkIyNTBSDQpjUE55UlFpTVRpMCt1OThOcmlkRGdEMWdjbnFQU1pEVTZiQS9hZXhUVFh0cXpac2RxR0NHS1lvQzVZaCtqQ252KzFPOEN2dEZDT29VDQp2U3BCZlhiZ1FkQmhyNjN1bnpvQ29yVldMR2hjZEx4dG9jYnNpLzhxWS9jYnBCR1NXK0k5WVZMRlEwdWFScDU4Sm9abUFhQ0lOU0h1DQpOaHR5blRqRVV1bmpXcmdmQ09mOGVrS1BabFVUYm9nMEppZSt1WHZCdzBXWVdNc1lOREo1d3FIYXJSNm1veG12QzVOakhLdE9teWs2DQo0ZTZRbE5BZEtBWnFyV0I5VnVodTRyZklBUTJvTWhBczlZZXFna1BDaVJTTVZoS3lPSG1ZVlRDZ1BzYzZjd2w3a20wUCtWdEhsT1BTDQoxbTcrQkJ1WUVjZlFrd0lEQVFBQm80SUQ3ekNDQStzd2dZWUdBMVVkRVFSL01IMkJFMlZxWlcxd2JHOUFaWGhoYlhCc1pTNWpiMjJrDQpaakJrTVJnd0ZnWUpLd1lCQkFHc1pnRUVEQWs1T1RrNU9UazVPVkl4R2pBWUJna3JCZ0VFQWF4bUFRTU1DME5GVWxSSlJrbERRVVJQDQpNUlF3RWdZSkt3WUJCQUdzWmdFQ0RBVkZTVVJCVXpFV01CUUdDU3NHQVFRQnJHWUJBUXdIVUZKVlJVSkJVekFNQmdOVkhSTUJBZjhFDQpBakFBTUE0R0ExVWREd0VCL3dRRUF3SUY0REFkQmdOVkhTVUVGakFVQmdnckJnRUZCUWNEQkFZSUt3WUJCUVVIQXdJd0hRWURWUjBPDQpCQllFRktwOVE4aS9XK2U2b2UrTnZsbHpIUWFLMXp2d01COEdBMVVkSXdRWU1CYUFGTEhVVDhRamVmcEVCUW5HNnpuUDZEV3d1Q0JrDQpNSUdDQmdnckJnRUZCUWNCQVFSMk1IUXdQUVlJS3dZQkJRVUhNQUdHTVdoMGRIQTZMeTl2WTNOd2RYTjFMbU5sY25RdVptNXRkQzVsDQpjeTl2WTNOd2RYTjFMMDlqYzNCU1pYTndiMjVrWlhJd013WUlLd1lCQlFVSE1BS0dKMmgwZEhBNkx5OTNkM2N1WTJWeWRDNW1ibTEwDQpMbVZ6TDJObGNuUnpMMEZEVlZOVkxtTnlkRENCNlFZRFZSMGdCSUhoTUlIZU1JSFFCZ29yQmdFRUFheG1Bd29CTUlIQk1Da0dDQ3NHDQpBUVVGQndJQkZoMW9kSFJ3T2k4dmQzZDNMbU5sY25RdVptNXRkQzVsY3k5a2NHTnpMekNCa3dZSUt3WUJCUVVIQWdJd2dZWU1nWU5EDQpaWEowYVdacFkyRmtieUJqZFdGc2FXWnBZMkZrYnk0Z1UzVnFaWFJ2SUdFZ2JHRnpJR052Ym1ScFkybHZibVZ6SUdSbElIVnpieUJsDQplSEIxWlhOMFlYTWdaVzRnYkdFZ1JGQkRJR1JsSUd4aElFWk9UVlF0VWtOTklDaERMMHB2Y21kbElFcDFZVzRnTVRBMkxUSTRNREE1DQpMVTFoWkhKcFpDMUZjM0JodzdGaEtUQUpCZ2NFQUl2c1FBRUFNSUc2QmdnckJnRUZCUWNCQXdTQnJUQ0JxakFJQmdZRUFJNUdBUUV3DQpDd1lHQkFDT1JnRURBZ0VQTUJNR0JnUUFqa1lCQmpBSkJnY0VBSTVHQVFZQk1Id0dCZ1FBamtZQkJUQnlNRGNXTVdoMGRIQnpPaTh2DQpkM2QzTG1ObGNuUXVabTV0ZEM1bGN5OXdaSE12VUVSVFFVTlZjM1ZoY21sdmMxOWxjeTV3WkdZVEFtVnpNRGNXTVdoMGRIQnpPaTh2DQpkM2QzTG1ObGNuUXVabTV0ZEM1bGN5OXdaSE12VUVSVFFVTlZjM1ZoY21sdmMxOWxiaTV3WkdZVEFtVnVNSUcwQmdOVkhSOEVnYXd3DQpnYWt3Z2FhZ2dhT2dnYUNHZ1oxc1pHRndPaTh2YkdSaGNIVnpkUzVqWlhKMExtWnViWFF1WlhNdlkyNDlRMUpNT0RjNExHTnVQVUZEDQpKVEl3Ums1TlZDVXlNRlZ6ZFdGeWFXOXpMRzkxUFVORlVrVlRMRzg5Ums1TlZDMVNRMDBzWXoxRlV6OWpaWEowYVdacFkyRjBaVkpsDQpkbTlqWVhScGIyNU1hWE4wTzJKcGJtRnllVDlpWVhObFAyOWlhbVZqZEdOc1lYTnpQV05TVEVScGMzUnlhV0oxZEdsdmJsQnZhVzUwDQpNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUJlNnBsMDgzZFJwSlAvaWtDbzF2MGhRVzlkYXNBd3ZWRGtmM0FLQ1JWbUMxNU1GcjhSDQpTTmN4VDA3UmZLQmgzOWxwTzZOQ1FKUEdwU3ZJZm8rK0k2UFVMTGUvT05mK1ppbGZ6UlhnQ21pSklQa0NJdmlOWWtaMEdkaEdZMlhUDQo2bTBCaTdxSlBKMnpiMzJBa1dBOEtDbWhvak42bFRPU0VJRnhpaGlpVnJPdmZUeFBqd3BTYTd0U09OWm5aN3pzVGNQbmF1MWtzRVlVDQoxZ1c1VTRYSDFhY3RKTG5uSDNzSnBhT05zcjJXeDZUZzN3RWZrTURRaDNLM1FZME1DeEZwMjVTRXlCbFlTMlQ3K0daWG5nalV0WUJTDQpCTUd2QjZmNEZpbGhUS3AwS3lSRU1DSlNVUkFNREErT3plUmxoOGhFdTZBYSt0VEFkbkRHY2tybzB1MCtZekpPDQo8L2RzOlg1MDlDZXJ0aWZpY2F0ZT4NCjwvZHM6WDUwOURhdGE+DQo8ZHM6S2V5VmFsdWU+DQo8ZHM6UlNBS2V5VmFsdWU+DQo8ZHM6TW9kdWx1cz4NCkFMNjJpOE56UTVRb2J2TmR5c1lKd2R1ZEVYRHpja1VJakU0dFBydmZEYTRuUTRBOVlISjZqMG1RMU9td1AybnNVMDE3YXMyYkhhaGcNCmhpbUtBdVdJZm93cDcvdFR2QXI3UlFqcUZMMHFRWDEyNEVIUVlhK3Q3cDg2QXFLMVZpeG9YSFM4YmFIRzdJdi9LbVAzRzZRUmtsdmkNClBXRlN4VU5MbWthZWZDYUdaZ0dnaURVaDdqWWJjcDA0eEZMcDQxcTRId2puL0hwQ2oyWlZFMjZJTkNZbnZybDd3Y05GbUZqTEdEUXkNCmVjS2gycTBlcHFNWnJ3dVRZeHlyVHBzcE91SHVrSlRRSFNnR2FxMWdmVmJvYnVLM3lBRU5xRElRTFBXSHFvSkR3b2tVakZZU3NqaDUNCm1GVXdvRDdIT25NSmU1SnREL2xiUjVUajB0WnUvZ1FibUJISDBKTT0NCjwvZHM6TW9kdWx1cz4NCjxkczpFeHBvbmVudD5BUUFCPC9kczpFeHBvbmVudD4NCjwvZHM6UlNBS2V5VmFsdWU+DQo8L2RzOktleVZhbHVlPg0KPC9kczpLZXlJbmZvPg0KPGRzOk9iamVjdD48eGE6UXVhbGlmeWluZ1Byb3BlcnRpZXMgVGFyZ2V0PSIjc2lnbmF0dXJlYWVzX3FnZzAwZmJocDE0OTYwNjE1NjI1MTEiPjx4YTpTaWduZWRQcm9wZXJ0aWVzIElkPSJTaWduZWRQcm9wZXJ0aWVzYWVzX3FnZzAwZmJocDE0OTYwNjE1NjI1MTEiPjx4YTpTaWduZWRTaWduYXR1cmVQcm9wZXJ0aWVzPjx4YTpTaWduaW5nVGltZT4yMDE3LTA1LTI5VDE0OjQwOjM1Ljk0MCswMjowMDwveGE6U2lnbmluZ1RpbWU+PHhhOlNpZ25pbmdDZXJ0aWZpY2F0ZT48eGE6Q2VydD48eGE6Q2VydERpZ2VzdD48ZHM6RGlnZXN0TWV0aG9kIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI3NoYTEiPjwvZHM6RGlnZXN0TWV0aG9kPjxkczpEaWdlc3RWYWx1ZT5EMWxrWG9VekNWaWVycGxsMHVZRDF3dEcxd2M9PC9kczpEaWdlc3RWYWx1ZT48L3hhOkNlcnREaWdlc3Q+PHhhOklzc3VlclNlcmlhbD48ZHM6WDUwOUlzc3Vlck5hbWU+Q049QUMgRk5NVCBVc3VhcmlvcyxPVT1DZXJlcyxPPUZOTVQtUkNNLEM9RVM8L2RzOlg1MDlJc3N1ZXJOYW1lPjxkczpYNTA5U2VyaWFsTnVtYmVyPjExOTc2NTUyNDAyNzQzNDg1MzA5MzM0NjY1NzAyOTA0ODY1OTQ1PC9kczpYNTA5U2VyaWFsTnVtYmVyPjwveGE6SXNzdWVyU2VyaWFsPjwveGE6Q2VydD48L3hhOlNpZ25pbmdDZXJ0aWZpY2F0ZT48L3hhOlNpZ25lZFNpZ25hdHVyZVByb3BlcnRpZXM+PHhhOlNpZ25lZERhdGFPYmplY3RQcm9wZXJ0aWVzPjx4YTpEYXRhT2JqZWN0Rm9ybWF0IE9iamVjdFJlZmVyZW5jZT0iI1JlZmVyZW5jZS1JRFhfSUNfMDEiPjx4YTpEZXNjcmlwdGlvbj48L3hhOkRlc2NyaXB0aW9uPjx4YTpNaW1lVHlwZT50ZXh0L3htbDwveGE6TWltZVR5cGU+PC94YTpEYXRhT2JqZWN0Rm9ybWF0PjwveGE6U2lnbmVkRGF0YU9iamVjdFByb3BlcnRpZXM+PC94YTpTaWduZWRQcm9wZXJ0aWVzPjwveGE6UXVhbGlmeWluZ1Byb3BlcnRpZXM+PC9kczpPYmplY3Q+DQo8L2RzOlNpZ25hdHVyZT48L2VuaWRzOkZpcm1hQ29uQ2VydGlmaWNhZG8+IA0KICAgICAgICA8L2VuaWRzOkNvbnRlbmlkb0Zpcm1hPiANCiAgICAgIDwvZW5pZHM6ZmlybWE+IA0KICAgIDwvZW5pZHM6ZmlybWFzPiANCiAgPC9lbmlleHBpbmQ6aW5kaWNlPiAgDQogIDxlbmlleHBtZXRhOm1ldGFkYXRvc0V4cD4NCiAgICA8ZW5pZXhwbWV0YTpWZXJzaW9uTlRJPmh0dHA6Ly9hZG1pbmlzdHJhY2lvbmVsZWN0cm9uaWNhLmdvYi5lcy9FTkkvWFNEL3YxLjAvZXhwZWRpZW50ZS1lPC9lbmlleHBtZXRhOlZlcnNpb25OVEk+DQogICAgPGVuaWV4cG1ldGE6SWRlbnRpZmljYWRvcj5FU19MMTI5MDY3MjRfMjAxNl9FWFBfOTk5OTAwMDAwMDAwMDAwMEVYUEVESUVOVEUtMTA1PC9lbmlleHBtZXRhOklkZW50aWZpY2Fkb3I+DQogICAgPGVuaWV4cG1ldGE6T3JnYW5vPjE8L2VuaWV4cG1ldGE6T3JnYW5vPg0KICAgIDxlbmlleHBtZXRhOkZlY2hhQXBlcnR1cmFFeHBlZGllbnRlPjIwMTYtMDYtMTBUMDE6MTA6MTEuMDAwKzAyOjAwPC9lbmlleHBtZXRhOkZlY2hhQXBlcnR1cmFFeHBlZGllbnRlPg0KICAgIDxlbmlleHBtZXRhOkNsYXNpZmljYWNpb24+RGVub21pbmFjae+/vW4gZGUgbGEgQ2xhc2U8L2VuaWV4cG1ldGE6Q2xhc2lmaWNhY2lvbj4NCiAgICA8ZW5pZXhwbWV0YTpFc3RhZG8+RTAzPC9lbmlleHBtZXRhOkVzdGFkbz4gICAgICAgICAgDQogIDwvZW5pZXhwbWV0YTptZXRhZGF0b3NFeHA+DQo8L2VuaWV4cDpleHBlZGllbnRlPg==";
							        byte[] content = Base64.decode(contentB64);
							        String filename = "Expediente.xml";
							        try {

							            ViafirmaClient client = ViafirmaClientFactory.getInstance();

							            Documento doc = null;
							            Policy pol = new Policy();
							            pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
							            pol.setTypeSign(TypeSign.ENVELOPED);
							            pol.addParameter(PolicyParams.ENVELOPED_TARGET_NODE.getKey(),
							                    "//*[local-name()='indice']/*[local-name()='firmas']/*[local-name()='firma']/*[local-name()='ContenidoFirma']/*[local-name()='FirmaConCertificado']"); //nodo destino de la firma
							            //ocultar de la aplicacion ver documento y smartcard

							            // Se preparan 4 documentos para ser firmados.
							            List<String> firmasPreparadas = new LinkedList<String>();
							            doc = new Documento(filename, content, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
							            firmasPreparadas.add(client.prepareSignWithPolicy(pol, doc));

							            client.solicitarFirmasIndependientes(firmasPreparadas, request, response, "/viafirmaClientResponseServlet");
							        } catch (Exception e) {
							            e.printStackTrace();
							        }

							    } else if (request.getParameter("firmarXML") != null) {
							        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();

							        // Datos documento a firmar
							        byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/prueba.xml"));

							        // Indicamos a la plataforma que deseamos firmar el fichero
							        String idFirma = "";
							        if (request.getParameter("signNode") == null) {
							            Policy pol = new Policy();
							            //Policy basics
							            pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
							            pol.setTypeSign(TypeSign.ENVELOPED);
							            //Document definition
							            Documento doc = new Documento("pruebaSigned.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
							            //Viafirma invocation
							            idFirma = ViafirmaClientFactory.getInstance().prepareSignWithPolicy(pol, doc);

							        } else {
							            //Policy Implementation (new)
							            Policy pol = new Policy();
							            //Policy basics
							            pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
							            pol.setTypeSign(TypeSign.DETACHED);
							            //Policy parameters definition
							            pol.addParameter(PolicyParams.NODE_ID_TO_SIGN.getKey(), "N1");
							            pol.addParameter(PolicyParams.DETACHED_TYPE.getKey(), PolicyParams.DetachedType.INTERNALLY.name());
							            //Document definition
							            Documento doc = new Documento("pruebaSigned.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
							            //Viafirma invocation
							            idFirma = ViafirmaClientFactory.getInstance().prepareSignWithPolicy(pol, doc);

							        }

							        // Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
							        viafirmaClient.solicitarFirma(idFirma, request, response, "/viafirmaClientResponseServlet");

							    } else if (request.getParameter("firmarXMLDsigDetached") != null) {
							        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
							        // Datos documento a firmar
							        byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/test.pdf"));
							        //Creamos el documento
							        Documento doc = new Documento("pruebaXMLDsig.pdf", datosAFirmar, TypeFile.PDF, TypeFormatSign.XMLDSIG);
							        //Seteamos la politica
							        Policy pol = new Policy();
							        pol.setTypeFormatSign(TypeFormatSign.XMLDSIG);
							        pol.setTypeSign(TypeSign.DETACHED);
							        Map<String, String> params = new HashMap<String, String>();
							        params.put(PolicyParams.DETACHED_REFERENCE_URL.getKey(), "www.viafirma.com");
							        //Parametros parámetros de politica
							        pol.setParameters(params);
							        // Indicamos a la plataforma que deseamos firmar el fichero
							        String idFirma = viafirmaClient.prepareSignWithPolicy(pol, doc);
							        // Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
							        viafirmaClient.solicitarFirma(idFirma, request, response, "/viafirmaClientResponseServlet");
							    } else if (request.getParameter("ContrafirmaXADES") != null) {
							        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();
							        byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/firmaXadesAfirma.xml"));

							        List<String> firmasPreparadas = new LinkedList<String>();
							        Policy pol = new Policy();

							        Documento doc = new Documento("signed.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
							        pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
							        pol.setTypeSign(TypeSign.ENVELOPED);

							        // Indicamos a la plataforma que deseamos firmar el fichero
							        String idPreparado = viafirmaClient.prepareSignWithPolicy(pol, doc);

							        firmasPreparadas.add(idPreparado);

							        viafirmaClient.solicitarFirmasIndependientes(firmasPreparadas, request, response, "/viafirmaClientResponseServlet");
							    } else if (request.getParameter("internallyXADES") != null) {
							        ViafirmaClient viafirmaClient = ViafirmaClientFactory.getInstance();

							        try {
							            byte[] datosAFirmar = IOUtils.toByteArray(getClass().getResourceAsStream("/XAdESinternally.xml"));

							            Policy pol = new Policy();

							            Documento doc = new Documento("signed.xml", datosAFirmar, TypeFile.XML, TypeFormatSign.XADES_EPES_ENVELOPED);
							            pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);
							            pol.setTypeSign(TypeSign.DETACHED);

							            //Definimos el tipo de formato (los formatos por defecto son enveloped, pero en el siguiente parámetro seteamos el tipo DETACHED)
							            pol.setTypeFormatSign(TypeFormatSign.XADES_EPES_ENVELOPED);

							            //Definimos la firma como DETACHED
							            pol.setTypeSign(TypeSign.DETACHED);

							            //Policy parameters definition
							            //Indicamos el ID del nodo que va a ser firmado
							            pol.addParameter(PolicyParams.NODE_ID_TO_SIGN.getKey(), "N1");
							            pol.addParameter(PolicyParams.SIGN_BINARY_NODE_CONTENT.getKey(), "true");
							            pol.addParameter(PolicyParams.BINARY_NODE_CONTENT_MIME_TYPE.getKey(), TypeFile.pdf.name());

							            //Indicamos el tipo de firma DETACHED (en este caso Internally)
							            pol.addParameter(PolicyParams.DETACHED_TYPE.getKey(), PolicyParams.DetachedType.INTERNALLY.name());

							            //Prueba de idioma
							            pol.addParameter(PolicyParams.CLIENT_LOCALE.getKey(), "en-EN");

							            String idFirma = viafirmaClient.prepareSignWithPolicy(pol, doc);
							            // Iniciamos la firma enviando al usuario a Viafirma indicando la uri de retorno.
							            viafirmaClient.solicitarFirma(idFirma, request, response, "/viafirmaClientResponseServlet");
							        } catch (Exception e) {
							            e.printStackTrace();
							        }
							    }
							%>
						</div>
					</div>
				</div>

				<div class="col width-45">
					<div class="box">
						<h3 class="box-title">Métodos utilizados</h3>
						<div class="box-content">
							<ul>
								<li><code>prepareSignWithPolicy</code></li>
								<li><code>solicitarFirma</code></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<p>
				<a href="../firmaUsuario.jsp">&larr; Volver</a>
			</p>
		</div>
		<div id="footer">
			<p class="left">
				Acceda a <a href="http://www.viafirma.com">Viafirma</a> o consulte
				más información técnica en <a href="http://developers.viafirma.com/">Viafirma
					Developers</a>
			</p>
			<p>
				<a href="../../apiExamples/">Listado de métodos</a> - <small>2.14.1</small>
			</p>
		</div>
	</div>
</body>
</html>