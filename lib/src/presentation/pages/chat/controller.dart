import 'package:i_trade/common/apis/chat.dart';
import 'package:i_trade/common/apis/message.dart';
import 'package:i_trade/common/utils/signalr.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/entities/msg_content.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'dart:io';

import 'state.dart';

class ChatController extends GetxController {
  ChatController();
  final state = ChatState();
  late String trading_id;
  final myInputController = TextEditingController();
  final token = AppSettings.getValue(KeyAppSetting.userId);

  var listener;
  var pageIndex = 1;
  var totalPage;
  var isLoadmore = true;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  ScrollController myScrollController = ScrollController();

  void goMore() {
    state.more_status.value = state.more_status.value ? false : true;
  }

  Future<bool> requestPermission(Permission permission) async {
    var permissionStatus = await permission.status;
    if (permissionStatus != PermissionStatus.granted) {
      var status = await permission.request();
      if (status != PermissionStatus.granted) {
        //toast("Please enable permission have video call");
        if (GetPlatform.isAndroid) {
          await openAppSettings();
        }
        return false;
      }
    }
    return true;
  }

  static Future<String> tokenFactory() async {
    return AppSettings.getValue(KeyAppSetting.token);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.parameters;
    print(data);
    trading_id = data['trading_id']!;
    // state.to_token.value = data["to_token"] ?? "";
    // state.to_name.value = data["to_name"] ?? "";
    state.to_avatar.value = data["to_avatar"] ?? "";
    // state.to_online.value = data["to_online"] ?? "1";
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();

    state.msgcontentList.clear();
    await Signalr.initSignalR();
    var messages = await MessageAPI.get_trading_sent(
        MessageQuery(TradingId: trading_id, PageIndex: 1, PageSize: 8));

    messages.data?.forEach((element) {
      state.msgcontentList.add(element);
    });
    totalPage = messages.totalPage;

    //signalR
    String serverUrl = CoreUrl.baseSignalrUrl;
    var httpOptions = HttpConnectionOptions(
        accessTokenFactory: () async => await tokenFactory());
    var hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .withAutomaticReconnect()
        .build();

    await hubConnection.start()?.catchError((value) => print(value));
    hubConnection.on("MessageAdded", (arguments) async {
      var message = Msgcontent.fromJson(arguments![0] as Map<String, dynamic>);
      if (message.tradingUserChat?.trading?.id == trading_id) {
        state.msgcontentList.insert(0, message);

        state.msgcontentList.refresh();

        if (myScrollController.hasClients) {
          myScrollController.animateTo(
              myScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      }
    });

    myScrollController.addListener(() {
      if (myScrollController.position.pixels ==
          myScrollController.position.maxScrollExtent) {
        if (pageIndex < totalPage) {
          state.isLoading.value = true;
          pageIndex = pageIndex + 1;
          asyncLoadMoreData();
        }
      }
    });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print("No image selected");
    }
  }

  Future uploadFile() async {
    await ChatAPI.upload_img(file: _photo, tradingId: trading_id);
  }

  Future<void> asyncLoadMoreData() async {
    var messages = await MessageAPI.get_trading_sent(MessageQuery(
        TradingId: trading_id, PageIndex: pageIndex, PageSize: 10));
    messages.data?.forEach((element) {
      state.msgcontentList.add(element);
    });
    state.isLoading.value = false;
  }

  void sendMessage() async {
    String sendContent = myInputController.text;
    // print("...${sendContent}...");
    if (sendContent.isEmpty) {
      print("content is empty");
      return;
    }

    final content = MessageRequestEntity(
      tradingId: trading_id,
      content: sendContent,
    );

    await MessageAPI.send_message(content)
        .then((value) => {myInputController.clear()});
  }

  void closeAllPop() {
    Get.focusScope?.unfocus();
    state.more_status.value = false;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // listener.cancel();
    myInputController.dispose();
    myScrollController.dispose();
  }
}
