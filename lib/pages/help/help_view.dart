import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/background.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  static const String routeName = "/help";

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Help",
            style: STextStyles.titleH4(context),
          ),
          leading: const AppBarBackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "COMMUNITY SUPPORT",
                style: STextStyles.overLineBold(context),
              ),
              const SizedBox(
                height: 24,
              ),
              HelpItem(
                label: "Telegram",
                iconAsset: Assets.socials.telegram,
                url: "https://t.me/EpicCash",
              ),
              const SizedBox(
                height: 32,
              ),
              HelpItem(
                label: "Twitter",
                iconAsset: Assets.socials.twitter,
                url: "https://twitter.com/EpicCashTech",
              ),
              const SizedBox(
                height: 32,
              ),
              HelpItem(
                label: "Reddit",
                iconAsset: Assets.socials.reddit,
                url: "https://www.reddit.com/r/epiccash",
              ),
              const SizedBox(
                height: 42,
              ),
              // Text(
              //   "WALLET INFO",
              //   style: STextStyles.overLineBold(context),
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              // HelpItem(
              //   label: "Wallet guide",
              //   iconAsset: Assets.socials.compass,
              //   url: "url",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  const HelpItem({
    Key? key,
    required this.label,
    required this.iconAsset,
    required this.url,
  }) : super(key: key);

  final String label;
  final String iconAsset;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              child: Center(
                child: SvgPicture.asset(
                  iconAsset,
                  color: Theme.of(context).extension<StackColors>()!.textDark,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              label,
              style: STextStyles.bodyBold(context),
            )
          ],
        ),
      ),
    );
  }
}