package com.viafirma.examples;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.viafirma.cliente.ViafirmaClientServlet;
import org.viafirma.cliente.exception.CodigoError;
import org.viafirma.cliente.vo.FirmaInfoViafirma;
import org.viafirma.cliente.vo.UsuarioGenericoViafirma;

import com.viafirma.examples.util.BenchMarkTimeUtils;

/**
 * Servlet encargado de gestionar la respuesta de Viafirma.
 * @author felix
 *
 */
public class ViafirmaClientResponseServlet extends ViafirmaClientServlet{


    private static final long serialVersionUID = 1L;

   /**
    * Método a implementar cuando la respuesta de firma es correcta.
    *
    * @param firma
    * @param request
    * @param response
    */

    public void signOK( FirmaInfoViafirma firma,  HttpServletRequest request,
	     HttpServletResponse response) {
	/* Lógica específica de la aplicación para gestionar el resultado de la  firma */
	BenchMarkTimeUtils.endDate=System.currentTimeMillis();
	request.setAttribute("resultado", firma);
	try {
	    request.getRequestDispatcher("/resultadoFirma.jsp").forward(request, response);
	} catch (ServletException e) {
	    e.printStackTrace();
	} catch (IOException e) {
	    e.printStackTrace();
	}

    }

    /**
     * Método a implementar cuando la respuesta de autenticación es correcta.
     *
     * @param usuario
     * @param request
     * @param response
     */

    public void authenticateOK( UsuarioGenericoViafirma usuario,
	     HttpServletRequest request,  HttpServletResponse response) {
	/* Lógica específica de la aplicación para gestionar el resultado de la autenticación */
	request.setAttribute("usuarioAutenticado", usuario);
	try {
	    request.getRequestDispatcher("/resultadoAutenticacion.jsp").forward(request, response);
	} catch (ServletException e) {
	    e.printStackTrace();
	} catch (IOException e) {
	    e.printStackTrace();
	}
    }


    /**
     * Alberga la lógica necesaria cuando el usuario cancele el proceso iniciado en el servlet.
     *
     * @param request
     * @param response
     */

    public void cancel( HttpServletRequest request,  HttpServletResponse response) {
	/* Gestión de cancelación del usuario al autenticar o firmar */
	request.setAttribute("error", "El usuario ha cancelado la autenticación");
	try {
	    request.getRequestDispatcher("/resultadoAutenticacion.jsp").forward(request, response);
	} catch (ServletException e) {
	    e.printStackTrace();
	} catch (IOException e) {
	    e.printStackTrace();
	}
    }

    /**
     * Método que controla la logica cuando ocurre algún error en el servlet.
     *
     * @param codError
     * @param request
     * @param response
     */

    public void error( CodigoError codError,  HttpServletRequest request,
	     HttpServletResponse response) {
	/* Gestión de error al autenticar o firmar */
	request.setAttribute("error", codError);
	try {
	    request.getRequestDispatcher("/resultadoAutenticacion.jsp").forward(request, response);
	} catch (ServletException e) {
	    e.printStackTrace();
	} catch (IOException e) {
	    e.printStackTrace();
	}
    }

}
