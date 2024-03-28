import 'dart:math';

import 'package:evitalrx_test/controller/auth_controller.dart';
import 'package:evitalrx_test/models/user_model.dart';
import 'package:evitalrx_test/utils/constant.dart';
import 'package:evitalrx_test/views/components/common_button.dart';
import 'package:evitalrx_test/views/components/common_text.dart';
import 'package:evitalrx_test/views/components/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final authCon = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    _loadDummyData();
    authCon.scrollController.addListener(() {
      if (authCon.scrollController.position.pixels == authCon.scrollController.position.maxScrollExtent) {
        _loadDummyData();
      }
    });
  }

  void _loadDummyData() {
    if (authCon.filteredList.isEmpty) {
      if (authCon.dummyDataList2.length >= 20) {
        authCon.dummyDataList2.clear();
      }
      authCon.pageNo.value = 1;
      if (authCon.dummyDataList2.length < 20) {
        authCon.getDataFromDB(20);
      }
    }
  }

  void _loadMoreData() {
    if (authCon.filteredList.isEmpty) {
      if (authCon.pageLoad.value || authCon.dummyDataList2.length >= 43) {
        authCon.pageLoad.value = false;
        authCon.refreshController.refreshCompleted();
        authCon.refreshController.loadNoData();
        authCon.refreshController.resetNoData();
        return;
      }
      // authCon.pageLoad.value = true;
      authCon.refreshController.loadComplete();
      authCon.remainingItems.value = 43 - authCon.dummyDataList2.length;
      authCon.itemsToLoad.value = min(authCon.remainingItems.value, 20);
      // authCon.generateDummyData(authCon.itemsToLoad.value);
      authCon.getDataFromDB(authCon.itemsToLoad.value);
      authCon.pageNo.value++;
      // authCon.pageLoad.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const CommonText(
          text: "Home Screen",
          letterSpacing: 1,
          fontSize: 18,
          color: AppColor.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => SmartRefresher(
            controller: authCon.refreshController,
            enablePullDown: false,
            enablePullUp: !authCon.pageLoad.value,
            onRefresh: () async {
              _loadDummyData();
              authCon.refreshController.refreshCompleted();
            },
            onLoading: _loadMoreData,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          con: authCon.searchCon,
                          fillColor: AppColor.white,
                          borderColor: AppColor.grey,
                          labelText: "Search",
                          keyBoardType: TextInputType.text,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              List<UserModel> data = authCon.dummyDataList2
                                  .where((e) =>
                                      (e.name ?? "").toLowerCase().contains(v.toLowerCase()) ||
                                      (e.city ?? "").toLowerCase().contains(v.toLowerCase()) ||
                                      (e.phoneNumber ?? "").toLowerCase().contains(v.toLowerCase()))
                                  .toList();
                              authCon.filteredList.value = data;
                            } else {
                              authCon.filteredList.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          if (authCon.searchCon.text.isNotEmpty) {
                            List<UserModel> data = authCon.dummyDataList2
                                .where((e) =>
                                    (e.name ?? "").toLowerCase().contains(authCon.searchCon.text.toLowerCase()) ||
                                    (e.city ?? "").toLowerCase().contains(authCon.searchCon.text.toLowerCase()) ||
                                    (e.phoneNumber ?? "").toLowerCase().contains(authCon.searchCon.text.toLowerCase()))
                                .toList();
                            authCon.filteredList.value = data;
                          } else {
                            authCon.filteredList.clear();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.secondaryColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    controller: authCon.scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        authCon.filteredList.isNotEmpty ? authCon.filteredList.length : authCon.dummyDataList2.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, i) => InkWell(
                      onTap: () => Get.defaultDialog(
                        title: "Change Stock",
                        content: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonTextField(
                                con: authCon.stockCon,
                                fillColor: AppColor.white,
                                borderColor: AppColor.grey,
                                labelText: "Enter New Stock Value",
                                keyBoardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(errorText: "Please enter Stock"),
                                    (value) {
                                      if (int.parse(value!) < 1 || int.parse(value) > 100) {
                                        return 'Please enter a number between 1 and 100';
                                      }
                                      return null;
                                    }
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              CommonButton(
                                label: "Submit",
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    if (authCon.filteredList.isNotEmpty) {
                                      authCon.filteredList[i].stock = authCon.stockCon.text;
                                      authCon.filteredList.refresh();
                                    } else {
                                      authCon.dummyDataList2[i].stock = authCon.stockCon.text;
                                      authCon.dummyDataList2.refresh();
                                    }
                                    Get.back();
                                    authCon.stockCon.clear();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(
                              color: AppColor.black.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(authCon.dummyDataList2[i].image ?? ""),
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CommonText(
                                    text:
                                        "${authCon.filteredList.isNotEmpty ? authCon.filteredList[i].name : authCon.dummyDataList2[i].name ?? ""}",
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CommonText(
                                      text: authCon.filteredList.isNotEmpty
                                          ? authCon.filteredList[i].city
                                          : authCon.dummyDataList2[i].city ?? " "),
                                  CommonText(
                                      text: authCon.filteredList.isNotEmpty
                                          ? authCon.filteredList[i].phoneNumber
                                          : authCon.dummyDataList2[i].phoneNumber ?? " "),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                CommonText(
                                    text:
                                        "₹ ${authCon.filteredList.isNotEmpty ? authCon.filteredList[i].stock : authCon.dummyDataList2[i].stock ?? " "}"),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Icon(
                                    int.parse(authCon.filteredList.isNotEmpty
                                                ? authCon.filteredList[i].stock ?? ""
                                                : authCon.dummyDataList2[i].stock ?? "") >
                                            50
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: AppColor.secondaryColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
