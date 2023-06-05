import 'package:flutter/material.dart';

import '../../../core/initialize/theme.dart';

class AppbarCustomize {
  static PreferredSizeWidget buildAppbar(
      {Key? key,
        required BuildContext context,
        required String title,
        List<Widget>? actionRights,
        List<Widget>? actionLefts,
        Widget? child,
        double? heightAppbar,
        Color? color,
        bool isUseOnlyBack = true}) {
    final AppBar appBar = AppBar();
    final double _heightAppbar = heightAppbar ?? appBar.preferredSize.height;
    final double systemBarHeight = MediaQuery.of(context).padding.top;
    final double leadingWidth = appBar.leadingWidth ?? 60.0;
    List<Widget> _actionLefts = (actionLefts != null)
        ? actionLefts
        : [
      const SizedBox(
        width: 20.0,
      )
    ];

    List<Widget> _actionRights = (actionRights != null)
        ? actionRights
        : [
      const SizedBox(
        width: 20.0,
      )
    ];

    return PreferredSize(
      preferredSize: Size.fromHeight(_heightAppbar),
      child: Card(
        margin: const EdgeInsets.all(0.0),
        shadowColor: Colors.black,
        elevation: 2.0,
        child: Container(
          decoration:
          BoxDecoration(
            gradient: kDefaultGradient
          ),
          child: Column(
            children: [
              SizedBox(height: systemBarHeight),
              Container(
                height: _heightAppbar,
                child: (child != null)
                    ? child
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: leadingWidth,
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: !isUseOnlyBack
                            ? _actionLefts
                            : <Widget>[
                          IconButton(
                              onPressed: () =>
                                  Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ))
                        ].toList(),
                      ),
                    ),
                    Expanded(
                      child: Text(title,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                              color: kTextFieldLightColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        //width: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: _actionRights,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
