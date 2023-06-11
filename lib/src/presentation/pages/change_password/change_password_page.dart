import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/theme.dart';
import 'package:i_trade/src/presentation/pages/change_password/chang_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  static const String routeName = '/ChangePasswordPage';
  final Widget? leading;
  const ChangePasswordPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundBottomBar,
        body: Stack(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      _buildInput(context: context, title: 'Nhập mật khẩu hiện tại', iconData: Icons.lock),
                      _buildInput(context: context, title: 'Nhập mật khẩu mới', iconData: Icons.lock),
                      _buildInput(context: context, title: 'Nhập lại mật khẩu mới', iconData: Icons.lock),
                      const SizedBox(height: 50.0),
                      _buildButton(context)
                    ],
                  ),
                ),

              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.5 - 70.0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70.0),
                  color: kBackgroundBottomBar,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.25), spreadRadius: 2, offset: const Offset(0, 4))],
                  ),
                  child: const CircleAvatar(
                    radius: 60.0,
                    backgroundImage:
                    NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDK4gXyt3wzCyT9ekbDsR-thEKFtWuQoFraQ&usqp=CAU'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            )
          ],
     ));
  }

  Widget _buildHeader(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.17,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: const BoxDecoration(
          gradient: kDefaultGradient
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25.0,
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Cập nhật mật khẩu',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kTextColor),
            ),
          ),
          const SizedBox(width: 50.0,)
        ],
      ),
    );
  }

  Widget _buildInput({required BuildContext context, required String title, required IconData iconData}){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: kBackground,
                  width: 2.0
              )
          )
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: kDefaultGradient
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          Expanded(
            child: TextFormField(
              //initialValue: number.toString(),
              //controller: blocQLDTTNMT.keySearchTextEditingController,
              decoration: InputDecoration(
                  suffixIcon: null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  disabledBorder: InputBorder.none,
                  hintText: '$title...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kTextColorGrey)),
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(13.0),
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: kDefaultGradient
          ),
          child: Text(
            'Cập nhật mật khẩu',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }


}