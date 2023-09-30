/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;
import 'package:her_highness_salon/helpers/date_time_helpers.dart';
import 'package:her_highness_salon/models/chat_message_model.dart';
import 'package:sizer/sizer.dart';

import '../get_controllers/chat_page_get_controller.dart';

class ChatPage extends StatelessWidget {
  static const String PageId = 'ChatPage';

  ChatPageGetController chatPageGetController =
      Get.put(ChatPageGetController());

  late BuildContext context;
  List<Item> messages = <Item>[
    Item('left', 'Hey there! What\'s up>?'),
    Item(
        'right', 'Nothing. Just chilling and watching youtube What about you?'),
    Item('left', 'Same here! Been watching youtube for last 5 hours'),
    Item('right', 'Yeah i know. I am in same position'),
    Item('left', 'It\'s hard to be productive man '),
    Item('right', 'Sure thankyou'),
  ];

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildFooter(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent, // <-- APPBAR WITH TRANSPARENT BG
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/p3.jpg'),
                radius: 20,
              ),
            ),
            Text(
              'Rahul Jograna',
              style: TextStyle(
                fontFamily: 'bold',
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              chatPageGetController.allMessages.map((ChatMessageModel msg) {
            return msg.sentByAdmin
                ? Container(
                    margin: EdgeInsets.only(bottom: 16),
                    width: MediaQuery.of(context).size.width - 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/WhatsApp Image 2023-09-21 at 4.11.42 PM.jpeg'),
                          radius: 20,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              msg.imageLink.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFA4E3FF),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          )),
                                      child: Image.network(
                                        msg.imageLink,
                                        height: 30.w,
                                        width: 30.w,
                                      ),
                                    )
                                  : SizedBox(),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFA4E3FF),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    )),
                                child: Text(
                                  msg.text,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8, left: 8),
                                child: Text(
                                  msg.sentAt.getHowMuchTimeAgo(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            width: MediaQuery.of(context).size.width - 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Column(
                                    children: [
                                      msg.imageLink.isNotEmpty
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors
                                                      .orangeAccent.shade100,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  )),
                                              child: Image.network(
                                                msg.imageLink,
                                                height: 30.w,
                                                width: 30.w,
                                              ),
                                            )
                                          : SizedBox(),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent.shade100,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(5),
                                            )),
                                        child: Text(
                                          msg.text,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Text(
                          msg.sentAt.getHowMuchTimeAgo(),
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      )
                    ],
                  );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildFooter() {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.grey.shade100,
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                chatPageGetController.getImage();
              },
              child: Container(
                height: 35,
                width: 35,
                child: Icon(
                  Icons.attach_file,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextField(
                controller: chatPageGetController.messageController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Write a message...'),
              ),
            ),
            InkWell(
              onTap: () {
                chatPageGetController.sendMessage();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    )),
                child: Icon(
                  Icons.send,
                  color: style.appColor,
                ),
              ),
            ),
          ],
        ),
      ),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    );
  }
}

class Item {
  const Item(this.side, this.msg);

  final String side;
  final String msg;
}
