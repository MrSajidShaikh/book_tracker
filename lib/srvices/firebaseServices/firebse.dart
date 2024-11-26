import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam/modal/bookModal.dart';

class FiresBaseServices {
  FiresBaseServices._();

  static final FiresBaseServices firesBaseServices = FiresBaseServices._();

  factory FiresBaseServices()=> firesBaseServices;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> syncData(String userId, List<BookModal> book)
  async {
    final batch = fireStore.batch();
    final docRef = fireStore.collection('Users').doc(userId).collection('book');

    for(var data in book)
      {
        final docData = docRef.doc(data.id);
        batch.set(docData, data.toMap());
      }
    await batch.commit();
  }

  Future<Iterable<BookModal>> getSyncData(String userId)
  async {
    final docRef = await fireStore.collection('Users').doc(userId).collection('book').get();

    return docRef.docs.map((e) {
      final book = BookModal.fromMap(e.data());
      book.id = e.id;
      return book;
    },);
  }
}
