import 'package:firebase_messaging/firebase_messaging.dart';

class Pushnotifier {
  
 static final _firebaseMessagaing = FirebaseMessaging.instance;
   static Future init() async {
    await _firebaseMessagaing.requestPermission(
       alert : true,  announcement: false,  badge : true,  carPlay : false,  criticalAlert : false,  provisional : false,  sound: true
    );
    
    final token = await _firebaseMessagaing.getToken();
    print(token);
  }
}