import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import 'http_interceptors.dart';

class WebClient {
  static const String _defaultIp = '172.22.144.1';
  static String url =
      "http://${dotenv.get('IP_LOCAL', fallback: _defaultIp)}:3000/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );
}
