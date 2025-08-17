import 'dart:async';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) {
    logger.i(data.headers);
    logger.i("Requisição para ${data.url}");
    logger.i(data.body);
    return Future.value(data);
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i(
        "Resposta de ${data.url}\n Cabeçalhos: ${data.headers}"
        "\nStatus Code: ${data.statusCode}\n Corpo: ${data.body}",
      );
    } else {
      logger.e(
        "Resposta de ${data.url}\n Cabeçalhos: ${data.headers}\n Corpo: ${data.body}",
      );
    }
    return data;
  }
}
