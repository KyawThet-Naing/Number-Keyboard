import 'package:number_keyboard/keyboard/tap_status.dart';
import 'package:number_keyboard/utils/bounce_me.dart';
import 'package:number_keyboard/utils/reusable.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BackspaceKey extends StatefulWidget {
  final Function onBackspace;
  final double keyHeight;
  final Color keyColor;
  const BackspaceKey({
    Key? key,
    required this.keyColor,
    required this.onBackspace,
    required this.keyHeight,
  }) : super(key: key);

  @override
  State<BackspaceKey> createState() => _BackspaceKeyState();
}

class _BackspaceKeyState extends State<BackspaceKey> {
  Timer? _timer;
  bool _longPressCanceled = false;
  TapStatus tapStatus = TapStatus.up;

  void _cancelLongPress() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }

  @override
  Widget build(BuildContext context) {
    return BounceMe(
      child: GestureDetector(
        onLongPress: () {
          _longPressCanceled = false;
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              if (!_longPressCanceled) {
                _timer =
                    Timer.periodic(const Duration(milliseconds: 150), (timer) {
                  widget.onBackspace();
                });
              }
            },
          );
        },
        onLongPressUp: () => _cancelLongPress(),
        onLongPressEnd: (_) => _cancelLongPress(),
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            setState(() => tapStatus = TapStatus.down);
          },
          onPointerUp: (PointerUpEvent event) {
            setState(() => tapStatus = TapStatus.up);
            widget.onBackspace();
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
            child: const Icon(
              Icons.backspace_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
