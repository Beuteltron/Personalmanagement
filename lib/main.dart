import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personalmanagement',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // Wir starten mit der Login-Seite
      home: const LoginPage(),
    );
  }
}

// Login-Seite
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller für die Textfelder
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Schlüssel für das globale Formular, um das Formular zu validieren
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Methode, um sich beim Drücken des Anmelde-Buttons anzumelden
  void _login() {
    if (_formKey.currentState!.validate()) {
      // Wenn die Validierung erfolgreich ist, holen Sie sich die Werte
      final String username = _usernameController.text;
      final String password = _passwordController.text;

      // TODO: Führen Sie hier Ihre Anmelde-Logik durch (z.B. senden Sie die Informationen an Ihr Backend)

      // Beispiel: Wenn Anmeldung erfolgreich, navigieren zum Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anmelden'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Textfeld für den Benutzernamen
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Benutzername',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte einen Benutzernamen eingeben';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0), // Abstand zwischen den Feldern
              // Textfeld für das Passwort
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Verbirgt die Eingabe für Passwörter
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte ein Passwort eingeben';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0), // Abstand zwischen Feld und Button
              // Anmelde-Button
              ElevatedButton(
                onPressed: _login,
                child: Text('Anmelden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Dashboard-Seite
class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  // Diese Methode simuliert das Abmelden eines Benutzers
  void _logout(BuildContext context) {
    // Navigieren Sie zurück zur Anmeldeseite, wenn der Benutzer sich abmeldet
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Simulierte Benutzerdaten - in einer echten App würden diese von Ihrem Server kommen
    final Map<String, String> userData = {
      'Körpergröße': '180 cm',
      'Schuhgröße': '42',
      'Brustumfang': '90 cm',
      'Taillenumfang': '75 cm',
      'Augenfarbe': 'Blau',
      'Haarfarbe': 'Schwarz',
      // Fügen Sie hier weitere Attribute hinzu
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Abmelden',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Persönliche Angaben',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            SizedBox(height: 16.0),
            // Etwas Platz zwischen Überschrift und Inhalt
            ...userData.entries.map((entry) {
              // Erstellen Sie für jedes Attribut des Benutzers eine neue Zeile
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value),
                ],
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wenn der Button gedrückt wird, navigieren Sie zur EditProfilePage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfilePage()),
          );
        },
        child: const Icon(Icons.edit),  // Das Icon für den Button, hier ein Bleistift für "bearbeiten"
        tooltip: 'Profil bearbeiten',  // Text, der angezeigt wird, wenn der Benutzer den Button lange drückt
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  // Wir könnten hier die aktuellen Benutzerdaten übergeben
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controller für die Textfelder, initialisiert mit simulierten Benutzerdaten
  final TextEditingController _heightController = TextEditingController(text: '180 cm');
  final TextEditingController _shoeSizeController = TextEditingController(text: '42');
  // Fügen Sie hier weitere Controller für andere Attribute hinzu

  // Schlüssel für das globale Formular, um das Formular zu validieren
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Methode, um Änderungen zu speichern, wenn der Speichern-Button gedrückt wird
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Wenn die Validierung erfolgreich ist, holen Sie sich die aktualisierten Werte
      final String height = _heightController.text;
      final String shoeSize = _shoeSizeController.text;
      // Holen Sie sich hier weitere Attribute

      // TODO: Senden Sie die aktualisierten Informationen an Ihr Backend

      // Nachdem die Änderungen gespeichert wurden, kehren Sie zum Dashboard zurück
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil bearbeiten'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Textfeld für die Körpergröße
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: 'Körpergröße',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie Ihre Körpergröße ein';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0), // Abstand zwischen den Feldern
              // Textfeld für die Schuhgröße
              TextFormField(
                controller: _shoeSizeController,
                decoration: InputDecoration(
                  labelText: 'Schuhgröße',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie Ihre Schuhgröße ein';
                  }
                  return null;
                },
              ),
              // Fügen Sie hier weitere Textfelder für andere Attribute hinzu
              SizedBox(height: 24.0), // Abstand zwischen Feld und Button
              // Speichern-Button
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Änderungen speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}