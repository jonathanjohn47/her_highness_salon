/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:her_highness_salon/Pages/ChatPage.dart';

class MessagePage extends StatelessWidget {
  static const String PageId = 'MessagePage';

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ChatPage();
  }


}
