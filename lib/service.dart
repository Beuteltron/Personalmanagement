import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // Die URL Ihres Web-Servers; die URL des Endpunkts, der die Daten abruft
  final String userEndpoint = 'https://meinserver.com/users';

  // Funktion, um Benutzerdaten abzurufen
  Future<Map<String, dynamic>> getUserData(String userId) async {
    final response = await http.get(Uri.parse('$userEndpoint/$userId'));

    if (response.statusCode == 200) {
      // Wenn der Server eine OK-Antwort zurückgibt, dann parsen wir das JSON.
      return jsonDecode(response.body);
    } else {
      // Wenn die Antwort nicht OK ist, werfen wir einen Fehler.
      throw Exception('Failed to load user data');
    }
  }

  // Funktion, um Benutzerdaten zu aktualisieren
  Future<void> updateUserData(String userId, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$userEndpoint/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user data');
    }
  }
}