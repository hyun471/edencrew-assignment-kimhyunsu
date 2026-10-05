import 'package:edencrew_assignment_starter/core/utils/format_datetime.dart';
import 'package:edencrew_assignment_starter/core/utils/format_price.dart';
import 'package:edencrew_assignment_starter/domain/entity/daily_entity.dart';
import 'package:edencrew_assignment_starter/domain/entity/period.dart';
import 'package:edencrew_assignment_starter/domain/entity/realtime_entity.dart';
import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:edencrew_assignment_starter/view/components/skeleton_box.dart';
import 'package:edencrew_assignment_starter/view/detail/widgets/detail_widget.dart';
import 'package:edencrew_assignment_starter/viewmodel/detail/detail_view_model.dart';
import 'package:edencrew_assignment_starter/viewmodel/watch_list/watch_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, required this.code});

  final String code;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(detailViewModelProvider.notifier).getStockDetail(widget.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(detailViewModelProvider);
    final detailVM = ref.read(detailViewModelProvider.notifier);
    ref.watch(watchListViewModelProvider);
    final watchListVM = ref.read(watchListViewModelProvider.notifier);
    final stock = detailState.stock;

    // 종목 정보를 받기 전: 로딩 또는 오류
    if (stock == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: detailState.errorCode != null
              ? Text(
                  detailState.errorCode!.message,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: AppTypography.regular,
                    color: context.colors.textSecondary,
                  ),
                )
              : CircularProgressIndicator(color: context.colors.accentDefault),
        ),
      );
    }

    final quote = detailState.quote;
    final isWatched = watchListVM.isWatchedStock(stock.code);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        shape: Border(
          bottom: BorderSide(
            color: context.colors.borderSubtle,
            width: context.dimens.borderHairline,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stock.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 15,
                fontWeight: AppTypography.medium,
              ),
            ),
            Text(
              '${stock.code} · ${stock.market}',
              style: TextStyle(
                color: context.colors.textSecondary,
                fontSize: 11,
                fontWeight: AppTypography.regular,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => watchListVM.changeWatchedStock(stock),
            child: SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                isWatched
                    ? 'assets/images/ico_starFill-2.png'
                    : 'assets/images/ico_star-2.png',
              ),
            ),
          ),
          SizedBox(width: context.dimens.space4),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: context.dimens.space4,
            vertical: context.dimens.space4,
          ),
          children: [
            // 현재가 + 등락
            quote == null
                ? const Row(
                    children: [
                      SkeletonBox(width: 140, height: 32),
                      SizedBox(width: 8),
                      SkeletonBox(width: 100, height: 16),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        FormatPrice.comma(quote.currentPrice),
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 30,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      SizedBox(width: context.dimens.space2),
                      Text(
                        FormatPrice.arrowChange(quote.change, quote.changeRate),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: AppTypography.medium,
                          color: quote.change > 0
                              ? context.colors.priceUpText
                              : quote.change < 0
                              ? context.colors.priceDownText
                              : context.colors.priceFlatText,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: context.dimens.space4),

            // 기간 탭
            SizedBox(
              height: 28,
              child: Row(
                children: [
                  for (final period in Period.values)
                    Expanded(
                      child: PeriodChip(
                        selectedPeriod: detailState.period,
                        period: period,
                        detailVM: detailVM,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: context.dimens.space4),

            // 캔들 차트
            SizedBox(
              height: 200,
              child: detailState.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: context.colors.accentDefault,
                      ),
                    )
                  : CandleChart(dailyList: detailState.daily),
            ),
            if (detailState.errorCode != null) ...[
              SizedBox(height: context.dimens.space2),
              Text(
                detailState.errorCode!.message,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: AppTypography.regular,
                  color: context.colors.textSecondary,
                ),
              ),
            ],
            SizedBox(height: context.dimens.space4),

            // 요약 카드
            if (quote != null) SummaryCards(quote: quote),
            SizedBox(height: context.dimens.space6),

            // 일별 시세 표
            Text(
              '일별 시세',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 15,
                fontWeight: AppTypography.bold,
              ),
            ),
            SizedBox(height: context.dimens.space2),
            DailyTable(dailyList: detailState.daily),
          ],
        ),
      ),
    );
  }
}

class PeriodChip extends StatelessWidget {
  const PeriodChip({
    super.key,
    required this.selectedPeriod,
    required this.period,
    required this.detailVM,
  });

  final Period selectedPeriod;
  final Period period;
  final DetailViewModel detailVM;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedPeriod == period;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => detailVM.changePeriod(period),
      child: Container(
        height: 28,
        decoration: BoxDecoration(
          color: isSelected ? context.colors.accentBg : null,
          borderRadius: BorderRadius.circular(context.dimens.radiusMd),
        ),
        child: Center(
          child: Text(
            period.label,
            style: TextStyle(
              color: isSelected
                  ? context.colors.accentDefault
                  : context.colors.textSecondary,
              fontSize: 13,
              fontWeight: AppTypography.regular,
            ),
          ),
        ),
      ),
    );
  }
}

// 요약 카드: 시가 / 고가 / 저가, 거래량 / 시가총액
class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key, required this.quote});

  final RealtimeEntity quote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                label: '시가',
                value: FormatPrice.comma(quote.openPrice),
              ),
            ),
            SizedBox(width: context.dimens.space2),
            Expanded(
              child: SummaryCard(
                label: '고가',
                value: FormatPrice.comma(quote.highPrice),
              ),
            ),
            SizedBox(width: context.dimens.space2),
            Expanded(
              child: SummaryCard(
                label: '저가',
                value: FormatPrice.comma(quote.lowPrice),
              ),
            ),
          ],
        ),
        SizedBox(height: context.dimens.space2),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                label: '거래량',
                value: FormatPrice.volume(quote.volume),
              ),
            ),
            SizedBox(width: context.dimens.space2),
            Expanded(
              child: SummaryCard(
                label: '시가총액',
                value: FormatPrice.marketCap(quote.marketCap),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.dimens.space3),
      decoration: BoxDecoration(
        color: context.colors.surfaceRaised,
        borderRadius: BorderRadius.circular(context.dimens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: context.colors.textTertiary,
              fontSize: 11,
              fontWeight: AppTypography.regular,
            ),
          ),
          SizedBox(height: context.dimens.space1),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 15,
              fontWeight: AppTypography.medium,
            ),
          ),
        ],
      ),
    );
  }
}

// 일별 시세 표: 최신 날짜가 위
class DailyTable extends StatelessWidget {
  const DailyTable({super.key, required this.dailyList});

  final List<DailyEntity> dailyList;

  @override
  Widget build(BuildContext context) {
    final rows = dailyList.reversed.toList();
    return Column(
      children: [
        DailyTableRow(
          date: '날짜',
          closePrice: '종가',
          change: '등락',
          volume: '거래량',
          isHeader: true,
        ),
        for (final data in rows)
          DailyTableRow(
            date: FormatDatetime.monthDay(data.date),
            closePrice: FormatPrice.comma(data.closePrice),
            change: FormatPrice.signed(data.change),
            volume: FormatPrice.comma(data.volume),
            changeValue: data.change,
          ),
      ],
    );
  }
}

class DailyTableRow extends StatelessWidget {
  const DailyTableRow({
    super.key,
    required this.date,
    required this.closePrice,
    required this.change,
    required this.volume,
    this.changeValue = 0,
    this.isHeader = false,
  });

  final String date;
  final String closePrice;
  final String change;
  final String volume;
  final int changeValue;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      color: context.colors.textTertiary,
      fontSize: 11,
      fontWeight: AppTypography.regular,
    );
    TextStyle rowStyle(Color color) => TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: AppTypography.regular,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.dimens.space3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colors.borderSubtle,
            width: context.dimens.borderHairline,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              date,
              style: isHeader
                  ? headerStyle
                  : rowStyle(context.colors.textSecondary),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              closePrice,
              textAlign: TextAlign.right,
              style: isHeader
                  ? headerStyle
                  : rowStyle(context.colors.textPrimary),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              change,
              textAlign: TextAlign.right,
              style: isHeader
                  ? headerStyle
                  : rowStyle(
                      changeValue > 0
                          ? context.colors.priceUpText
                          : changeValue < 0
                          ? context.colors.priceDownText
                          : context.colors.priceFlatText,
                    ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              volume,
              textAlign: TextAlign.right,
              style: isHeader
                  ? headerStyle
                  : rowStyle(context.colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
