import '../../entities/entities.dart';

abstract class DatabaseLocalRepository {
  Future<int> insertData(TareaEntity task);
  Future<bool> updateData({required String table, required TareaEntity task});
  Future<bool> deleteData(String id);
}
