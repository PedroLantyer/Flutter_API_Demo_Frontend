class ServerConfig {
  String address = "localhost";
  int port = 8080;

  String getAuthority() => "$address:$port";
}
