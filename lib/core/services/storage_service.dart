import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:worktracker/core/utils/logger.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService({required FirebaseStorage storage}) : _storage = storage;

  Future<String> uploadFile({
    required String path,
    required File file,
  }) async {
    try {
      AppLogger.info('[STORAGE][UPLOAD] Uploading to: $path');
      final ref = _storage.ref().child(path);
      final task = await ref.putFile(file);
      final url = await task.ref.getDownloadURL();
      AppLogger.info('[STORAGE][UPLOAD] Success: $url');
      return url;
    } catch (e, stack) {
      AppLogger.error('[STORAGE][UPLOAD] Failed at $path', e, stack);
      rethrow;
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      AppLogger.info('[STORAGE][DELETE] Deleting: $path');
      await _storage.ref().child(path).delete();
      AppLogger.info('[STORAGE][DELETE] Success');
    } catch (e, stack) {
      AppLogger.error('[STORAGE][DELETE] Error at $path', e, stack);
      rethrow;
    }
  }

  Future<String> getDownloadUrl(String path) async {
    try {
      AppLogger.info('[STORAGE][GET_URL] Path: $path');
      final url = await _storage.ref().child(path).getDownloadURL();
      AppLogger.info('[STORAGE][GET_URL] Success: $url');
      return url;
    } catch (e, stack) {
      AppLogger.error('[STORAGE][GET_URL] Error at $path', e, stack);
      rethrow;
    }
  }
}
