import 'package:examen_seekoo/presentation/pages/pages.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomePage.routerName,
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: TareasUsuarioPage.routerName,
      path: '/tareas_usuario',
      builder: (context, state) => const TareasUsuarioPage(),
    ),
    GoRoute(
      name: AddNewTaskPage.routerName,
      path: '/add_new_task',
      builder: (context, state) => const AddNewTaskPage(),
    ),
  ],
);
