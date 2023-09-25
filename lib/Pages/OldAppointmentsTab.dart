import 'package:flutter/material.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;

class OldAppointmentsTab extends StatelessWidget {
  const OldAppointmentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildColumnFirst()),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'December 26,2021',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'bold',
                                color: style.appColor),
                          ),
                          Text(
                            '01:30 - 02:30 PM',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'bold',
                                color: style.appColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 10,
    ));
  }

  Widget _buildColumnFirst() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Men\' Haircuts + Beard',
            style: TextStyle(fontSize: 17, fontFamily: 'bold'),
          ),
        ],
      ),
    );
  }
}
