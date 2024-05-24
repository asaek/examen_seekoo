import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/blocs.dart';
import '../pages.dart';

class HomePage extends StatefulWidget {
  static const routerName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(state.error),
              );
            }
            //? Mostrará la información principal de cada usuario: nombre, correo
            //? electrónico, teléfono, dirección, empresa y sitio web.

            if (state is HomeLoaded) {
              return ListView.builder(
                itemCount: state.usuarios.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // height: 100,
                      child: Material(
                        color: const Color.fromARGB(255, 219, 219, 219),
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          onTap: () {
                            context.read<TareasUsuarioCubit>().setTareasUsuario(
                                  state.usuarios[index].listaTareas,
                                );
                            context.push(TareasUsuarioPage.routerName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Nombre: ${state.usuarios[index].name}'),
                                    Text(
                                        'Correo: ${state.usuarios[index].email}'),
                                    Text(
                                        'Teléfono: ${state.usuarios[index].phone}'),
                                    Text(
                                        'Dirección: ${state.usuarios[index].address}'),
                                    Text(
                                        'Empresa: ${state.usuarios[index].company}'),
                                    Text(
                                        'Sitio web: ${state.usuarios[index].website}'),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// class _BotonTester extends StatelessWidget {
//   const _BotonTester();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Material(
//           color: Colors.orange,
//           child: InkWell(
//             onTap: () {
//               context.read<HomeBloc>().getUsuarios();
//             },
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Text(
//                 'Hola mundo',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _ButtonSearch extends StatelessWidget {
  const _ButtonSearch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Material(
            color: Colors.grey[200],
            child: InkWell(
              child: const Icon(Icons.search),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Busca una tarea',
            fillColor: Colors.grey[100],
            filled: true,
            // prefixIcon: const Icon(Icons.search),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: (value) {},
          onSubmitted: (value) {
            print("El usuario ha ingresado: $value");
          },
        ),
      ),
    );
  }
}
