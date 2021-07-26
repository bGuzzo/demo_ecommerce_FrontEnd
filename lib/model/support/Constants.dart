class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "Consorzio Agrario";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:9090";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8443";

  // authentication
  static final String REALM = "ClientiRealm";
  static final String CLIENT_ID = "clients-flutter";

  //static final String CLIENT_SECRET = "***";
  static final String REQUEST_LOGIN =
      "/auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT =
      "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

  // requests
  static final String REQUEST_SEARCH_PRODUCTS_BY_NAME_DESCRIPTION =
      "/prodotti/cerca";
  static final String REQUEST_ADD_USER = "/clienti";
  static final String REQUEST_AGGIORNA_CARRELLO = "/carrello/aggiorna";
  static final String REQUEST_VISUALIZZA_CARRELLO = "/carrello/prodotti";
  static final String REQUEST_VISUALIZZA_QUANTITA_PRODOTTO =
      "/carrello/quantita";
  static final String REQUEST_ACQUISTA = "/acquisti";
  static final String REQUEST_ORDINI = "/acquisti/ordini";
  static final String REQUEST_DETTAGLI = "/acquisti/dettagli";

  // states
  static final String STATE_CLUB = "club";

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS =
      "ERROR_MAIL_USER_ALREADY_EXISTS";
  static final String RESPONSE_ERROR_USERNAME_ALREADY_EXISTS =
      "ERROR_USERNAME_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";
}
