import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:norq_technologies/screens/sign_in_screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  FlutterSecureStorage secureStorage = FlutterSecureStorage(
    aOptions: getAndroidOptions(),
  );
  final encryptionKey = await secureStorage.read(key: 'hiveStorage');
  if (encryptionKey != null) {
    final userKey = base64Url.decode(encryptionKey);
    await Hive.openBox(
      'hiveStorage',
      encryptionCipher: HiveAesCipher(userKey),
    );
  } else {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'hiveStorage',
      value: base64UrlEncode(key),
    );
    final encryptionKey = await secureStorage.read(key: 'hiveStorage');
    final userKey = base64Url.decode(encryptionKey!);
    await Hive.openBox(
      'hiveStorage',
      encryptionCipher: HiveAesCipher(userKey),
    );
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
