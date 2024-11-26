import 'package:final_exam/modal/bookModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/db_helper.dart';
import '../srvices/firebaseServices/firebse.dart';

class BookController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    iniDetail();
    getDetail();
    super.onInit();
    searchDetail.addListener(searchContacts);
  }

  var bookList = <BookModal>[].obs;
  TextEditingController searchDetail = TextEditingController();

  DatabaseHelper helper = DatabaseHelper();
  FiresBaseServices firesBaseServices = FiresBaseServices();


  Future<RxList> selectData(String category) async {
    bookList.value = (await helper.selectData(category)).cast<BookModal>();
    return bookList;
  }

  void loadContacts({String? query}) async {
    bookList.value = await helper.getData(query: query);
  }

  void searchContacts() {
    String query = searchDetail.text;
    loadContacts(query: query);
  }

  Future<void> iniDetail() async {
    await helper.iniData();
  }

  Future<RxList> getDetail() async {
    bookList.value = await helper.getData();
    return bookList;
  }

  Future<void> insertDetail(BookModal book) async {
    await helper.insertDta(book);
    syncDetail();
    getDetail();
  }

  Future<void> updateDetail(BookModal book) async {
    await helper.updateContact(book);
    getDetail();
  }

  Future<void> deleteDetail(String id) async {
    int id1 = int.parse(id);
    await helper.deleteDetail(id1);
    print('gdgchdwgc============================>');
    getDetail();
  }

  Future<void> syncDetail() async {
    String userId = 'CurrantUser';
    await firesBaseServices.syncData(userId, bookList);
    print('---------------------------->');
  }

  Future<void> getSyncDetail() async {
    String userId = 'CurrantUser';
    final data = await firesBaseServices.getSyncData(userId);

    for (var book in data) {
      await helper.insertDta(book);
    }
    getDetail();
  }
}

class BookControllerData // Book Title, Author, Status (Reading/Completed).
{
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAuthor = TextEditingController();
  RxString txtStatus = ''.obs;
}

TextEditingController txtEmail = TextEditingController();
TextEditingController txtPassword = TextEditingController();
