import 'package:examen_seekoo/data/models/models.dart';

import '../../../domain/entities/entities.dart';

List<UsuarioEntitie> usuariosMapper(List<UsuarioModel> usuarioModel) {
  return usuarioModel
      .map(
        (usuario) => UsuarioEntitie(
          id: usuario.id,
          name: usuario.name,
          username: usuario.username,
          email: usuario.email,
          address: addressUsuarioMapper(usuario.address),
          phone: usuario.phone,
          website: usuario.website,
          company: usuario.company.name,
          listaTareas: tareaMapper(usuario.listaTareas!),
          error: null,
        ),
      )
      .toList();
}

AddressUsuarioEntitie addressUsuarioMapper(Address addressUsuarioModel) {
  return AddressUsuarioEntitie(
    street: addressUsuarioModel.street,
    suite: addressUsuarioModel.suite,
    city: addressUsuarioModel.city,
    zipcode: addressUsuarioModel.zipcode,
  );
}

List<TareaEntity> tareaMapper(List<TareaModel> tareaModel) {
  return tareaModel
      .map(
        (tarea) => TareaEntity(
          userId: tarea.userId,
          id: tarea.id,
          title: tarea.title,
          completed: tarea.completed,
        ),
      )
      .toList();
}
