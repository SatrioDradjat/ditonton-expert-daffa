import 'package:ditonton/ssl_pinning/UtilIoSSL.dart';
import 'package:http/http.dart' as http;

class HttpSSLPinning {
  static Future<http.Client> get instance async =>
      _clientInstance ??= await UtilIoSSL.createIOClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await instance;
  }
}
