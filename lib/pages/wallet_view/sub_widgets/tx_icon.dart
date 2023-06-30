import 'package:epicpay/models/paymint/transactions_model.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class TxIcon extends StatelessWidget {
  const TxIcon({Key? key, required this.transaction}) : super(key: key);
  final Transaction transaction;

  static const Size size = Size(48, 48);

  String _getAssetName(
      bool isCancelled, bool isReceived, bool isPending, BuildContext context) {
    // if (!isReceived && transaction.subType == "mint") {
    //   if (isCancelled) {
    //     return Assets.svg.anonymizeFailed;
    //   }
    //   if (isPending) {
    //     return Assets.svg.anonymizePending;
    //   }
    //   return Assets.svg.anonymize;
    // }

    if (isReceived) {
      if (isCancelled) {
        return Assets.svg.receiveCancelled(context);
      }
      if (isPending) {
        return Assets.svg.receivePending(context);
      }
      return Assets.svg.receive(context);
    } else {
      if (isCancelled) {
        return Assets.svg.sendCancelled(context);
      }
      if (isPending) {
        return Assets.svg.sendPending(context);
      }
      return Assets.svg.send(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final txIsReceived = transaction.txType == "Received";

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: SvgPicture.asset(
          _getAssetName(
            transaction.isCancelled,
            txIsReceived,
            !transaction.confirmedStatus,
            context,
          ),
          width: size.width,
          height: size.height,
        ),
      ),
    );
  }
}
