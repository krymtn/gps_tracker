import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = './test/applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

void main() {

  const testMockStorage = './test/applicationDocumentsPath';

  group('PathProvider full implementation', () {
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      DartPluginRegistrant.ensureInitialized();
      const channel = MethodChannel(
        'plugins.flutter.io/path_provider',
      );
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return testMockStorage;
      });
    });
    test('getApplicationDocumentsDirectory', () async {
      final Directory result = await getApplicationDocumentsDirectory();
      expect(result.path, kApplicationDocumentsPath);
    });

    test('create file', () async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/text_file2.txt');
      await file.create();

      bool fileIsExist = await file.exists();
      expect(fileIsExist, true);
    });

    test('file is exist', () async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/text_file2.txt');
      bool fileIsExist = await file.exists();
      expect(fileIsExist, true);
    });

    test("create folder", () async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final Directory newDoc =  Directory('${directory.path}/gpsMonitor/');
      await newDoc.create();
      bool docIsExist = await newDoc.exists();
      expect(docIsExist, true);
    });
  });
}


class FakePathProviderPlatform extends Fake with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}