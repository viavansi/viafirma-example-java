package com.viafirma.examples.util;

import java.io.Serializable;

public class Configuration implements Serializable {

    private static final long serialVersionUID = 18778454L;

    private static Configuration instance;

    private Configuration() {
    }

    public static Configuration getInstance() {
        if (instance == null) {
            instance = new Configuration();
        }
        return instance;
    }

    private String urlViafirma;
    public String SESSION_URL_VIAFIRMA = "SESSION_URL_VIAFIRMA";
    
    private String urlViafirmaWS;
    public String SESSION_URL_VIAFIRMA_WS = "SESSION_URL_VIAFIRMA_WS";

    private String apiKey;
    public String SESSION_API_KEY = "SESSION_API_KEY";

    private String apiPass;
    public static String SESSION_API_PASS = "SESSION_API_PASS";

    private String certAlias;
    public static String SESSION_CERTALIAS = "SESSION_CERTALIAS";

    private String certPass;
    public static String SESSION_CERTPASS = "SESSION_CERTPASS";

    private String proxyHost;
    public static String SESSION_PROXY_HOST = "SESSION_PROXY_HOST";
    
    private String proxyPort;
    public static String SESSION_PROXY_PORT = "SESSION_PROXY_PORT";
    
    private String proxtUser;
    public static String SESSION_PROXY_USER = "SESSION_PROXY_USER";
    
    private String proxyPass;
    public static String SESSION_PROXY_PASS = "SESSION_PROXY_PASS";

    private String urlCallBack;
    public String SESSION_URL_CALLBACK = "SESSION_URL_CALLBACK";

    private String maxSizeFile;
    public String SESSION_MAX_SIZE_FILE = "SESSION_MAX_SIZE_FILE";

    public String getUrlViafirma() {
        return urlViafirma;
    }

    public void setUrlViafirma(String urlViafirma) {
        this.urlViafirma = urlViafirma;
    }

    public String getUrlViafirmaWS() {
        return urlViafirmaWS;
    }

    public void setUrlViafirmaWS(String urlViafirmaWS) {
        this.urlViafirmaWS = urlViafirmaWS;
    }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    public String getApiPass() {
        return apiPass;
    }

    public void setApiPass(String apiPass) {
        this.apiPass = apiPass;
    }

    public String getCertAlias() {
        return certAlias;
    }

    public void setCertAlias(String certAlias) {
        this.certAlias = certAlias;
    }

    public String getCertPass() {
        return certPass;
    }

    public void setCertPass(String certPass) {
        this.certPass = certPass;
    }

    public String getProxyHost() {
        return proxyHost;
    }

    public void setProxyHost(String proxyHost) {
        this.proxyHost = proxyHost;
    }

    public String getProxyPort() {
        return proxyPort;
    }

    public void setProxyPort(String proxyPort) {
        this.proxyPort = proxyPort;
    }

    public String getProxtUser() {
        return proxtUser;
    }

    public void setProxtUser(String proxtUser) {
        this.proxtUser = proxtUser;
    }

    public String getProxyPass() {
        return proxyPass;
    }

    public void setProxyPass(String proxyPass) {
        this.proxyPass = proxyPass;
    }

    public String getUrlCallBack() {
        return urlCallBack;
    }

    public void setUrlCallBack(String urlCallBack) {
        this.urlCallBack = urlCallBack;
    }

    public String getMaxSizeFile() {
        return maxSizeFile;
    }

    public void setMaxSizeFile(String maxSizeFile) {
        this.maxSizeFile = maxSizeFile;
    }

}
