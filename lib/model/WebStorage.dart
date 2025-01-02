import 'package:universal_html/html.dart';

class WebStorage {

  //Singleton
  WebStorage._internal();
  static final WebStorage instance = WebStorage._internal();
  factory WebStorage() {
    return instance;
  }

  String get sessionId => window.localStorage['SessionId'].toString();
  set sessionId(String sid) => (sid == null) ? window.localStorage.remove('SessionId') : window.localStorage['SessionId'] = sid;
}