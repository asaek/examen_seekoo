import '../../entities/entities.dart';

abstract class DatabaseLocalRepository {
  Future<int> insertData(TareaEntity task);
  Future<bool> updateData(String table, Map<String, dynamic> data);
  Future<bool> deleteData(String id);
}
