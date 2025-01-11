import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubesppbm/main.dart';

void main() {
  testWidgets('Youtube Player widget test', (WidgetTester tester) async {
    // Render aplikasi
    await tester.pumpWidget(MyApp());

    // Verifikasi bahwa widget YoutubePlayer ada
    expect(find.byKey(Key('youtube_player')), findsOneWidget);
  });

  testWidgets('Chat input and send button test', (WidgetTester tester) async {
    // Render aplikasi
    await tester.pumpWidget(MyApp());

    // Temukan text field untuk input chat menggunakan Key
    final chatInput = find.byKey(Key('chat_input_field'));
    expect(chatInput, findsOneWidget);

    // Masukkan teks ke dalam input chat
    await tester.enterText(chatInput, 'Hello, this is a test!');
    await tester.pump();

    // Temukan tombol kirim dan tekan
    final sendButton = find.byKey(Key('send_message_button'));
    await tester.tap(sendButton);
    await tester.pump();

    // Verifikasi bahwa pesan dikirim
    expect(find.text('Message sent: Hello, this is a test!'), findsOneWidget);
  });

  testWidgets('Add Contact and display success message test', (WidgetTester tester) async {
    // Render aplikasi
    await tester.pumpWidget(MyApp());

    // Temukan tombol untuk menambah kontak menggunakan Key
    final addContactButton = find.byKey(Key('add_contact_button'));
    await tester.tap(addContactButton);
    await tester.pump();

    // Verifikasi apakah dialog sukses muncul setelah menambahkan kontak
    expect(find.text('Contact Added!'), findsOneWidget);
  });

  testWidgets('Temperature conversion test', (WidgetTester tester) async {
    // Render aplikasi
    await tester.pumpWidget(MyApp());

    // Temukan text field untuk input suhu menggunakan Key
    final temperatureField = find.byKey(Key('temperature_input_field'));
    expect(temperatureField, findsOneWidget);

    // Masukkan nilai suhu
    await tester.enterText(temperatureField, '25');
    await tester.pump();

    // Tekan tombol konversi suhu
    await tester.tap(find.text('Convert to °F'));
    await tester.pump();

    // Verifikasi hasil konversi suhu (misalnya, 25°C -> 77°F)
    expect(find.text('Converted: 77.0°F'), findsOneWidget);
  });
}
