/*
 * Desarrollado por Servicios Avanzados (Viavansi)2006
 * Contacto: comercial@serviciosavanzados.es
 *
 * http://www.serviciosavanzados.es
 * http://www.viavansi.com
 */
package com.viafirma.examples;

import java.io.IOException;

import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.viafirma.cliente.filter.FirmaViafirmaFilter;
import org.viafirma.cliente.vo.FicheroVO;
import org.viafirma.cliente.vo.FirmaInfoViafirma;

import com.viafirma.examples.util.ConfigureUtil;



/**
 * Filtro de firma de ficheros que deben utilizar las aplicaciónes que deseen
 * utilizar este sistema de firma sencillo. Parametros necesarios en el
 * contexto: URL_PROVIDER_VIAFIRMA: Para indicar la url a la que viafirma
 * retornara el control cuando la autenticación este completada.
 *
 */
public class FirmaFilter extends FirmaViafirmaFilter {


	@Override
    public void init(FilterConfig config) throws ServletException {
        // Configuración manual de Viafirma
        ConfigureUtil.init();

		super.init(config);
	}

	/**
     * Ejecuta el código espeficico que se tiene que invocar cuando se termina
     * de firmar un fichero Si devuelve true el filtro deja pasar si devuelve
     * false, el filtro no hace nada, por lo que debe ser la reimplementacion de
     * este metodo la encargada de redireccionar.
     */

	@Override
    protected boolean finFirma(HttpServletRequest request,
			HttpServletResponse response, FirmaInfoViafirma firma) {
		log.debug("Firma Completada con id:" + firma.getSignId());
		request.getSession().setAttribute("resultado", firma);
		return true;
	}

	/**
	 * Retorna el fichero que se desea firmar.
	 */

	@Override
    protected FicheroVO getFicheroAfirmar(HttpServletRequest request) {
		System.out.println("recupero un fichero cualquier del sistema");
		byte[] datos = null;
		try {
			datos = IOUtils.toByteArray(getClass().getResourceAsStream(
					"/exampleSign.pdf"));
			return new FicheroVO("contrato.pdf", datos);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}


}