import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextStyle? style;
  final bool shouldExpand;
  final int? maxLines;
  final int? minLines;

  const InputField({
    Key? key,
    this.hintText,
    this.controller,
    this.style,
    this.shouldExpand = false,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: shouldExpand ? null : maxLines,
      minLines: shouldExpand ? null : minLines,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryVariant,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
    );
  }
}
