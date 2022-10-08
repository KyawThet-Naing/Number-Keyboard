import 'package:number_keyboard/model/number_key_model.dart';
import 'package:flutter/material.dart';
import 'backspace_key.dart';
import 'number_key.dart';

class NumberKeyboard extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double keyHeight;
  final Color? keyboardColor;
  final Color keyColor;

  final bool clickable;

  const NumberKeyboard({
    Key? key,
    this.keyboardColor,
    this.keyColor = Colors.blue,
    this.keyHeight = 55,
    this.clickable = true,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 20,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NumberKeyboard> createState() => _NumberKeyboardState();
}

class _NumberKeyboardState extends State<NumberKeyboard> {
  String enteredValue = "";

  final List<List<NumberKeyModel>> keys = [
    ///for row 1
    [
      NumberKeyModel(primaryLabel: '1', value: '1'),
      NumberKeyModel(primaryLabel: '2', value: '2', secondaryLabel: 'ABC'),
      NumberKeyModel(primaryLabel: '3', value: '3', secondaryLabel: 'DEF'),
    ],

    ///for row 2
    [
      NumberKeyModel(primaryLabel: '4', value: '4', secondaryLabel: 'GHI'),
      NumberKeyModel(primaryLabel: '5', value: '5', secondaryLabel: 'JKL'),
      NumberKeyModel(primaryLabel: '6', value: '6', secondaryLabel: 'MNO'),
    ],

    ///for row 3
    [
      NumberKeyModel(primaryLabel: '7', value: '7', secondaryLabel: 'PQRS'),
      NumberKeyModel(primaryLabel: '8', value: '8', secondaryLabel: 'TUV'),
      NumberKeyModel(primaryLabel: '9', value: '9', secondaryLabel: 'WXYZ'),
    ],

    ///for row 4
    [
      NumberKeyModel(isBlank: true),
      NumberKeyModel(primaryLabel: '0', value: '0', secondaryLabel: '+'),
      NumberKeyModel(isBackspace: true),
    ],
  ];

  deleteEnteredValue() {
    if (enteredValue.isNotEmpty) {
      enteredValue = enteredValue.substring(0, enteredValue.length - 1);
    }
    widget.onChanged(enteredValue);
  }

  _getKey(NumberKeyModel model) {
    if (model.isBlank) {
      return const SizedBox();
    } else if (model.isBackspace) {
      return BackspaceKey(
        keyColor: widget.keyColor,
        keyHeight: widget.keyHeight,
        onBackspace: () => deleteEnteredValue(),
      );
    } else {
      return NumberKey(
        numKey: model,
        keyColor: widget.keyColor,
        keyHeight: widget.keyHeight,
        onTap: (number) {
          ///if clickable is flase,
          if (!widget.clickable) return;

          ///if clickable is true,
          enteredValue += number;
          widget.onChanged(enteredValue);
        },
      );
    }
  }

  List<Widget> renderKeyboard() {
    return keys
        .map(
          (row) => Row(
            children: [
              SizedBox(width: widget.crossAxisSpacing),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: row.map(
                        (value) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: widget.crossAxisSpacing,
                              ),
                              child: _getKey(value),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: widget.mainAxisSpacing),
                  ],
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.keyboardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: widget.mainAxisSpacing),
          ...renderKeyboard()
        ],
      ),
    );
  }
}
