import 'package:number_keyboard/utils/bounce_me.dart';
import 'package:number_keyboard/utils/reusable.dart';
import '../model/number_key_model.dart';
import 'package:flutter/material.dart';
import 'tap_status.dart';

class NumberKey extends StatefulWidget {
  final ValueSetter<dynamic> onTap;
  final NumberKeyModel numKey;
  final double keyHeight;
  final Color keyColor;

  const NumberKey({
    Key? key,
    required this.keyColor,
    required this.keyHeight,
    required this.numKey,
    required this.onTap,
  }) : super(key: key);

  @override
  State<NumberKey> createState() => _NumberKeyState();
}

class _NumberKeyState extends State<NumberKey>
    with SingleTickerProviderStateMixin {
  TapStatus tapStatus = TapStatus.up;

  @override
  Widget build(BuildContext context) {
    return BounceMe(
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          setState(() => tapStatus = TapStatus.down);
        },
        onPointerUp: (PointerUpEvent event) {
          setState(() => tapStatus = TapStatus.up);
          widget.onTap(widget.numKey.value);
        },
        child: Container(
          height: widget.keyHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.keyColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow:
                tapStatus == TapStatus.down ? [Reusable.boxShadow] : null,
          ),
          child: lable,
        ),
      ),
    );
  }

  get lable => renderLabel();

  Widget renderLabel() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.numKey.primaryLabel,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          ///4:1
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  widget.numKey.secondaryLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox())
            ],
          ),
        ),
      ],
    );
  }
}
