import '../../entities/entities.dart';

abstract class BorrarTareaLocalDataSource {
  Future<String> deleteTarea({required TareaEntity tarea});
}
