import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.MyListErrors,
  });

  final List<String?> MyListErrors;

  @override
  Widget build(BuildContext context) {
    // Generates a column of form error texts based on the provided error messages.
    return Column(
      children: List.generate(
        MyListErrors.length, (index) => FormErrorText(error: MyListErrors[index]!),
      ),
    );
  }
}


Row FormErrorText({required String error}) {
  return Row(
    children: [
      SvgPicture.asset(
        "assets/icons/Error.svg",
        height: getProportionateScreenWidth(14),
        width: getProportionateScreenWidth(14),
      ),
      SizedBox(
        width: getProportionateScreenWidth(10),
      ),
      Text(error),
    ],
  );
}

