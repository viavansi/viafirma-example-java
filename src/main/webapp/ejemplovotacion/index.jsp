<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Viafirma - Kit para desarrolladores</title>
		
		<link rel="stylesheet" href="css/framework.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/styles.css" type="text/css" media="screen" />
	</head>
	<body>
		<div id="wrapper">
			<h1>Viafirma Vote</h1>
			
			<div id="content">
				<p>Aplicación de ejemplo que muestra como crear un sistema de votación de actas.</p>
				
				<form action="resultadoVotacion.jsp">
					<h2>Responda a la siguiente votación:</h2>
					
					<p class="box">
						<label><input type="radio" name="respuesta" value="true" checked="checked"> Si, deseo votar a favor del siguiente <a target="_blank" href="exampleSign.pdf">Acta</a></label>
						<label><input type="radio" name="respuesta" value="false"> No, estoy en contra</label>
						<label><input type="radio" name="respuesta" value="toAbstain"> Me abstengo de votar</label>
					</p>
					
					<p class="buttons">
						<input type="submit" class="button" value="Votar" />
					</p>
				</form>
				<p>
					<a href="../index.jsp">&larr; Volver</a>
				</p> 
			</div>
		</div>
	</body>
</html>