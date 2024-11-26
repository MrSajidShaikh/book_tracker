import 'package:final_exam/modal/bookModal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/BookController.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerDetail = Get.put(BookControllerData());
    var bookController = Get.put(BookController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await bookController.getSyncDetail();
              },
              icon: Icon(Icons.sync)),
          IconButton(
              onPressed: () async {
                await bookController.syncDetail();
              },
              icon: Icon(Icons.backup_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: bookController.searchDetail,
              decoration: InputDecoration(
                  hintText: 'Search With name',
                  enabledBorder: OutlineInputBorder()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      bookController.selectData('Reading');
                    },
                    child: Text('Reading')),
                OutlinedButton(
                    onPressed: () {
                      bookController.selectData('Completed');
                    },
                    child: Text('Completed')),
                OutlinedButton(
                    onPressed: () {
                      bookController.getDetail();
                    },
                    child: Text('All')),
              ],
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemBuilder: (context, index) {
                  final bookData = bookController.bookList[index];
                  return ListTile(
                    onTap: () {
                      controllerDetail.txtAuthor.clear();
                      controllerDetail.txtStatus = ''.obs;
                      controllerDetail.txtTitle.clear();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Add Data'),
                          actions: [
                            buildTextField(controllerDetail.txtTitle, 'Title'),
                            buildTextField(
                                controllerDetail.txtAuthor, 'Author'),
                            Obx(
                              () => //  (Reading/Completed).
                                  Flexible(
                                child: RadioListTile(
                                  title: Text('Reading'),
                                  // title: Text('Reading'),
                                  value: 'Reading',
                                  groupValue: controllerDetail.txtStatus.value,
                                  onChanged: (value) {
                                    controllerDetail.txtStatus.value = value!;
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => Flexible(
                                child: RadioListTile(
                                  title: Text('Complete'),
                                  value: 'Completed',
                                  groupValue: controllerDetail.txtStatus.value,
                                  onChanged: (value) {
                                    controllerDetail.txtStatus.value = value!;
                                  },
                                ),
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  String id = index.toString();
                                  String title = controllerDetail.txtTitle.text;
                                  String author =
                                      controllerDetail.txtAuthor.text;
                                  String status =
                                      controllerDetail.txtStatus.toString();

                                  final data = BookModal(
                                      id: bookData.id,
                                      Title: title,
                                      Author: author,
                                      Status: status);
                                  bookController.updateDetail(data);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Save'))
                          ],
                        ),
                      );
                    },
                    title: Text(bookData.Title),
                    subtitle: Text(bookData.Status),
                    trailing: IconButton(
                        onPressed: () async {
                          await bookController.deleteDetail(bookData.id!);
                        },
                        icon: Icon(Icons.delete_outline)),
                  );
                },
                itemCount: bookController.bookList.length,
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controllerDetail.txtAuthor.clear();
          controllerDetail.txtStatus = ''.obs;
          controllerDetail.txtTitle.clear();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Data'),
              actions: [
                buildTextField(controllerDetail.txtTitle, 'Title'),
                buildTextField(controllerDetail.txtAuthor, 'Author'),
                Obx(
                  () => //  (Reading/Completed).
                      Flexible(
                    child: RadioListTile(
                      title: Text('Reading'),
                      // title: Text('Reading'),
                      value: 'Reading',
                      groupValue: controllerDetail.txtStatus.value,
                      onChanged: (value) {
                        controllerDetail.txtStatus.value = value!;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Flexible(
                    child: RadioListTile(
                      title: Text('Complete'),
                      value: 'Completed',
                      groupValue: controllerDetail.txtStatus.value,
                      onChanged: (value) {
                        controllerDetail.txtStatus.value = value!;
                      },
                    ),
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      String title = controllerDetail.txtTitle.text;
                      String author = controllerDetail.txtAuthor.text;
                      String status = controllerDetail.txtStatus.toString();

                      final data = BookModal(
                          Title: title, Author: author, Status: status);
                      bookController.insertDetail(data);
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint, enabledBorder: OutlineInputBorder()),
      ),
    );
  }
}
