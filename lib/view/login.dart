import 'package:flutter/material.dart';
import 'package:tscoffee/model/WebStorage.dart';

import 'home.dart';

class Login extends StatelessWidget {
  Login({
    super.key,
  });
  final TextEditingController _textEditingControllerUser =
      TextEditingController();
  final TextEditingController _textEditingControllerPass =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff1D6CF3), Color(0xff19D2FE)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  'TS COFFEE',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 6
                      ..color = Colors.blue[700]!,
                  ),
                ),
                // Solid text as fill.
                Text(
                  'TS COFFEE',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _textEditingControllerUser,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 40),
                        ),
                        labelText: 'Username',
                        labelStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _textEditingControllerPass,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 40),
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                WebStorage.instance.sessionId = 'loginaccept';
                if(_textEditingControllerUser.text == 'tscoffee' &&
                        _textEditingControllerPass.text == 'tscoffee'){
                Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(),
                            maintainState: false,
                            barrierDismissible: true));
                            
                }else{
                Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
