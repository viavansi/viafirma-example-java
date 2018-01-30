<%
if (request.getParameter("selloB64") != null) {
	String datosSellados = request.getParameter("selloB64");
	response.setContentLength(datosSellados.getBytes().length);
	response.setHeader("Content-Disposition", "attachment;filename=fichero_sellado.txt");
	//write the byte array to the o/p stream.
	response.getOutputStream().write(datosSellados.getBytes());
}else{
	out.println("Se ha producido un error en la descarga");
}
%>