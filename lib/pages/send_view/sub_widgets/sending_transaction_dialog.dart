import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/stack_dialog.dart';

class SendingTransactionDialog extends StatefulWidget {
  const SendingTransactionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SendingTransactionDialog> createState() => _RestoringDialogState();
}

class _RestoringDialogState extends State<SendingTransactionDialog>
    with TickerProviderStateMixin {
  late AnimationController? _spinController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    _spinController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _spinAnimation = CurvedAnimation(
      parent: _spinController!,
      curve: Curves.linear,
    );

    super.initState();
  }

  @override
  void dispose() {
    _spinController?.dispose();
    _spinController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: StackDialog(
        title: "Sending transaction",
        // // TODO get message from design team
        // message: "<PLACEHOLDER>",
        icon: RotationTransition(
          turns: _spinAnimation,
          child: SvgPicture.asset(
            Assets.svg.arrowRotate,
            color: Theme.of(context).extension<StackColors>()!.accentColorDark,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
