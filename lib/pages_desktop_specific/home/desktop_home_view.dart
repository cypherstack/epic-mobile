import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackwallet/pages_desktop_specific/home/desktop_menu.dart';
import 'package:stackwallet/pages_desktop_specific/home/desktop_settings_view.dart';
import 'package:stackwallet/pages_desktop_specific/home/my_stack_view/my_stack_view.dart';
import 'package:stackwallet/pages_desktop_specific/home/support_and_about_view/desktop_support_view.dart';
import 'package:stackwallet/route_generator.dart';
import 'package:stackwallet/utilities/theme/stack_colors.dart';

class DesktopHomeView extends ConsumerStatefulWidget {
  const DesktopHomeView({Key? key}) : super(key: key);

  static const String routeName = "/desktopHome";

  @override
  ConsumerState<DesktopHomeView> createState() => _DesktopHomeViewState();
}

class _DesktopHomeViewState extends ConsumerState<DesktopHomeView> {
  int currentViewIndex = 0;
  final List<Widget> contentViews = [
    const Navigator(
      key: Key("desktopStackHomeKey"),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: MyStackView.routeName,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.orange,
    ),
    const Navigator(
      key: Key("desktopSettingHomeKey"),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: DesktopSettingsView.routeName,
    ),
    const Navigator(
      key: Key("desktopSupportHomeKey"),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: DesktopSupportView.routeName,
    ),
    Container(
      color: Colors.pink,
    ),
  ];

  void onMenuSelectionChanged(int newIndex) {
    setState(() {
      currentViewIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).extension<StackColors>()!.background,
      child: Row(
        children: [
          DesktopMenu(
            onSelectionChanged: onMenuSelectionChanged,
          ),
          Container(
            width: 1,
            color: Theme.of(context).extension<StackColors>()!.background,
          ),
          Expanded(
            child: contentViews[currentViewIndex],
          ),
        ],
      ),
    );
  }
}
