import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epicmobile/notifications/notification_card.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/providers/ui/unread_notifications_provider.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({
    Key? key,
    this.walletId,
  }) : super(key: key);

  final String? walletId;

  static const routeName = "/notifications";

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = widget.walletId == null
        ? ref
            .watch(notificationsProvider.select((value) => value.notifications))
        : ref
            .watch(notificationsProvider.select((value) => value.notifications))
            .where((element) => element.walletId == widget.walletId)
            .toList(growable: false);

    return Scaffold(
      backgroundColor: Theme.of(context).extension<StackColors>()!.background,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: STextStyles.navBarTitle(context),
        ),
        leading: AppBarBackButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: notifications.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: notifications.length,
                      itemBuilder: (builderContext, index) {
                        final notification = notifications[index];
                        if (notification.read == false) {
                          ref
                              .read(unreadNotificationsStateProvider.state)
                              .state
                              .add(notification.id);
                        }
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: NotificationCard(
                            notification: notifications[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: RoundedWhiteContainer(
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Notifications will appear here",
                            style: STextStyles.itemSubtitle(context),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
