import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    this.constraints,
    this.decoration,
    this.onPressed,
    this.padding,
    this.borderRadius,
    this.margin,
    this.width,
    this.height,
    required this.child,
  });

  final BoxConstraints? constraints;
  final Decoration? decoration;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  final Widget child;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      constraints: constraints,
      decoration: decoration,
      margin: margin,
      width: width,
      height: height,
      duration: 300.milliseconds,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
