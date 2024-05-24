import '../../../config/database_helper/database_helper.dart';
import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/entities/entities.dart';

class BorrarTareaLocalDataSourceImpl implements BorrarTareaLocalDataSource {
  final DatabaseHelper databaseHelper;

  BorrarTareaLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> deleteTarea({required TareaEntity tarea}) async {
    final db = await databaseHelper.database;
    return '';
  }
}
