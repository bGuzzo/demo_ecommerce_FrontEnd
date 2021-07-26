import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:FrontEnd/model/managers/RestManager.dart';
import 'package:FrontEnd/model/objects/Acquisto.dart';
import 'package:FrontEnd/model/objects/AuthenticationData.dart';
import 'package:FrontEnd/model/objects/Product.dart';
import 'package:FrontEnd/model/objects/User.dart';
import 'package:FrontEnd/model/support/Constants.dart';
import 'package:FrontEnd/model/support/LogInResult.dart';
import 'package:FrontEnd/model/support/RegistrationResult.dart';

class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  AuthenticationData _authenticationData;

  List<String> categorie = [
    "all",
    "fertilizers",
    "seeds",
    "pesticide",
    "tools"
  ];

  bool logged = false;
  String userLogged = "";


  Future<LogInResult> logIn(String username, String password) async {
    try {
      Map<String, String> params = Map();
      params["client_id"] = Constants.CLIENT_ID;
      //params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = username;
      params["password"] = password;
      params["grant_type"] = "password";
      String result = await _restManager.makePostRequest(
          Constants.ADDRESS_AUTHENTICATION_SERVER,
          Constants.REQUEST_LOGIN,
          params,
          type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if (_authenticationData.hasError()) {
        if (_authenticationData.error == "Invalid user credentials") {
          return LogInResult.error_wrong_credentials;
        } else if (_authenticationData.error == "Account is not fully set up") {
          return LogInResult.error_not_fully_setupped;
        } else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      logged = true;
      userLogged = username;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)),
          (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    } catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      //params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      String result = await _restManager.makePostRequest(
          Constants.ADDRESS_AUTHENTICATION_SERVER,
          Constants.REQUEST_LOGIN,
          params,
          type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if (_authenticationData.hasError()) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      Map<String, String> params = Map();
      _restManager.token = null;
      logged = false;
      userLogged = "";
      params["client_id"] = Constants.CLIENT_ID;
      //params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(
          Constants.ADDRESS_AUTHENTICATION_SERVER,
          Constants.REQUEST_LOGOUT,
          params,
          type: TypeHeader.urlencoded);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Product>> searchProductNameDescription(
      String ricerca, String minPrice, String maxPrice, int category) async {
    Map<String, String> params = Map();
    params["ricerca"] = ricerca;
    List<Product> toReturn = [];
    try {
      List<Product> list = List<Product>.from(json
          .decode(await _restManager.makeGetRequest(
              Constants.ADDRESS_STORE_SERVER,
              Constants.REQUEST_SEARCH_PRODUCTS_BY_NAME_DESCRIPTION,
              params))
          .map((i) => Product.fromJson(i))
          .toList());
      if ((minPrice != "" && int.parse(minPrice) == null) ||
          (maxPrice != "" && int.parse(maxPrice) == null)) return toReturn;

      for (int i = 0; i < list.length; i++) {
        bool toDelete = false;
        if (minPrice != "" && list[i].price < int.parse(minPrice))
          toDelete = true;
        if (maxPrice != "" && list[i].price > int.parse(maxPrice))
          toDelete = true;
        if (category != null &&
            categorie[category] != "all" &&
            list[i].category != categorie[category]) toDelete = true;
        if (!toDelete) toReturn.add(list[i]);
      }
      return toReturn;
    } catch (e) {
      return null; // not the best solution
    }
  }

  Future<RegistrationResult> addUser(
      User user, Map<String, String> params) async {
    try {
      String rawResult = await _restManager.makePostRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user,
          params: params);
      print(rawResult.toString()); //DEBUGS
      if (rawResult
          .contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS)) {
        print("error_email_already_used");
        return RegistrationResult.error_email_already_used;
      }
      if (rawResult
          .contains(Constants.RESPONSE_ERROR_USERNAME_ALREADY_EXISTS)) {
        print("error_username_already_used");
        return RegistrationResult.error_username_already_used;
      } else {
        print("registred");
        return RegistrationResult.registered;
      }
    } catch (e) {
      return null; // not the best solution
    }
  }

  Future<String> aggiornaCarrello(
      String emailUser, String id, String quantity) async {
    Map<String, String> params = Map();
    params["id"] = id;
    params["email"] = emailUser;
    params["quantita"] = quantity;
    try {
      User u = new User(
          firstName: "Prova",
          lastName: "Carrello",
          username: "provacarrello",
          email: "provacarrello@gmail.com");
      String s = await _restManager.makePostRequest(
          Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_AGGIORNA_CARRELLO,
          params,
          params: params);
      return s;
    } catch (e) {
      print(e.toString());
      print("Siamo caduti nell'eccezione");
      return null;
    }
  }

  Future<int> getQuantita(int idProdotto) async {
    Map<String, String> params = Map();
    params["username"] = userLogged;
    params["id"] = idProdotto.toString();
    try {
      String quantita = await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_VISUALIZZA_QUANTITA_PRODOTTO,
          params);
      return int.parse(quantita);
    } catch (e) {
      print("Sono nell'eccezione della quantita " + e.toString());
      return null; //not the best solutions
    }
  }

  Future<Map<Product, int>> getProdotti2() async {
    Map<String, String> params = Map();
    params["username"] = userLogged;
    Map<Product, int> map = Map();
    List<Product> carrello = List();
    try {
      String ricevuto = await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER,
          Constants.REQUEST_VISUALIZZA_CARRELLO,
          params);
      if (ricevuto == null || ricevuto == "") {
        print("ricevuto è vuoto");
        return map;
      }
      print("ricevuto " + ricevuto);
      carrello = List<Product>.from(
          json.decode(ricevuto).map((i) => Product.fromJson(i)).toList());
      for (Product p in carrello) {
        Map<String, String> params = Map();
        params["username"] = userLogged;
        params["id"] = p.id.toString();
        String quantita = await _restManager.makeGetRequest(
            Constants.ADDRESS_STORE_SERVER,
            Constants.REQUEST_VISUALIZZA_QUANTITA_PRODOTTO,
            params);
        int qta = int.parse(quantita);
        map[p] = qta;
      }
      return map;
    } catch (e) {
      print("sono nell'eccezzione del prodotto " + e.toString());
      return null; //not be the best solution
    }
  }

  Future<List<Acquisto>> getOrdini() async {
    Map<String, String> params = Map();
    params['cliente'] = Model.sharedInstance.userLogged;
    try {
      List<Acquisto> listaOrdini = List<Acquisto>.from(json
          .decode(await _restManager.makeGetRequest(
              Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ORDINI, params))
          .map((i) => Acquisto.fromJson(i))
          .toList());
      return listaOrdini;
    } catch (e) {
      print("sono nell'eccezzione del getOrdini, " + e.toString());
      return List();
    }
  }

  Future<String> getDettagliOrdine(int idOrdine) async {
    String s = "";
    try {
      Map<String, String> params = Map();
      params["id"] = idOrdine.toString();
      s = await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_DETTAGLI, params);
      return s;
    } catch (e) {
      print("eccezzione getDettagliOrdine :" + e.toString());
      return "";
    }
  }

  Future<String> acquista(String emailUser, Map<Product, int> prodotti) async {
    String s = "";
    try {
      for (Product p in prodotti.keys) {
        Map<String, String> params = Map();
        params["email"] = emailUser;
        params["id"] = p.id.toString();
        s += await _restManager.makePostRequest(
            Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ACQUISTA, null,
            params: params);
        s += "\n";
      }
      return s;
    } catch (e) {
      print("eccezzione acquista :" + e.toString());
      return s;
    }
  }

}
