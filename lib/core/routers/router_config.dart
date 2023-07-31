import 'package:core_http/core_http.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/services/home_service.dart';
import 'package:i_trade/src/domain/services/login_service.dart';
import 'package:i_trade/src/domain/services/upload_product_service.dart';
import 'package:i_trade/src/infrastructure/repositories/home_repository.dart';
import 'package:i_trade/src/infrastructure/repositories/login_repository.dart';
import 'package:i_trade/src/infrastructure/repositories/upload_product_repository.dart';
import 'package:i_trade/src/presentation/pages/chat/binding.dart';
import 'package:i_trade/src/presentation/pages/chat/controller.dart';
import 'package:i_trade/src/presentation/pages/chat/chat_page.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/edit_profile_controller.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/widgets/edit_password_page.dart';
import 'package:i_trade/src/presentation/pages/home/home_controller.dart';
import 'package:i_trade/src/presentation/pages/home/home_page.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_detail.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_list.dart';
import 'package:i_trade/src/presentation/pages/information/information_controller.dart';
import 'package:i_trade/src/presentation/pages/information/information_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/bao_cao_vi_pham_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/iTrade_policy_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_feedback_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_profile_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/vi_cua_toi_page.dart';
import 'package:i_trade/src/presentation/pages/login/login_page.dart';
import 'package:i_trade/src/presentation/pages/login/widget/register_page.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_page.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_trade_page.dart';
import 'package:i_trade/src/presentation/pages/search/search_controller.dart';
import 'package:i_trade/src/presentation/pages/search/search_page.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_controller.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_page.dart';

import '../../src/domain/services/manage_service.dart';
import '../../src/infrastructure/repositories/manage_repository.dart';
import '../../src/presentation/pages/dashboard/dashboard_page.dart';
import '../../src/presentation/pages/login/widget/forget_password_page.dart';
import '../../src/presentation/pages/manage/widgets/trade_product_page.dart';
import '../../src/presentation/pages/login/login_controller.dart';
import '../../src/presentation/pages/manage/widgets/manage_history_page.dart';

class ITradeRouterConfigs {
  static final List<GetPage> routes = [
    GetPage(
      name: DashboardPage.routeName,
      page: () => const DashboardPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => DashboardController());
        },
      ),
    ),
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: BindingsBuilder(
            () {
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<HomeService>(HomeRepositories());
          Get.lazyPut(() => HomeController());
        },
      ),
    ),
    GetPage(
      name: ManagePage.routeName,
      page: () => const ManagePage(),
      binding: BindingsBuilder(
            () {
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<ManageService>(ManageRepositories());
          Get.lazyPut(() => ManageController());
        },
      ),
    ),
    GetPage(
      name: ManageTradePage.routeName,
      page: () => const ManageTradePage(),
      binding: BindingsBuilder(
            () {
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<ManageService>(ManageRepositories());
          Get.lazyPut(() => ManageController());
        },
      ),
    ),
    GetPage(
      name: ManageHistoryPage.routeName,
      page: () => const ManageHistoryPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<ManageService>(ManageRepositories());
          Get.lazyPut(() => ManageController());
        },
      ),
    ),
    GetPage(
      name: SearchPage.routeName,
      page: () => const SearchPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => SearchControllerCustom());
        },
      ),
    ),
    GetPage(
      name: ChatPage.routeName,
      page: () => const ChatPage(),
      binding: ChatBinding()
    ),
    GetPage(
      name: InformationPage.routeName,
      page: () => const InformationPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
    GetPage(
      name: LoginPage.routeName,
      page: () => const LoginPage(),
      binding: BindingsBuilder(
            () {
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<LoginService>(LoginRepositories());
          Get.lazyPut(() => LoginController());
        },
      ),
    ),
    GetPage(
      name: RegisterPage.routeName,
      page: () => const RegisterPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => LoginController());
        },
      ),
    ),
    GetPage(
      name: ForgetPasswordPage.routeName,
      page: () => const ForgetPasswordPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => LoginController());
        },
      ),
    ),
    GetPage(
      name: EditProfilePage.routeName,
      page: () => const EditProfilePage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<LoginService>(LoginRepositories());
          Get.lazyPut(() => EditProfileController());
        },
      ),
    ),
    GetPage(
      name: EditPasswordPage.routeName,
      page: () => const EditPasswordPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<LoginService>(LoginRepositories());
          Get.lazyPut(() => EditProfileController());
        },
      ),
    ),
    GetPage(
      name: UploadPostPage.routeName,
      page: () => const UploadPostPage(),
      binding: BindingsBuilder(
            () {
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<UploadProductService>(UploadProdcutRepositories());
          Get.lazyPut(() => UploadPostController());
        },
      ),
    ),
    GetPage(
      name: ProductListPage.routeName,
      page: () => const ProductListPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          //Get.lazyPut(() => HomeController());
        },
      ),
    ),
    GetPage(
      name: ProductDetailPage.routeName,
      page: () => const ProductDetailPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => HomeController());
        },
      ),
    ),
    GetPage(
      name: TradeProductPage.routeName,
      page: () => const TradeProductPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
          Get.put<ManageService>(ManageRepositories());
          Get.lazyPut(() => ManageController());
        },
      ),
    ),

    GetPage(
      name: ITradePolicyPage.routeName,
      page: () => const ITradePolicyPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
    GetPage(
      name: BaoCaoViPhamPage.routeName,
      page: () => const BaoCaoViPhamPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
    GetPage(
      name: ViCuaToiPage.routeName,
      page: () => const ViCuaToiPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
    GetPage(
      name: MyFeedbackPage.routeName,
      page: () => const MyFeedbackPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
    GetPage(
      name: MyProfilePage.routeName,
      page: () => const MyProfilePage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
  ];
}
