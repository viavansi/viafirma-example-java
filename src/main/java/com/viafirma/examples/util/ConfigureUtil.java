package com.viafirma.examples.util;

import java.net.URL;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NameNotFoundException;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.viafirma.cliente.ViafirmaClientFactory;
import org.viafirma.cliente.util.Constantes;

/**
 * Ejemplo de configuración de Viafirma
 *
 */
public class ConfigureUtil {

     private static final Logger LOG=Logger.getLogger(ConfigureUtil.class);

    /**
     * URL public of the viafirma
     */
    public static String DEFAULT_URL_VIAFIRMA = "http://localhost:8080/viafirma";
    public static String URL_VIAFIRMA = DEFAULT_URL_VIAFIRMA;
    public static String SESSION_URL_VIAFIRMA = "SESSION_URL_VIAFIRMA";
    /**
     * URL private of the WS of Viafirma
     */
    public static String DEFAULT_URL_VIAFIRMA_WS = "http://localhost:8080/viafirma";
    public static String URL_VIAFIRMA_WS = DEFAULT_URL_VIAFIRMA_WS;
    public static String SESSION_URL_VIAFIRMA_WS = "SESSION_URL_VIAFIRMA_WS";

    /**
     * Key application to use OpenID
     */
    public static String DEFAULT_API_KEY = "xnoccio";
    public static String API_KEY = DEFAULT_API_KEY;
    public static String SESSION_API_KEY = "SESSION_API_KEY";

    /**
     * Password application to use OpenID
     */
    public static String DEFAULT_API_PASS = "12345";
    public static String API_PASS = DEFAULT_API_PASS;
    public static String SESSION_API_PASS = "SESSION_API_PASS";

    public static String DEFAULT_CERTALIAS = "xnoccio";
    public static String CERTALIAS = DEFAULT_CERTALIAS;
    public static String SESSION_CERTALIAS = "SESSION_CERTALIAS";

    public static String DEFAULT_CERTPASS = "12345";
    public static String CERTPASS = DEFAULT_CERTPASS;
    public String SESSION_CERTPASS = "SESSION_CERTPASS";

    public static String PROXY_HOST = "";
    public static String PROXY_PORT = "";

    public static String PROXY_USER = "";
    public static String PROXY_PASS = "";

    public static String DEFAULT_URL_CALLBACK = "http://localhost:8080/ejemploViafirma/ViafirmaCallbackServlet";
    public static String URL_CALLBACK = DEFAULT_URL_CALLBACK;
    public static String SESSION_URL_CALLBACK = "SESSION_URL_CALLBACK";

    public static String DEFAULT_MAX_SIZE_FILE = "20";
    public static String MAX_SIZE_FILE = DEFAULT_MAX_SIZE_FILE;
    public static String SESSION_MAX_SIZE_FILE = "SESSION_MAX_SIZE_FILE";

    // public static String URL_CALLBACK =
    // "http://localhost:8080/ejemploViafirma/ViafirmaCallbackServlet";

    /**
     * Este método comprueba si se han configurado los valores de viafirma en el
     * contexto.
     */
    public static void load() {
        // Default values
        URL_VIAFIRMA=DEFAULT_URL_VIAFIRMA;
        URL_VIAFIRMA_WS=DEFAULT_URL_VIAFIRMA_WS;
        API_KEY = DEFAULT_API_KEY;
        API_PASS = DEFAULT_API_PASS;
        CERTALIAS = DEFAULT_CERTALIAS;
        CERTPASS = DEFAULT_CERTPASS;
        URL_CALLBACK = DEFAULT_URL_CALLBACK;
        MAX_SIZE_FILE = DEFAULT_MAX_SIZE_FILE;
        
        try {
            Context contextInit = new InitialContext();
            Context context = (Context) contextInit.lookup("java:comp/env");
            try {
                String configViafirmaParam = (String) context.lookup("CONFIG_VIAFIRMA_CLIENT");
                String[] configViafirma = configViafirmaParam.split(";");
                URL_VIAFIRMA = configViafirma[0];
                URL_VIAFIRMA_WS = configViafirma[1];
                API_KEY = configViafirma[2];
                API_PASS = configViafirma[3];

            } catch (NameNotFoundException e) {
                Logger.getLogger(ConfigureUtil.class).warn(e.getMessage());
            }

            // Overwrite if set as environment variable
            String urlViafirma=System.getenv("URL_VIAFIRMA");
            String urlViafirmaWs=System.getenv("URL_VIAFIRMA_WS");

            if(!StringUtils.isEmpty(urlViafirma)) {
                URL_VIAFIRMA = urlViafirma;
            }
            if(!StringUtils.isEmpty(urlViafirmaWs)) {
                URL_VIAFIRMA_WS = urlViafirmaWs;
            }

            try {
                String configViafirmaCertParam = (String) context.lookup("CONFIG_VIAFIRMA_CERT_SERVER");
                String[] configViafirmaCert = configViafirmaCertParam.split(";");
                CERTALIAS = configViafirmaCert[0];
                CERTPASS = configViafirmaCert[1];
            } catch (NameNotFoundException e) {
                Logger.getLogger(ConfigureUtil.class).warn(e.getMessage());
            }

            try {
                URL_CALLBACK = (String) context.lookup("URL_CALLBACK");
            } catch (NameNotFoundException e) {
                Logger.getLogger(ConfigureUtil.class).warn(e.getMessage());
            }

            try {
                MAX_SIZE_FILE = (String) context.lookup("MAX_SIZE_FILE");
            } catch (NameNotFoundException e) {
                Logger.getLogger(ConfigureUtil.class).warn(e.getMessage());
            }

        } catch (Exception ex) {
            Logger.getLogger(ConfigureUtil.class).info("NO JNDI Context, using default Values");

        }
    }

    /**
     * Este método configura Viafirma. En un entorno real los parámetros de
     * configuración serán recuperados externamente.
     */
    public static void init() {
        load();
        initViafirmaClient();
    }

    public static void initViafirmaClient() {
        Properties properties = new Properties();
        properties.put(Constantes.PARAM_CONFIG_VIAFIRMA_CLIENT, URL_VIAFIRMA + ";" + URL_VIAFIRMA_WS + ";" + API_KEY + ";" + API_PASS);

        // si se especifica el tamaño máximo de archi, incio tambien la
        // siguiente variable
        if (MAX_SIZE_FILE != null) {
            Long maxSizeByte = Long.parseLong(MAX_SIZE_FILE);
            Long maxSizeMB = maxSizeByte * 1024l * 1024l;
            properties.put(Constantes.PARAM_MAX_SIZE, maxSizeMB.toString());
        }
        // properties.put(Constantes.PARAM_URL_APLICACION,
        // "http://192.168.10.114:6080/ejemploViafirma//");
        ViafirmaClientFactory.init(properties);
    }


    public static void updateConfigurationSession(HttpSession session, String url_viafirma, String url_ws_viafirma) {
        session.setAttribute(SESSION_URL_VIAFIRMA, url_viafirma);
    }

    public static void updateConfiguration(String url_viafirma, String url_ws_viafirma) {
        URL_VIAFIRMA = url_viafirma;
        URL_VIAFIRMA_WS = url_ws_viafirma;
        initViafirmaClient();
    }

    public static void updateAlias(String alias, String pass) {
        CERTALIAS = alias;
        CERTPASS = pass;
    }

    public static void updateApiKey(String apiKey, String apiPass) {
        API_KEY = apiKey;
        API_PASS = apiPass;
    }

    public static void updateProxy(String proxyHost, String proxyPort, String proxyUser, String proxyPass) {
        if (StringUtils.isBlank(proxyHost) || StringUtils.isBlank(proxyPort)) {
            System.setProperty("http.proxySet", "false");
            System.setProperty("https.proxySet", "false");
            System.clearProperty("http.proxyHost");
            System.clearProperty("http.proxyPort");
            System.clearProperty("http.proxyUser");
            System.clearProperty("http.proxyPassword");
            System.clearProperty("https.proxyHost");
            System.clearProperty("https.proxyPort");
            System.clearProperty("https.proxyUser");
            System.clearProperty("https.proxyPassword");
        } else {
            System.setProperty("http.proxySet", "true");
            System.setProperty("https.proxySet", "true");
            System.setProperty("http.proxyHost", proxyHost);
            System.setProperty("http.proxyPort", proxyPort);
            System.setProperty("http.proxyUser", proxyUser);
            System.setProperty("http.proxyPassword", proxyPass);
            System.setProperty("https.proxyHost", proxyHost);
            System.setProperty("https.proxyPort", proxyPort);
            System.setProperty("https.proxyUser", proxyUser);
            System.setProperty("https.proxyPassword", proxyPass);
        }
        PROXY_HOST = proxyHost;
        PROXY_PORT = proxyPort;
        PROXY_USER = proxyUser;
        PROXY_PASS = proxyPass;
    }

    public static String getViafirmaServer() {
        return URL_VIAFIRMA;
    }

    public static String getViafirmaServerWS() {
        return URL_VIAFIRMA_WS;
    }
    
    public static String getViafirmaServerPublicWS() {
        return StringUtils.replace(URL_VIAFIRMA, "/tokenConnector", "");
    }

    public static String getApiKey() {
        return API_KEY;
    }

    public static String getApiPass() {
        return API_PASS;
    }

    public static String getCallbackUrl() {
        return URL_CALLBACK;
    }

}
