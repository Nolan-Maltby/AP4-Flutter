import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>?> login(String username, String password) async {
    String url = 'https://www.btssio-carcouet.fr/ppe4/public/connect2/$username/$password/infirmiere';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('id')) {
          return data; // Retourne les infos de l'utilisateur
        } else {
          return null; // Identifiants incorrects
        }
      } else {
        return null; // Erreur serveur
      }
    } catch (e) {
      print("Erreur de connexion : $e");
      return null;
    }
  }
}
