import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:signalr_netcore/signalr_client.dart';

class Signalr {
  static late HubConnection hubConnection;

  static Future<void> initSignalR() async {
    String serverUrl = CoreUrl.baseSignalrUrl;
    var httpOptions = HttpConnectionOptions(
        accessTokenFactory: () async => await tokenFactory());
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .withAutomaticReconnect()
        .build();

    await hubConnection.start()?.catchError((value) => print(value));

    hubConnection.on("newNotify", (arguments) async {
      // var noti =
      //     NotificationSwagger.fromJson(arguments![0] as Map<Object, dynamic>);
      print(arguments);
    });
  }

  static Future<String> tokenFactory() async {
    return AppSettings.getValue(KeyAppSetting.token);
  }
}
