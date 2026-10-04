import 'package:edencrew_assignment_starter/theme/app_theme.dart';
import 'package:edencrew_assignment_starter/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppBottomAppBar extends StatelessWidget {
  const AppBottomAppBar({super.key, required this.isLikeActive});

  final bool isLikeActive;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // height: context.dimens.tabBarHeight,
      color: context.colors.surfaceRaised,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    isLikeActive
                        ? 'assets/images/ico_starFill.png'
                        : 'assets/images/ico_star-2.png',
                  ),
                ),
                Text(
                  '관심',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: AppTypography.regular,
                    color: isLikeActive
                        ? context.colors.navActive
                        : context.colors.navInactive,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    isLikeActive
                        ? 'assets/images/ico_search.png'
                        : 'assets/images/ico_search-2.png',
                  ),
                ),
                Text(
                  '검색',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: AppTypography.regular,
                    color: isLikeActive
                        ? context.colors.navActive
                        : context.colors.navInactive,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
