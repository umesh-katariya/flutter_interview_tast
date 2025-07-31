enum ProtocolType { http, https }

abstract class ApiBaseUrl {
  static bool isProd = false;

  static const productionBaseUrl = "https://jsonplaceholder.typicode.com";
  static const stagingBaseUrl = "https://jsonplaceholder.typicode.com";

  static get baseUrl => isProd ? "$productionBaseUrl/" : "$stagingBaseUrl/";
}
