import 'dart:io';

String readJson(String name) => File('test/offline_data/$name').readAsStringSync();
