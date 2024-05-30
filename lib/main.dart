import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'config/go_router/router.dart';
import 'presentation/bloc/blocs.dart';
import 'presentation/bloc/service_location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await locator.isReady<Database>();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => locator<HomeBloc>(),
        ),
        BlocProvider<TareasUsuarioCubit>(
          create: (BuildContext context) => locator<TareasUsuarioCubit>(),
        ),
        BlocProvider<TaskCompletedCubit>(
          create: (BuildContext context) => locator<TaskCompletedCubit>(),
        ),
        BlocProvider<UpdateTaskCubit>(
          create: (BuildContext context) => locator<UpdateTaskCubit>(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Examen seekoo',
      routerConfig: appRouter,
    );
  }
}
