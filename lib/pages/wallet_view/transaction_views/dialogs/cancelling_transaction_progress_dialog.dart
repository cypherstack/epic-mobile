import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/stack_dialog.dart';

class CancellingTransactionProgressDialog extends StatefulWidget {
  const CancellingTransactionProgressDialog({Key? key}) : super(key: key);

  @override
  State<CancellingTransactionProgressDialog> createState() =>
      _CancellingTransactionProgressDialogState();
}

class _CancellingTransactionProgressDialogState
    extends State<CancellingTransactionProgressDialog>
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
        title: "Cancelling transaction",
        message: "This may take a while. Please do not exit this screen.",
        icon: RotationTransition(
          turns: _spinAnimation,
          child: SvgPicture.asset(
            Assets.svg.arrowRotate3,
            width: 24,
            height: 24,
            color: Theme.of(context).extension<StackColors>()!.accentColorDark,
          ),
        ),
        // rightButton: TextButton(
        //   style: Theme.of(context).textButtonTheme.style?.copyWith(
        //     backgroundColor: MaterialStateProperty.all<Color>(
        //       CFColors.buttonGray,
        //     ),
        //   ),
        //   child: Text(
        //     "Cancel",
        //     style: STextStyles.itemSubtitle12(context),
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     onCancel.call();
        //   },
        // ),
      ),
    );
  }
}
