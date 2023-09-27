import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpGetController extends GetxController{
  //full name, email, password, dateOfBirth, address

  Rx<DateTime> date = DateTime.now().obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString imagePath = ''.obs;



}