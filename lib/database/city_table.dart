import 'package:sqflite/sqflite.dart';
import 'package:weather_app/database/database.dart';
import 'package:weather_app/model/current_weather_model.dart';
import 'package:weather_app/model/database_model/city_model.dart';
import 'package:weather_app/utils/constants.dart';

class CityTable {
  static final instance = WeatherDatabase.instance;

  Future<bool> insert(CityModel model) async {
    final db = await instance.database;
    // var json = {
    //   "name": model.location!.name,
    //   "region": model.location!.region,
    //   "country": model.location!.country,
    //   "lat": model.location!.lat,
    //   "long": model.location!.lon,
    // };
    final List<Map<String, dynamic>> maps = await db.query(
      cityTableName,
      where: 'name = ?',
      whereArgs: [model.name],
    );
    if (maps.isNotEmpty) {
      return false;
    } else {
      await db.insert(cityTableName, model.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    }
  }

  Future<List<CityModel>> getAllCities() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(cityTableName);
    return List.generate(maps.length, (index) {
      return CityModel.fromJson(maps[index]);
    });
  }

  Future<CityModel?> getCity(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      cityTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CityModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCity(String name) async {
    final db = await instance.database;
    return await db.delete(
      cityTableName,
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<int> deleteAllCities() async {
    final db = await instance.database;
    return await db.delete(cityTableName);
  }
}
