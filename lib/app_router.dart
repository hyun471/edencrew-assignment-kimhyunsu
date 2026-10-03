import 'package:edencrew_assignment_starter/view/detail/detail_page.dart';
import 'package:edencrew_assignment_starter/view/search/search_page.dart';
import 'package:edencrew_assignment_starter/view/watch_list/watch_list_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/watchlist',
  routes: [
    GoRoute(
      path: '/watchlist',
      builder: (context, state) => const WatchListPage(),
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
    GoRoute(
      path: '/detail/:code',
      builder: (context, state) =>
          DetailPage(code: state.pathParameters['code']!),
    ),
  ],
);
