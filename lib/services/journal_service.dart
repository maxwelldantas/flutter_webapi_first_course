import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import '../models/journal.dart';
import 'http_interceptors.dart';

class JournalService {
  static const String _defaultIp = '172.22.144.1';
  final String baseUrl;
  static const String resource = "journals/";

  JournalService()
    : baseUrl = "http://${dotenv.get('IP_LOCAL', fallback: _defaultIp)}:3000/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  String getURL() {
    return "${JournalService().baseUrl}$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  Future<bool> register(Journal journal) async {
    String journalJSON = json.encode(journal.toMap());

    http.Response response = await client.post(
      getUri(),
      headers: {'Content-type': 'application/json'},
      body: journalJSON,
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(getUri());

    if (response.statusCode != 200) {
      //TODO: Criar uma exceção personalizada
      throw Exception();
    }

    List<Journal> result = [];

    List<dynamic> jsonList = json.decode(response.body);
    for (var jsonMap in jsonList) {
      result.add(Journal.fromMap(jsonMap));
    }

    return result;
  }
}
