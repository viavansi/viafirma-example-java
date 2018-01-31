package com.viafirma.examples;

import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.viafirma.cliente.vo.UsuarioGenericoViafirma;

import com.viafirma.examples.util.ConfigureUtil;




/**
 * Filtro que protege la zona de administración de la aplicación.<br/>
 * El filtro extiende de AutentifacionViafirmaFilter y debe solo implementar los
 * métodos:<br/>
 * <br/>
 * <code>isAutenticado()</code>: Comprobará si el usuario esta logado.<br/>
 * <code>procesarAutenticacion()</code>: Inicia el proceso de autenticación.
 * <br/>
 *
 */
public class AutenticateFilter extends org.viafirma.cliente.filter.AutentifacionViafirmaFilter {


		@Override
        public void init( FilterConfig config) throws ServletException {
        // Configuración manual de Viafirma
        ConfigureUtil.init();

			super.init(config);
		}

        /**
     * Realiza la logica propia del filtro para considerar al usuario
     * autenticado.<br/>
     * Tipicamente comprueba si los datos del usuario estan en sesión.<br/>
     * <br/>
     * 
     * @return boolean Devuelve si se considera al usuario autenticado.
     */

	@Override
    public boolean isAutenticado( HttpServletRequest request,  HttpServletResponse response) {
	    	// Comprobamos si los datos del usuario se encuentra en sesion
                boolean autenticado=(request.getAttribute("usuarioAutenticado")!=null);
                return autenticado;
        }

        /**
     * Método que se invoca cuando el resultado de la autenticación ha sido
     * satisfactorio y donde se entregan los datos del usuario para que la
     * aplicación los procese y marque al usuario como logado.<br/>
     * <br/>
     * 
     * @return boolean Devuelve si el proceso posterior a la autenticación ha
     *         sido ejecutado correctamente.
     */
  
	@Override
    public boolean procesarAutenticacion( HttpServletRequest request,  HttpServletResponse arg1,  UsuarioGenericoViafirma usuarioViafirma) {
        	System.out.println("USUARIO AUTENTICADO:"+usuarioViafirma);
        // Añadimos los datos del usuario a la sesion
        	request.getSession().setAttribute("usuarioAutenticado", usuarioViafirma.getProperties());
            return true;
        }

}

