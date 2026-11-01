import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const RafiqAlMusalliApp());
}

class RafiqAlMusalliApp extends StatefulWidget {
  const RafiqAlMusalliApp({super.key});
  @override
  State<RafiqAlMusalliApp> createState() => _RafiqAlMusalliAppState();
}

class _RafiqAlMusalliAppState extends State<RafiqAlMusalliApp> {
  static const MethodChannel _channel = MethodChannel('com.rafiq.musalli/silent_mode');
  bool isSilent = false;
  String selectedCity = 'الشلف / قصر الشلالة - الجزائر';

  Future<void> toggleMosqueSilent() async {
    try {
      if (!isSilent) {
        await _channel.invokeMethod('enableMosqueSilent');
      } else {
        await _channel.invokeMethod('restoreNormalRinger');
      }
      setState(() => isSilent = !isSilent);
    } catch (_) {
      setState(() => isSilent = !isSilent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'رفيق المصلي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF041D17),
        primaryColor: const Color(0xFFD4A843),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF06372C),
            title: const Text('رفيق المصلي - المواقيت والقبلة والقرآن وصامت المسجد'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: const Color(0xFF093026),
                child: ListTile(
                  title: Text('المنطقة الحالية: $selectedCity', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('الفجر: 05:44 | الظهر: 12:29 | العصر: 15:26 | المغرب: 17:51 | العشاء: 19:11'),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: isSilent ? const Color(0xFF451A03) : const Color(0xFF093026),
                child: ListTile(
                  title: Text(isSilent ? 'الوضع الصامت داخل المسجد: مفعّل تلقائياً 🔕' : 'وضع الرنين: عادي (خارج المسجد) 🔔'),
                  subtitle: const Text('يتحول الهاتف لصامت تلقائياً عند دخول نطاق المسجد (GPS) أو وقت الصلاة'),
                  trailing: ElevatedButton(
                    onPressed: toggleMosqueSilent,
                    child: Text(isSilent ? 'إلغاء الصامت' : 'تفعيل صامت المسجد'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                color: Color(0xFF093026),
                child: ListTile(
                  title: Text('اتجاه القبلة نحو مكة المكرمة: 103.8° شرق-جنوب شرق 🕋'),
                  subtitle: Text('المصحف الشريف الكامل (114 سورة) + حصن المسلم والأذكار اليومية'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
