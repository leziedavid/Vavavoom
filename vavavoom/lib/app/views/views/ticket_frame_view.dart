import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketFrameView extends GetView {
  const TicketFrameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicketFrameView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('TicketFrameView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
