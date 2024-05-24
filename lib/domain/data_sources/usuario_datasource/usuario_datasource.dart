import 'package:examen_seekoo/domain/entities/entities.dart';

abstract class UsuarioDataSource {
  Future<List<UsuarioEntitie>> getUsuarios();
}
