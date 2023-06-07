import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/theme.dart';

import 'chat_controller.dart';


class ChatPage extends GetView<ChatController> {
  static const String routeName = '/ChatPage';
  final Widget? leading;
  const ChatPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        body: Text('Trao đổi'));
  }
}