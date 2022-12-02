import 'package:epicmobile/pages/wallet_view/sub_widgets/wallet_summary_info.dart';
import 'package:epicmobile/providers/global/wallet_provider.dart';
import 'package:epicmobile/services/event_bus/events/global/wallet_sync_status_changed_event.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletSummary extends StatelessWidget {
  const WalletSummary({
    Key? key,
    required this.walletId,
    required this.initialSyncStatus,
    this.aspectRatio = 2.0,
    this.minHeight = 100.0,
    this.minWidth = 200.0,
    this.maxHeight = 250.0,
    this.maxWidth = 400.0,
  }) : super(key: key);

  final String walletId;
  final WalletSyncStatus initialSyncStatus;

  final double aspectRatio;
  final double minHeight;
  final double minWidth;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight,
          minWidth: minWidth,
          maxHeight: maxHeight,
          maxWidth: minWidth,
        ),
        child: Stack(
          children: [
            Consumer(
              builder: (_, ref, __) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .extension<StackColors>()!
                        .colorForCoin(ref.watch(
                            walletProvider.select((value) => value!.coin))),
                    borderRadius: BorderRadius.circular(
                      Constants.size.circularBorderRadius,
                    ),
                  ),
                );
              },
            ),
            Positioned.fill(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 6,
                    child: SvgPicture.asset(
                      Assets.svg.ellipse1,
                      // fit: BoxFit.fitWidth,
                      // clipBehavior: Clip.none,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
            // Positioned.fill(
            //   child:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: SvgPicture.asset(
                      Assets.svg.ellipse2,
                      // fit: BoxFit.f,
                      // clipBehavior: Clip.none,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                ],
              ),
            ),
            //   ],
            // ),
            // ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WalletSummaryInfo(
                  walletId: walletId,
                  initialSyncStatus: initialSyncStatus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
