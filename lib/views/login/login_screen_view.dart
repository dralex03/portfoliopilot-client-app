import 'package:flutter/material.dart';

import '../../widgets/login/login_screen_widget.dart';
import 'package:androidproject/controller/login/login_screen_controller.dart';

import '../../widgets/login/register_widget.dart';
import '../../widgets/login/sign_in_widget.dart';

class LoginScreenView extends StatelessWidget {
  final LoginScreenController state;
  LoginScreenWidget get widget => state.widget;

  const LoginScreenView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hintergrundfarbe des Bildschirms.
      backgroundColor: widget.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(0), // Keine zusätzliche Auffüllung.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Zentriert den Inhalt vertikal.
          children: <Widget>[

            // Platzhalter, um den Text etwas nach unten zu verschieben.
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.1),

            // Begrüßungstext.
            Text(
              'Welcome to PortfolioPilot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ),

            // Abstand zwischen Text und TabBar.
            SizedBox(height: 20),

            //Container für das Design der beiden Tabs.
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                    0.1), // Hintergrundfarbe der TabBar mit Transparenz.
              ),
              child: TabBar(
                controller: widget.tabController,
                // Zuweisung des TabControllers.
                labelColor: Colors.white,
                // Textfarbe der ausgewählten Tabs.
                unselectedLabelColor: Colors.white54,
                // Textfarbe der nicht ausgewählten Tabs.
                indicator: BoxDecoration(
                  color: widget.indicatorColor, // Hintergrundfarbe des Indikators.
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                // Indikatorgröße an Tabgröße anpassen.
                tabs: [
                  Tab(text: 'Sign-In'), // Tab für die Anmeldung.
                  Tab(text: 'Register'), // Tab für die Registrierung.
                ],
              ),
            ),

            // Füge eine farbige Linie unter der TabBar hinzu als "Sized Box".
            Container(
              height: 10,
              color: widget.indicatorColor,
            ),

            //Tabs und Widgets werden zugewiesen.
            Expanded(
              // TabBarView zeigt den Inhalt der ausgewählten Tabs an.
              child: TabBarView(
                controller: widget.tabController, // Zuweisung des TabControllers.
                children: [
                  // Übergebe die Hintergrundfarbe an das SignInForm-Widget.
                  SignInWidget(backgroundColor: widget.indicatorColor),
                  // Übergebe die Hintergrundfarbe an das RegisterForm-Widget.
                  RegisterWidget(backgroundColor: widget.indicatorColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}