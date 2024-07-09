import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy_app/models/inventories_model.dart';
import 'package:pharmacy_app/models/medicine.detail.dart';
import 'dart:convert';
import 'package:pharmacy_app/models/token_model.dart';

class ApiService {
  final String baseUrl = "http://192.168.219.149:8000/api/v1";
  static const storage = FlutterSecureStorage();

  Future<bool> checkId({
    required username,
  }) async {
    final url = Uri.parse("$baseUrl/users/username/$username/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return false; // Change return value to false
    } else if (response.statusCode == 204) {
      return true; // Add condition to return true for status code 204
    } else {
      return false; // Default to returning false
    }
  }

  Future<bool> postRefreshToken() async {
    final url = Uri.parse("$baseUrl/users/token/refresh/");
    String? refreshToken = await storage.read(key: 'refresh');
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }
    final response = await http.post(
      url,
      body: {
        'refresh': refreshToken,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      try {
        await storage.write(key: 'access', value: jsonData['access']);
        await storage.write(key: 'refresh', value: jsonData['refresh']);
        return true;
      } catch (e) {
        throw Exception('Failed to refresh token');
      }
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<bool> postUsers({
    required username,
    required password,
    required name,
    required email,
  }) async {
    final url = Uri.parse("$baseUrl/users/");
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      try {
        postToken(username: username, password: password);
        return true;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> postToken({
    required username,
    required password,
  }) async {
    final url = Uri.parse("$baseUrl/users/token/");
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      try {
        final token = TokenModel.fromJson(jsonData);
        await storage.write(key: 'access', value: token.access);
        await storage.write(key: 'refresh', value: token.refresh);
        return true;
      } catch (e) {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<MedicineTinyModel>> getMedicineTinyList({
    int page = 1,
    String search = "",
  }) async {
    List<MedicineTinyModel> medicineTinyModels = [];
    Uri urlAddress = Uri.parse("$baseUrl/medicines/?page=$page");
    if (search.isNotEmpty) {
      urlAddress = Uri.parse("$baseUrl/medicines/?page=$page&search=$search");
    }
    final response = await http.get(urlAddress);
    if (response.statusCode == 200) {
      final List<dynamic> medicines =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var medicine in medicines) {
        medicineTinyModels.add(MedicineTinyModel.fromJson(medicine));
      }
      return medicineTinyModels;
    }
    throw Exception('Failed to load medicine');
  }

  Future<MedicineDetailModel> getMedicineDetail(int id) async {
    final url = Uri.parse("$baseUrl/medicines/$id/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final medicine = jsonDecode(utf8.decode(response.bodyBytes));
      return MedicineDetailModel.fromJson(medicine);
    }
    throw Exception('Failed to load medicine');
  }

  Future<List<InventoriesModel>> getInventoryTinyModels() async {
    List<InventoriesModel> inventoryTinyModels = [];
    final url = Uri.parse("$baseUrl/inventories/");
    print(await storage.read(key: 'access'));
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${await storage.read(key: 'access')}",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> inventories =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var inventory in inventories) {
        inventoryTinyModels.add(InventoriesModel.fromJson(inventory));
      }
      return inventoryTinyModels;
    } else if (response.statusCode == 403) {
      await postRefreshToken();
      return await getInventoryTinyModels();
    }
    throw Exception('Failed to load medicine');
  }
}
