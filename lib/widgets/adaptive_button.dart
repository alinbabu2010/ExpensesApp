import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function onClicked;

  const AdaptiveButton(
    this.text,
    this.onClicked, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            onPressed: () => onClicked(),
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: Text(text),
          )
        : CupertinoButton(
            onPressed: () => onClicked(),
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            color: Theme.of(context).primaryColor,
            child: Text(text),
          );
  }
}
