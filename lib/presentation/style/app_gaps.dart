import 'package:chat_programming_test/presentation/style/app_dimens.dart';
import "package:flutter/material.dart";
import 'package:gap/gap.dart';

class AppGap extends StatelessWidget {
  const AppGap(this.gapSize, {super.key});

  /// 2.0
  const AppGap.two({super.key}) : gapSize = AppDimens.two;

  /// 4.0
  const AppGap.four({super.key}) : gapSize = AppDimens.four;

  /// 8.0
  const AppGap.eight({super.key}) : gapSize = AppDimens.eight;

  /// 12.0
  const AppGap.twelve({super.key}) : gapSize = AppDimens.twelve;

  /// 16.0
  const AppGap.sixteen({super.key}) : gapSize = AppDimens.sixteen;

  /// 20.0
  const AppGap.twenty({super.key}) : gapSize = AppDimens.twenty;

  /// 24.0
  const AppGap.twentyFour({super.key}) : gapSize = AppDimens.twentyFour;

  /// 32.0
  const AppGap.thirtyTwo({super.key}) : gapSize = AppDimens.thirtyTwo;

  /// 40.0
  const AppGap.forty({super.key}) : gapSize = AppDimens.forty;

  /// 48.0
  const AppGap.fortyEight({super.key}) : gapSize = AppDimens.fortyEight;

  /// 64.0
  const AppGap.sixtyFour({super.key}) : gapSize = AppDimens.sixtyFour;

  /// 80.0
  const AppGap.eighty({super.key}) : gapSize = AppDimens.eighty;

  final double gapSize;

  @override
  Widget build(BuildContext context) {
    return Gap(gapSize);
  }
}
