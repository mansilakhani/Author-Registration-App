import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();

  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();

  //static final
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference authorRef;
  late CollectionReference countersRef;

  //todo: connectWithStudentsCollection

  void connectWithNotessCollection() {
    authorRef = firebaseFirestore.collection("Authors");
  }

  void connectWithCountersCollection() {
    countersRef = firebaseFirestore.collection("count");
  }

  Future<void> insertRecord({required Map<String, dynamic> data}) async {
    connectWithNotessCollection();
    connectWithCountersCollection();

    DocumentSnapshot documentSnapshot =
        await countersRef.doc('author-counter').get();

    Map<String, dynamic> counterData =
        documentSnapshot.data() as Map<String, dynamic>;

    int counter = counterData['count'];

    await authorRef.doc('${++counter}').set(data);

    await countersRef.doc('author-counter').update({'count': counter});
  }

  Stream<QuerySnapshot<Object?>> selectRecord() {
    connectWithNotessCollection();

    return authorRef.snapshots();
  }

  Future<void> updateRecord(
      {required String id, required Map<String, dynamic> updateData}) async {
    connectWithNotessCollection();

    await authorRef.doc(id).update(updateData);
  }

  Future<void> deleteRecord({required String id}) async {
    connectWithNotessCollection();

    await authorRef.doc(id).delete();
  }
}
