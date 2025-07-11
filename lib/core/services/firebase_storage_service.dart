import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:worktracker/core/utils/logging/logger.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService({required FirebaseStorage storage})
      : _storage = storage;

  Future<String> uploadFile({
    required String path,
    required File file,
  }) async {
    try {
      AppLogger.info('[FIREBASE STORAGE][UPLOAD] Uploading to: $path');
      final ref = _storage.ref().child(path);
      final task = await ref.putFile(file);
      final url = await task.ref.getDownloadURL();
      AppLogger.info('[FIREBASE STORAGE][UPLOAD] Success: $url');
      return url;
    } catch (e, stack) {
      AppLogger.error('[FIREBASE STORAGE][UPLOAD] Failed at $path', e, stack);
      rethrow;
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      AppLogger.info('[FIREBASE STORAGE][DELETE] Deleting: $path');
      await _storage.ref().child(path).delete();
      AppLogger.info('[FIREBASE STORAGE][DELETE] Success');
    } catch (e, stack) {
      AppLogger.error('[FIREBASE STORAGE][DELETE] Error at $path', e, stack);
      rethrow;
    }
  }

  Future<String> getDownloadUrl(String path) async {
    try {
      AppLogger.info('[FIREBASE STORAGE][GET_URL] Path: $path');
      final url = await _storage.ref().child(path).getDownloadURL();
      AppLogger.info('[FIREBASE STORAGE][GET_URL] Success: $url');
      return url;
    } catch (e, stack) {
      AppLogger.error('[FIREBASE STORAGE][GET_URL] Error at $path', e, stack);
      rethrow;
    }
  }
}
