import 'package:evitalrx_test/utils/constant.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final Color? color;

  const ProgressView({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColor.white,
      ),
    );
  }
}
