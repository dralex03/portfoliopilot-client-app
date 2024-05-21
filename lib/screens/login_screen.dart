import 'package:flutter/material.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/register_form.dart';

// LoginScreen Widget, das die Hauptanmeldeseite darstellt.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController; // TabController zur Verwaltung der Tabs.
  final Color indicatorColor = Color(0xFF252E3C); // Farbe des Indikators.
  final Color backgroundColor = Color(0xFF44556F);// Farbe des Main-Hintergrunds.

  @override
  void initState() {
    super.initState();
    // Initialisierung des TabControllers mit zwei Tabs.
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Freigabe der Ressourcen des TabControllers.
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hintergrundfarbe des Bildschirms.
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(0), // Keine zusätzliche Auffüllung.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Zentriert den Inhalt vertikal.
          children: <Widget>[

            // Platzhalter, um den Text etwas nach unten zu verschieben.
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

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
                color: Colors.white.withOpacity(0.1), // Hintergrundfarbe der TabBar mit Transparenz.
              ),
              child: TabBar(
                controller: _tabController, // Zuweisung des TabControllers.
                labelColor: Colors.white, // Textfarbe der ausgewählten Tabs.
                unselectedLabelColor: Colors.white54, // Textfarbe der nicht ausgewählten Tabs.
                indicator: BoxDecoration(
                  color: indicatorColor, // Hintergrundfarbe des Indikators.
                ),
                indicatorSize: TabBarIndicatorSize.tab, // Indikatorgröße an Tabgröße anpassen.
                tabs: [
                  Tab(text: 'Sign-In'), // Tab für die Anmeldung.
                  Tab(text: 'Register'), // Tab für die Registrierung.
                ],
              ),
            ),

            // Füge eine farbige Linie unter der TabBar hinzu als "Sized Box".
            Container(
              height: 10,
              color: indicatorColor,
            ),

            //Tabs und Widgets werden zugewiesen.
            Expanded(
              // TabBarView zeigt den Inhalt der ausgewählten Tabs an.
              child: TabBarView(
                controller: _tabController, // Zuweisung des TabControllers.
                children: [
                  // Übergebe die Hintergrundfarbe an das SignInForm-Widget.
                  SignInForm(backgroundColor: indicatorColor),
                  // Übergebe die Hintergrundfarbe an das RegisterForm-Widget.
                  RegisterForm(backgroundColor: indicatorColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
