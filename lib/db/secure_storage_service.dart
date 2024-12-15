import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Private constructor
  SecureStorageService._internal();

  // Singleton instance
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  // Factory constructor to return the singleton instance
  factory SecureStorageService() {
    return _instance;
  }

  // Secure storage instance
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Methods for saving and retrieving different types of values
  Future<void> saveString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> saveInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<int?> getInt(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  Future<void> saveDouble(String key, double value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<double?> getDouble(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  Future<void> saveBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<bool?> getBool(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await _secureStorage.write(key: key, value: jsonString);
  }

  Future<Map<String, dynamic>?> getMap(String key) async {
    final jsonString = await _secureStorage.read(key: key);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}

typedef FromJson<T> = T Function(Map<String, dynamic> json);

/*
final storage = SecureStorageService();

// Save a list of Users
await storage.saveList<User>('user_list', [
  User(id: '1', name: 'Alice'),
  User(id: '2', name: 'Bob'),
]);

// Retrieve the list of Users
List<User>? users = await storage.getList<User>('user_list', User.fromJson);
if (users != null) {
  for (var user in users) {
    print('User: ${user.name}');
  }
}
 */
