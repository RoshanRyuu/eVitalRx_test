import 'dart:math';

import 'package:evitalrx_test/models/user_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AuthController extends GetxController {
  final String? mobileValid = "9033006262";
  final String? passValid = "eVital@12";

  TextEditingController mobileNumberCon = TextEditingController();
  TextEditingController passcodeCon = TextEditingController();
  // Home Page

  RxInt pageNo = 0.obs;
  RxInt remainingItems = 0.obs;
  RxInt itemsToLoad = 0.obs;
  RxBool pageLoad = true.obs;
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  RxList<UserModel> filteredList = <UserModel>[].obs;
  RxList<UserModel> dummyDataList2 = <UserModel>[].obs;
  RxList<UserModel> dummyDataList = <UserModel>[].obs;
  TextEditingController stockCon = TextEditingController();
  TextEditingController searchCon = TextEditingController();

  String generateRandomIndianPhoneNumber() {
    String countryCode = '+91';
    String phoneNumber = '';
    for (int i = 0; i < 10; i++) {
      phoneNumber += Random().nextInt(10).toString();
    }
    return countryCode + phoneNumber;
  }

  generateDummyData(int value) {
    for (int i = 0; i < value; i++) {
      String name = faker.person.name();
      String phoneNumber = generateRandomIndianPhoneNumber();
      String city = faker.address.streetAddress();
      String image = 'https://picsum.photos/200/300?random=$i';
      String stock = '${Random().nextInt(100)}';
      dummyDataList.add(UserModel(
        name: name,
        phoneNumber: phoneNumber,
        city: city,
        image: image,
        stock: stock,
      ));
    }
    return dummyDataList;
  }

  getDataFromDB(int value) async {
    pageLoad.value = true;
    var box = await Hive.openBox('userList');
    await box.put("userList", generateDummyData(value));
    dummyDataList2.value = box.get('userList') ?? [];
    pageLoad.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    mobileNumberCon.dispose();
    passcodeCon.dispose();
    stockCon.dispose();
    searchCon.dispose();
  }
}
