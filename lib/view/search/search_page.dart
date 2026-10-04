import 'package:edencrew_assignment_starter/domain/entity/stock_entity.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/view/components/app_bottom_app_bar.dart';
import 'package:edencrew_assignment_starter/viewmodel/search/search_view_model.dart';
import 'package:edencrew_assignment_starter/viewmodel/watch_list/watch_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchViewModelProvider);
    final searchVM = ref.read(searchViewModelProvider.notifier);
    final bool isLikeActive = false;
    ref.watch(watchListViewModelProvider);
    final watchListVM = ref.read(watchListViewModelProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dimens.space4)
                  .copyWith(
                    top: context.dimens.space2,
                    bottom: context.dimens.space3,
                  ),
              child: Container(
                height: 40,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: context.dimens.space3,
                ),
                decoration: BoxDecoration(
                  color: context.colors.surfaceSunken,
                  borderRadius: BorderRadius.circular(context.dimens.radiusMd),
                  border: Border.all(
                    width: 1,
                    color: context.colors.borderStrong,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          searchVM.searchStocks(textEditingController.text),
                      child: SizedBox(
                        width: context.dimens.iconSm,
                        height: context.dimens.iconSm,
                        child: Image.asset('assets/images/ico_search.png'),
                      ),
                    ),
                    SizedBox(width: context.dimens.space2),
                    Expanded(
                      child: Center(
                        child: TextField(
                          onSubmitted: (value) => searchVM.searchStocks(value),
                          controller: textEditingController,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: AppTypography.medium,
                            color: context.colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: '종목명 또는 종목코드',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: AppTypography.medium,
                              color: context.colors.textTertiary,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        textEditingController.clear();
                        searchVM.textClear();
                      },
                      child: SizedBox(
                        width: context.dimens.iconSm,
                        height: context.dimens.iconSm,
                        child: Image.asset('assets/images/ico_x.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            searchState.inputText.isEmpty
                ? EmptySearch()
                : searchState.results.isEmpty
                ? IncorrectSearch(inputText: searchState.inputText)
                : Expanded(
                    child: ListView.builder(
                      itemCount: searchState.results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.push(
                            '/detail/${searchState.results[index].code}',
                          ),
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
                                        searchState.results[index].name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: AppTypography.medium,
                                          height: 20 / 15,
                                          color: context.colors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        "${searchState.results[index].code} · ${searchState.results[index].market}",
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
                                GestureDetector(
                                  onTap: () {
                                    watchListVM.changeWatchedStock(
                                      StockEntity(
                                        code: searchState.results[index].code,
                                        name: searchState.results[index].name,
                                        market:
                                            searchState.results[index].market,
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: Image.asset(
                                      watchListVM.isWatchedStock(
                                            searchState.results[index].code,
                                          )
                                          ? 'assets/images/ico_starFill-2.png'
                                          : 'assets/images/ico_star-2.png',
                                    ),
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

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

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
              child: Image.asset('assets/images/ico_search-3.png'),
            ),
            SizedBox(height: context.dimens.space3),
            Text(
              '종목을 검색해 보세요',
              style: TextStyle(
                fontSize: 19,
                fontWeight: AppTypography.bold,
                color: context.colors.textSecondary,
              ),
            ),
            SizedBox(height: context.dimens.space3),
            Text(
              textAlign: TextAlign.center,
              '종목명 또는 종목코드 6자리로\n검색하실 수 있습니다.',
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

class IncorrectSearch extends StatelessWidget {
  const IncorrectSearch({super.key, required this.inputText});

  final String inputText;

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
              child: Image.asset('assets/images/ico_search_empty.png'),
            ),
            SizedBox(height: context.dimens.space3),
            Text(
              '검색 결과가 없습니다',
              style: TextStyle(
                fontSize: 19,
                fontWeight: AppTypography.bold,
                color: context.colors.textSecondary,
              ),
            ),
            SizedBox(height: context.dimens.space3),
            Text(
              textAlign: TextAlign.center,
              "'$inputText'와\n일치하는 검색 결과를 찾지 못했습니다.",
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
