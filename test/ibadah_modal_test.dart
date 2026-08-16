import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:alquran_new/development/ibadah/ibadah_screen.dart';

class _FakePathProvider extends PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() async {
    return Directory.systemTemp.createTempSync('gs_test_').path;
  }
}

void main() {
  setUpAll(() async {
    PathProviderPlatform.instance = _FakePathProvider();
    await GetStorage.init('GetStorage');
  });

  testWidgets('Modal sholat wajib: pilih Berjamaah lalu ganti ke Sendiri',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IbadahScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Subuh'));
    await tester.pumpAndSettle();

    expect(find.text('Berjamaah'), findsOneWidget,
        reason: 'Tombol Berjamaah muncul di modal');
    expect(find.text('Sendiri'), findsOneWidget,
        reason: 'Tombol Sendiri muncul di modal');

    await tester.tap(find.text('Berjamaah'));
    await tester.pumpAndSettle();

    expect(find.text('Sendiri'), findsNothing,
        reason: 'Modal tertutup setelah memilih Berjamaah');
    expect(find.text('Berjamaah'), findsOneWidget,
        reason: 'Subuh tertandai Berjamaah setelah diklik');

    await tester.tap(find.text('Subuh'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sendiri'));
    await tester.pumpAndSettle();

    expect(find.text('Berjamaah'), findsNothing,
        reason: 'Modal tertutup setelah memilih Sendiri');
    expect(find.text('Sendiri'), findsOneWidget,
        reason: 'Mode berhasil diubah ke Sendiri');
  });
}
