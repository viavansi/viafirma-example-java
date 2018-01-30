package com.viafirma.examples.util;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

/**
 * Servlet implementation class ViafirmaCallbackServlet.
 * Example: http://localhost:8080/ejemploViafirma/ViafirmaCallbackServlet?documentId=P6D4LQ2961363781422399&appKey=undefined&rnd=-8920485755815925821
 */
public class ViafirmaCallbackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String documentId=request.getParameter("documentId");
		//String appKey=request.getParameter("appKey");
		byte [] data=IOUtils.toByteArray(request.getInputStream());
		String pem=new String(data);
		System.out.println("Data PEM:"+ pem); // cert
		
		byte [] dataToSign=getDataToSign(request,documentId);
		response.getOutputStream().write(dataToSign);// data to sign
	}

	private byte[] getDataToSign(HttpServletRequest request, String documentId) {
		return "data".getBytes();
	}

}
