import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TermsOfServicesPage extends StatelessWidget {
  static const String PageId = 'TermsOfServicesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Terms of Services',
              style: TextStyle(fontSize: 14.sp, color: Colors.black)),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Text(
              """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

    """),
        ));
  }
}
