import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/models/notification_model.dart';
import 'package:epicmobile/utilities/format.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/rounded_container.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationModel notification;

  String extractPrettyDateString(DateTime date) {
    // TODO: format this differently to better match the design
    return Format.extractDateFrom(date.millisecondsSinceEpoch ~/ 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundedWhiteContainer(
          child: Row(
            children: [
              notification.changeNowId == null
                  ? SvgPicture.asset(
                      notification.iconAssetName,
                      width: 24,
                      height: 24,
                    )
                  : Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: SvgPicture.asset(
                        notification.iconAssetName,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .accentColorDark,
                        width: 24,
                        height: 24,
                      ),
                    ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      notification.title,
                      style: STextStyles.titleBold12(context),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.description,
                          style: STextStyles.label(context),
                        ),
                        Text(
                          extractPrettyDateString(notification.date),
                          style: STextStyles.label(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (notification.read)
          Positioned.fill(
            child: RoundedContainer(
              color: Theme.of(context)
                  .extension<StackColors>()!
                  .background
                  .withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
