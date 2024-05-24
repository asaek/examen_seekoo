import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';

class TareasUsuarioPage extends StatelessWidget {
  static const routerName = '/tareas_usuario';

  const TareasUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas de usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<TareasUsuarioCubit, TareasUsuarioState>(
        builder: (context, state) {
          // final List<TareaEntity>? tareas = state.tareas;

          if (state.tareas == null) {
            return const Center(
              child: Text('No hay tareas'),
            );
          }
          return ListView.builder(
            itemCount: state.tareas!.length,
            itemBuilder: (context, index) {
              return SizedBox(
                child: Material(
                  child: ListTile(
                    title: Text(state.tareas![index].title),
                    subtitle: (state.tareas![index].completed)
                        ? const Text("Terminada")
                        : const Text('Pendiente'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // context.read<TareasUsuarioCubit>().removeTareaUsuario(
                            //       tareas[index],
                            //     );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<TareasUsuarioCubit>()
                                .removeTareaUsuario(
                                  state.tareas![index],
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
