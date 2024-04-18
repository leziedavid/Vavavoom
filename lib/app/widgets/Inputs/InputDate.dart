import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../constant/Color.dart';

class InputCustomDate extends StatelessWidget {
  const InputCustomDate({
    Key? key,
    required this.controller,
    required this.text,
    required this.icon,
    this.callback,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final IconData icon;
  final Callback? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 45.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(
                color: controller.value.text.isEmpty
                  ? const Color.fromARGB(255, 202, 202, 202)
                  : CustomColor.darck,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: CustomColor.darck,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 1,
                      color: controller.text.isEmpty
                          ? const Color.fromARGB(255, 202, 202, 202)
                          : CustomColor.darck,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: callback,
                    child: TextField(
                      enabled: false,
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: text,
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down_sharp,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
