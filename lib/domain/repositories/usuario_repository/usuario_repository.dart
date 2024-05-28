import 'package:examen_seekoo/domain/entities/entities.dart';

abstract class UsuarioRepository {
  Future<List<UsuarioEntitie>> getUsuarios();
}
