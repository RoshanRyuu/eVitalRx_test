import 'package:evitalrx_test/utils/constant.dart';
import 'package:evitalrx_test/utils/indicator.dart';
import 'package:evitalrx_test/views/components/common_text.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? label;
  final Color? buttonColor;
  final double? height;
  final void Function()? onPressed;
  final double? labelSize;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final double? buttonRadius;
  final String? labelLogo;
  final Color? buttonBorderColor;
  final bool? load;
  final bool? gradient;
  final double? width;
  final Color? buttonColorGrade;

  const CommonButton(
      {Key? key,
      this.label,
      this.buttonColor,
      this.height,
      this.width,
      this.onPressed,
      this.labelSize,
      this.labelColor,
      this.labelWeight,
      this.buttonRadius,
      this.labelLogo,
      this.buttonBorderColor,
      this.load,
      this.gradient,
      this.buttonColorGrade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColor.primaryColor,
          borderRadius: BorderRadius.circular(buttonRadius ?? 50),
          border: Border.all(color: buttonBorderColor ?? AppColor.transparent),
        ),
        height: height ?? 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            load ?? false
                ? const ProgressView()
                : Flexible(
                    child: CommonText(
                      text: label ?? "",
                      fontSize: labelSize,
                      color: labelColor ?? AppColor.white,
                      fontWeight: labelWeight ?? FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
