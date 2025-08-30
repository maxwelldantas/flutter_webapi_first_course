import 'dart:convert';

import 'package:flutter_webapi_first_course/services/web_client.dart';
import 'package:http/http.dart' as http;

import '../models/journal.dart';

class JournalService {
  String url = WebClient.url;
  http.Client client = WebClient().client;

  static const String resource = "journals/";

  String getURL() {
    return "$url$resource";
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
