import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worktracker/core/utils/logging/logger.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> collection(String path) {
    AppLogger.debug('[FIREBASE FIRESTORE] Accessing Collection: $path');
    return _firestore.collection(path);
  }

  DocumentReference<Map<String, dynamic>> doc(String path) {
    AppLogger.debug('[FIREBASE FIRESTORE] Accessing Document: $path');
    return _firestore.doc(path);
  }

  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    try {
      AppLogger.info('[FIREBASE FIRESTORE] [SET] $path => $data');
      await _firestore.doc(path).set(data, SetOptions(merge: merge));
      AppLogger.info('[FIREBASE FIRESTORE] [SET] Success: $path');
    } catch (e, stack) {
      AppLogger.error('[FIREBASE FIRESTORE] [SET] Error at $path', e, stack);
      rethrow;
    }
  }

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      AppLogger.info('[FIREBASE FIRESTORE][UPDATE] $path => $data');
      await _firestore.doc(path).update(data);
      AppLogger.info('[FIREBASE FIRESTORE][UPDATE] Success: $path');
    } catch (e, stack) {
      AppLogger.error('[FIREBASE FIRESTORE][UPDATE] Error at $path', e, stack);
      rethrow;
    }
  }

  Future<void> deleteDocument(String path) async {
    try {
      AppLogger.info('[FIREBASE FIRESTORE][DELETE] $path');
      await _firestore.doc(path).delete();
      AppLogger.info('[FIREBASE FIRESTORE][DELETE] Success: $path');
    } catch (e, stack) {
      AppLogger.error('[FIREBASE FIRESTORE][DELETE] Error at $path', e, stack);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getDocument(String path) async {
    try {
      AppLogger.info('[FIREBASE FIRESTORE][GET] $path');
      final snapshot = await _firestore.doc(path).get();
      final data = snapshot.data();
      AppLogger.info('[FIREBASE FIRESTORE][GET] Success: $data');
      return data;
    } catch (e, stack) {
      AppLogger.error('[FIREBASE FIRESTORE][GET] Error at $path', e, stack);
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDocument(String path) {
    AppLogger.debug('[FIREBASE FIRESTORE][STREAM] $path');
    return _firestore.doc(path).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection(String path) {
    AppLogger.debug('[FIREBASE FIRESTORE][STREAM] collection: $path');
    return _firestore.collection(path).snapshots();
  }
}
