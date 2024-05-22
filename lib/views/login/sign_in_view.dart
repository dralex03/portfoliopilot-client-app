import 'package:flutter/material.dart';

import '../../widgets/login/sign_in_widget.dart';
import 'package:androidproject/controller/login/sign_in_controller.dart';

// SignInForm Widget, das ein Anmeldeformular darstellt.
class SignInView extends StatelessWidget {
  final SignInController state;
  SignInWidget get widget => state.widget;

  const SignInView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Hintergrundfarbe des Containers auf die übergebene Farbe gesetzt.
      color: widget.backgroundColor,
      child: SingleChildScrollView(
        // ScrollView, um sicherzustellen, dass der Inhalt gescrollt werden kann, wenn die Tastatur geöffnet wird.
        child: Column(
          children: <Widget>[

            // Textfeld für den Benutzernamen.
            TextFormField(
              decoration: InputDecoration(
                // Füllt das Textfeld mit einer halbtransparenten Farbe.
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Nutzername...', // Platzhaltertext.
                prefixIcon: Icon(Icons.person, color: Colors.white), // Symbol links im Textfeld.
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Kein Rahmen für das Textfeld.
                ),
                contentPadding: EdgeInsets.all(16.0), // Innenabstand im Textfeld.
              ),
              style: TextStyle(color: Colors.white), // Textfarbe im Textfeld.
            ),

            // Abstand zwischen den Textfeldern.
            SizedBox(height: 10),

            // Textfeld für das Passwort.
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                hintText: 'Passwort...', // Platzhaltertext.
                prefixIcon: Icon(Icons.visibility, color: Colors.white), // Symbol links im Textfeld.
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Kein Rahmen für das Textfeld.
                ),
                contentPadding: EdgeInsets.all(16.0), // Innenabstand im Textfeld.
              ),
              obscureText: true, // Versteckt das eingegebene Passwort.
              style: TextStyle(color: Colors.white), // Textfarbe im Textfeld.
            ),

            // Abstand zwischen dem letzten Textfeld und dem Button.
            SizedBox(height: 20),

            // Button zum Anmelden.
            SizedBox(
              width: double.infinity, // Button nimmt die gesamte Breite des Containers ein.
              child: ElevatedButton(
                onPressed: state.signIn(), // Methode zum Anmelden aufrufen.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Hintergrundfarbe des Buttons
                  foregroundColor: Colors.white, // Textfarbe des Buttons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Ecken nicht abrunden
                  ),
                ),
                child: Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
