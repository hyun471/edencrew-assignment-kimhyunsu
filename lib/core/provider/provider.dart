import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/core/network/network.dart';
import 'package:edencrew_assignment_starter/data/data_source/daily_api_data_source.dart';
import 'package:edencrew_assignment_starter/data/data_source/detail_api_data_source.dart';
import 'package:edencrew_assignment_starter/data/data_source/realtime_api_data_source.dart';
import 'package:edencrew_assignment_starter/data/data_source/search_api_data_source.dart';
import 'package:edencrew_assignment_starter/data/repositories/realtime_repo_impl.dart';
import 'package:edencrew_assignment_starter/data/repositories/stock_daily_repo_impl.dart';
import 'package:edencrew_assignment_starter/data/repositories/stock_repo_impl.dart';
import 'package:edencrew_assignment_starter/domain/repositories/realtime_repo.dart';
import 'package:edencrew_assignment_starter/domain/repositories/stock_daily_repo.dart';
import 'package:edencrew_assignment_starter/domain/repositories/stock_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// dio
final dioProvider = Provider<Dio>((ref) => createDio());

// data source
final searchDataSourceProvider = Provider<SearchApiDataSource>(
  (ref) => SearchApiDataSource(ref.watch(dioProvider)),
);

final detailDataSourceProvider = Provider<DetailApiDataSource>(
  (ref) => DetailApiDataSource(ref.watch(dioProvider)),
);

final realtimeDataSourceProvider = Provider<RealtimeApiDataSource>(
  (ref) => RealtimeApiDataSource(ref.watch(dioProvider)),
);

final dailyDataSourceProvider = Provider<DailyApiDataSource>(
  (ref) => DailyApiDataSource(ref.watch(dioProvider)),
);

// repository
final stockRepoProvider = Provider<StockRepo>(
  (ref) => StockRepoImpl(
    ref.watch(detailDataSourceProvider),
    ref.watch(searchDataSourceProvider),
  ),
);

final realtimeRepoProvider = Provider<RealtimeRepo>(
  (ref) => RealtimeRepoImpl(ref.watch(realtimeDataSourceProvider)),
);

final stockDailyRepoProvider = Provider<StockDailyRepo>(
  (ref) => StockDailyRepoImpl(ref.watch(dailyDataSourceProvider)),
);
