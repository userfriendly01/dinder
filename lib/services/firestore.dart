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
      (QueryDocumentSnapshot querySnapshot) {
        return querySnapshot.docs.map((
          QueryDocumentSnapshot snapshot
        ) {
          final Map<String, dynamic> data = snapshot.data()!;

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
        final Map<String, dynamic> data = snapshot.data()!;
          data['id'] = snapshot.id;

          return AppUser.fromJson(data);

      }
    );
  }

  
}

