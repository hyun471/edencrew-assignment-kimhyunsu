import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/view/components/app_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSortUp = true;
    final bool isLikeActive = true;
    final List<String> watchStockList = ["삼성", "전자"];
    final isUp = false;
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
                          '가나다순',
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
                            isSortUp
                                ? 'assets/images/ico_align@3x.png'
                                : 'assets/images/ico_align@3x-2.png',
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/images/ico_refresh.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // watchStockList.isEmpty
            //     ? EmptyWatchList()
            //     :
            Expanded(
              child: ListView.builder(
                itemCount: watchStockList.length,
                itemBuilder: (context, index) {
                  return Container(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                watchStockList[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: AppTypography.medium,
                                  height: 20 / 15,
                                  color: context.colors.textPrimary,
                                ),
                              ),
                              Text(
                                "${watchStockList[index]} · ${watchStockList[index]}",
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
                          width: 68,
                          height: 36,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                watchStockList[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: AppTypography.medium,
                                  color: context.colors.textPrimary,
                                ),
                              ),
                              Text(
                                "${watchStockList[index]}(${watchStockList[index]})",
                                style: TextStyle(
                                  height: 14 / 11,
                                  fontSize: 11,
                                  fontWeight: AppTypography.regular,
                                  color: isUp
                                      ? context.colors.priceUpText
                                      : context.colors.priceDownText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
