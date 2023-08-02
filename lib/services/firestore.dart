import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinder/models/app_user_state.dart';
import '../shared/ApiPath.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirestoreService._();
  static final FirestoreService _service = FirestoreService._();
  factory FirestoreService() => _service;

  static FirestoreService get instance => _service;

  Stream<List<AppUser>> getAllUsers() {
    final String path = ApiPath.allUsers;
    final CollectionReference collection = _firebaseFirestore.collection(path);

    return collection.snapshots().map(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map(
          (QueryDocumentSnapshot snapshot) {
            final data = snapshot.data()! as Map<String, dynamic>;
            print('data');
            print(data);
            data['id'] = snapshot.id;
            data['isLoggedIn'] = false;

            return AppUser.fromJson(data);
          },
        ).toList();
      },
    );
  }

  Stream<AppUser?> getUser(String id) {
    final String path = ApiPath.userById(id);
    final Stream<DocumentSnapshot> snapshots =
        _firebaseFirestore.doc(path).snapshots();

    return snapshots.map((DocumentSnapshot snapshot) {
      final data = snapshot.data();
      if (data != null && id == snapshot.id) {
        print("FAITH *** $data");
        final formattedData = data as Map<String, dynamic>;
        formattedData['id'] = id;
        formattedData['isLoggedIn'] = true;
        return AppUser.fromJson(data);
      } else {
        print("The user was either null or $id didnt match ${snapshot.id}");
      }
    });
  }

  Future<void> updateUserFriends(String id, List<String> friends) async {
    try {
      final String path = ApiPath.userById(id);
      final DocumentReference document = _firebaseFirestore.doc(path);

      await document.set(
        {'friends': friends},
        SetOptions(merge: true),
      );
    } catch (e) {
      print('User update friends failed $e');
    }
  }

  Future<void> createUser(String id, AppUser user) async {
    final String path = ApiPath.allUsers;
    try {
      final CollectionReference collection =
          _firebaseFirestore.collection(path);

      Map dataUser = user.toJson();
      dataUser.remove('id');
      dataUser.remove('isLoggedIn');

      await collection.doc(id).set(dataUser);
    } catch (e) {
      print("PATH ERROR $e");
    }
  }
}
