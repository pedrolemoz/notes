import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    this.enableButton = true,
    this.disabledColor,
    this.onPressed,
    this.buttonColor,
    this.iconLocation = IconLocation.beforeText,
    this.enableIcon = false,
    this.icon,
    this.iconColor,
    this.enableText = true,
    this.text,
    this.iconSize,
    this.textStyle,
    this.textColor,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius,
  })  : assert(
            !(enableIcon == false && enableText == false),
            throw Exception(
                'enableIcon and enableText properties cannot be false at same time')),
        assert(
            enableIcon ? icon != null : true,
            throw Exception(
                'An icon should be assigned if enableIcon is true')),
        assert(enableText ? text != null : true,
            throw Exception('A text should be assigned if enableText is true'));

  final GestureTapCallback? onPressed;
  final Color? buttonColor;
  final IconLocation iconLocation;
  final bool enableIcon;
  final IconData? icon;
  final Color? iconColor;
  final bool enableText;
  final String? text;
  final TextStyle? textStyle;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? disabledColor;
  final bool enableButton;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enableButton ? onPressed : null,
      color: buttonColor ?? Theme.of(context).colorScheme.secondary,
      disabledColor: disabledColor != null
          ? disabledColor
          : buttonColor?.withOpacity(0.5) ??
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      padding: padding,
      minWidth: 0,
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: iconLocation == IconLocation.beforeText
              ? TextDirection.ltr
              : TextDirection.rtl,
          children: [
            if (enableIcon) ...[
              Icon(
                icon,
                color: enableButton
                    ? iconColor ?? Theme.of(context).colorScheme.onPrimary
                    : iconColor?.withOpacity(0.5) ??
                        Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.5),
                size: iconSize ?? 22,
              ),
            ],
            if (enableIcon && enableText) ...[
              const VerticalDivider(color: Colors.transparent),
            ],
            if (enableText) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ??
                      Theme.of(context).textTheme.headline6!.copyWith(
                            color: enableButton
                                ? textColor ??
                                    Theme.of(context).colorScheme.onPrimary
                                : textColor?.withOpacity(0.5) ??
                                    Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.5),
                          ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum IconLocation {
  beforeText,
  afterText,
}
