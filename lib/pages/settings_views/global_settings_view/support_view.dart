import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/conditional_parent.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/custom_buttons/blue_text_button.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  const SupportView({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/support";
  final double iconSize = 28;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Util.isDesktop;

    debugPrint("BUILD: $runtimeType");

    return ConditionalParent(
      condition: !isDesktop,
      builder: (child) {
        return Scaffold(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          appBar: AppBar(
            leading: AppBarBackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Support",
              style: STextStyles.navBarTitle(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedWhiteContainer(
            child: Text(
              "If you need support or want to report a bug, reach out to us on any of our socials!",
              style: STextStyles.smallMed12(context),
            ),
          ),
          isDesktop
              ? const SizedBox(
                  height: 24,
                )
              : const SizedBox(
                  height: 12,
                ),
          RoundedWhiteContainer(
            padding: const EdgeInsets.all(0),
            child: RawMaterialButton(
              // splashColor: Theme.of(context).extension<StackColors>()!.highlight,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              onPressed: () {
                if (!isDesktop) {
                  launchUrl(
                    Uri.parse("https://t.me/epicmobile"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.socials.telegram,
                          width: iconSize,
                          height: iconSize,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .accentColorDark,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Telegram",
                          style: STextStyles.titleBold12(context),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    BlueTextButton(
                      text: isDesktop ? "@epicmobile" : "",
                      onTap: () {
                        launchUrl(
                          Uri.parse("https://t.me/epicmobile"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RoundedWhiteContainer(
            padding: const EdgeInsets.all(0),
            child: RawMaterialButton(
              // splashColor: Theme.of(context).extension<StackColors>()!.highlight,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              onPressed: () {
                if (!isDesktop) {
                  launchUrl(
                    Uri.parse("https://discord.gg/RZMG3yUm"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.socials.discord,
                          width: iconSize,
                          height: iconSize,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .accentColorDark,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Discord",
                          style: STextStyles.titleBold12(context),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    BlueTextButton(
                      text: isDesktop ? "Stack Wallet" : "",
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              "https://discord.gg/RZMG3yUm"), //expired link?
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RoundedWhiteContainer(
            padding: const EdgeInsets.all(0),
            child: RawMaterialButton(
              // splashColor: Theme.of(context).extension<StackColors>()!.highlight,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              onPressed: () {
                if (!isDesktop) {
                  launchUrl(
                    Uri.parse("https://www.reddit.com/r/epicmobile/"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.socials.reddit,
                          width: iconSize,
                          height: iconSize,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .accentColorDark,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Reddit",
                          style: STextStyles.titleBold12(context),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    BlueTextButton(
                      text: isDesktop ? "r/epicmobile" : "",
                      onTap: () {
                        launchUrl(
                          Uri.parse("https://www.reddit.com/r/epicmobile/"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RoundedWhiteContainer(
            padding: const EdgeInsets.all(0),
            child: RawMaterialButton(
              // splashColor: Theme.of(context).extension<StackColors>()!.highlight,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              onPressed: () {
                if (!isDesktop) {
                  launchUrl(
                    Uri.parse("https://twitter.com/stack_wallet"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.socials.twitter,
                          width: iconSize,
                          height: iconSize,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .accentColorDark,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Twitter",
                          style: STextStyles.titleBold12(context),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    BlueTextButton(
                      text: isDesktop ? "@stack_wallet" : "",
                      onTap: () {
                        launchUrl(
                          Uri.parse("https://twitter.com/stack_wallet"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RoundedWhiteContainer(
            padding: const EdgeInsets.all(0),
            child: RawMaterialButton(
              // splashColor: Theme.of(context).extension<StackColors>()!.highlight,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              onPressed: () {
                if (!isDesktop) {
                  launchUrl(
                    Uri.parse("mailto://support@epicmobile.com"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.envelope,
                          width: iconSize,
                          height: iconSize,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .accentColorDark,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Email",
                          style: STextStyles.titleBold12(context),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    BlueTextButton(
                      text: isDesktop ? "support@epicmobile.com" : "",
                      onTap: () {
                        launchUrl(
                          Uri.parse("mailto://support@epicmobile.com"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
