import 'package:edencrew_assignment_starter/view/watch_list/watch_list_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/watchlist',
  routes: [
    GoRoute(
      path: '/watchlist',
      builder: (context, state) => const WatchListPage(),
    ),
  ],
);
