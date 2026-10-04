import 'package:edencrew_assignment_starter/core/utils/format_price.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/view/components/app_bottom_app_bar.dart';
import 'package:edencrew_assignment_starter/view/components/skeleton_box.dart';
import 'package:edencrew_assignment_starter/viewmodel/watch_list/watch_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WatchListPage extends ConsumerStatefulWidget {
  const WatchListPage({super.key});

  @override
  ConsumerState<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends ConsumerState<WatchListPage> {
  @override
  Widget build(BuildContext context) {
    final watchListState = ref.watch(watchListViewModelProvider);
    ref.watch(watchListViewModelProvider);
    final watchListVM = ref.read(watchListViewModelProvider.notifier);
    final bool isLikeActive = true;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 52,
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: context.dimens.space4,
                vertical: context.dimens.space3,
              ),
              child: Row(
                children: [
                  Text(
                    '관심',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: AppTypography.bold,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 104,
                    height: 28,
                    child: Row(
                      children: [
                        Text(
                          watchListState.sort.word,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: AppTypography.bold,
                            color: context.colors.textSecondary,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            // watchListState.ascending
                            //     ?
                            'assets/images/ico_align@3x.png',
                            // : 'assets/images/ico_align@3x-2.png',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            watchListVM.getStockPrice();
                          },
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset('assets/images/ico_refresh.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            watchListState.stocks.isEmpty
                ? EmptyWatchList()
                : Expanded(
                    child: ListView.builder(
                      itemCount: watchListState.stocks.length,
                      itemBuilder: (context, index) {
                        final stock = watchListState.stocks[index];
                        final quote = watchListState.price[stock.code];
                        return GestureDetector(
                          onTap: () => context.push('/detail/${stock.code}'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: context.colors.borderSubtle,
                                  width: 1,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.dimens.space4,
                              vertical: context.dimens.space3,
                            ),
                            width: double.infinity,
                            constraints: BoxConstraints(
                              minHeight: context.dimens.rowMinHeight,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stock.name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: AppTypography.medium,
                                          height: 20 / 15,
                                          color: context.colors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        "${stock.code} · ${stock.market}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: AppTypography.regular,
                                          height: 14 / 11,
                                          color: context.colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: quote == null
                                      ? const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SkeletonBox(width: 60, height: 14),
                                            SizedBox(height: 4),
                                            SkeletonBox(width: 44, height: 10),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              FormatPrice.comma(
                                                quote.currentPrice,
                                              ),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                    AppTypography.medium,
                                                color:
                                                    context.colors.textPrimary,
                                              ),
                                            ),
                                            Text(
                                              FormatPrice.change(
                                                quote.change,
                                                quote.changeRate,
                                              ),
                                              style: TextStyle(
                                                height: 14 / 11,
                                                fontSize: 11,
                                                fontWeight:
                                                    AppTypography.regular,
                                                color: quote.change > 0
                                                    ? context.colors.priceUpText
                                                    : quote.change < 0
                                                    ? context
                                                          .colors
                                                          .priceDownText
                                                    : context
                                                          .colors
                                                          .priceFlatText,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomAppBar(isLikeActive: isLikeActive),
    );
  }
}

class EmptyWatchList extends StatelessWidget {
  const EmptyWatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset('assets/images/ico_star.png'),
            ),
            SizedBox(height: context.dimens.space3),
            Text(
              '관심 종목이 없습니다',
              style: TextStyle(
                fontSize: 19,
                fontWeight: AppTypography.bold,
                color: context.colors.textSecondary,
              ),
            ),
            SizedBox(height: context.dimens.space3),
            Text(
              textAlign: TextAlign.center,
              '검색 탭에서 종목을 찾아\n별 아이콘을 눌러 추가해 주세요',
              style: TextStyle(
                fontSize: 11,
                fontWeight: AppTypography.regular,
                color: context.colors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
