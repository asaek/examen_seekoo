import 'package:examen_seekoo/domain/repositories/repositories.dart';

import '../../entities/entities.dart';

sealed class GetUsuariosUserCase {
  Future<List<UsuarioEntitie>> getUsuarios();
}

class GetUsuariosUserCaseImpl extends GetUsuariosUserCase {
  final UsuarioRepository usuarioRepository;

  GetUsuariosUserCaseImpl({required this.usuarioRepository});

  @override
  Future<List<UsuarioEntitie>> getUsuarios() async {
    return await usuarioRepository.getUsuarios();
  }
}
