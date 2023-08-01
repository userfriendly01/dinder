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
        return querySnapshot.docs.map((
          QueryDocumentSnapshot snapshot
        ) {
          final data = snapshot.data()! as Map<String, dynamic>;
          print('data');
          print(data);
          data['id'] = snapshot.id;

          return AppUser.fromJson(data);
        },
        ).toList();
      },
    );
  }

  Stream<AppUser> getUser(String id) {
    final String path = ApiPath.userById(id);
    final Stream<DocumentSnapshot> snapshots = _firebaseFirestore.doc(path).snapshots();

    return snapshots.map(
      (DocumentSnapshot snapshot) {
        final data = snapshot.data()!  as Map<String, dynamic>;
          data['id'] = snapshot.id;

          return AppUser.fromJson(data);

      }
    );
  }


  Future<void> updateUserFriends(String id, List<String> friends) async {
    try {
      final String path = ApiPath.userById(id);
      final DocumentReference document = _firebaseFirestore.doc(path);

      await document.set(
        {
          'friends': friends
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('User update friends failed $e');
    }
  }

  Future<void> createUser(String id, AppUser user) async {
    final String path = ApiPath.userById(id);
    final CollectionReference collection = _firebaseFirestore.collection(path);

    await collection.add(user.toJson());
  }
  
}

