<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.viafirma.cliente.vo.Documento"%>
<%@page import="org.viafirma.cliente.ViafirmaClient"%>
<%@page import="com.viafirma.examples.util.ConfigureUtil"%>
<%@page import="org.viafirma.cliente.ViafirmaClientFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	ConfigureUtil.initViafirmaClient();


	if (request.getParameter("original") != null) {
		ViafirmaClient client=ViafirmaClientFactory.getInstance();
		String id=request.getParameter("id");
		Documento documento=client.getOriginalDocument(id);
		response.setContentType(documento.getTipo().getMimetype());
		response.setHeader("Content-Disposition","attachment;filename="+documento.getNombre());
	     response.setContentLength( documento.getDatos().length );
		
		InputStream in = new ByteArrayInputStream(documento.getDatos());
		
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
	
	if (request.getParameter("firmado") != null) {
		ViafirmaClient client=ViafirmaClientFactory.getInstance();
		String id=request.getParameter("id");
		Documento docu = client.getOriginalDocument(id);
		byte[] documento=client.getDocumentoCustodiado(id);
		response.setContentType(docu.getTipo().getMimetype());
		response.setHeader("Content-Disposition","attachment;filename="+docu.getNombre());
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
	
	if(session.getAttribute("documento")!=null){
// 		String sDoc = request.getParameter("documento");
		byte[] documento = (byte[])session.getAttribute("documento");
		response.setContentType("xml");
		response.setHeader("Content-Disposition","attachment;filename=example.xml");
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
	
	/*if (request.getParameter("firmado") != null) {
	ViafirmaClient client=ViafirmaClientFactory.getInstance();
	String id=request.getParameter("id");
	byte[] documento=client.getDocumentoCustodiado(id);
	response.setContentType(documento.getTipo().getMimetype());
	response.setHeader("Content-Disposition","attachment;filename="+documento.getNombre());
     response.setContentLength( documento.getDatos().length );
	
	InputStream in = new ByteArrayInputStream(documento.getDatos());
	
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

	}*/
	%>
</body>
</html>