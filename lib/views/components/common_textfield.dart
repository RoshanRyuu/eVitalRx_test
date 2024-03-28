import 'package:evitalrx_test/views/components/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? headerLabel;
  final EdgeInsetsGeometry? contentPadding;
  final Color? hintTextColor;
  final FontWeight? hintTextFontWeight;
  final double? hintTextFontSize;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? keyBoardType;
  final TextEditingController? con;
  final bool? readOnly;
  final void Function()? onTap;
  void Function(String)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;

  CommonTextField({
    Key? key,
    this.hintText,
    this.headerLabel,
    this.contentPadding,
    this.hintTextColor,
    this.hintTextFontWeight,
    this.hintTextFontSize,
    this.fillColor,
    this.borderColor,
    this.keyBoardType,
    this.onChanged,
    this.con,
    this.validator,
    this.readOnly,
    this.onTap,
    this.prefix,
    this.suffix,
    this.labelText,
    this.inputFormatters,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerLabel != null
            ? CommonText(
                text: headerLabel,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
            : const SizedBox(),
        headerLabel != null ? const SizedBox(height: 10) : const SizedBox(),
        TextFormField(
          maxLines: maxLine ?? 1,
          controller: con,
          keyboardType: keyBoardType,
          validator: validator,
          readOnly: readOnly ?? false,
          onTap: onTap,
          onChanged: onChanged,
          enabled: true,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            contentPadding: contentPadding,
            prefixIcon: prefix,
            suffixIcon: suffix,
            labelText: labelText ?? "",
            hintStyle: TextStyle(
              color: hintTextColor ?? Colors.grey,
              fontWeight: hintTextFontWeight ?? FontWeight.w700,
              fontSize: hintTextFontSize ?? 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
