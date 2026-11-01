```dart
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const RafiqAlMusalliApp());
}

class RafiqAlMusalliApp extends StatelessWidget {
  const RafiqAlMusalliApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'رفيق المصلي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF041D17),
        primaryColor: const Color(0xFFD4A843),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainHomeScreen(),
      ),
    );
  }
}

class CityInfo {
  final String name;
  final String country;
  final double lat;
  final double lng;
  final double tz;
  const CityInfo(this.name, this.country, this.lat, this.lng, this.tz);
}

const List<CityInfo> kWorldCities = [
  CityInfo('قصر الشلالة', 'تيارت، الجزائر', 35.2122, 2.3189, 1),
  CityInfo('تيارت', 'الجزائر', 35.3710, 1.3170, 1),
  CityInfo('الشلف', 'الجزائر', 36.1652, 1.3345, 1),
  CityInfo('الجزائر العاصمة', 'الجزائر', 36.7538, 3.0588, 1),
  CityInfo('وهران', 'الجزائر', 35.6971, -0.6308, 1),
  CityInfo('قسنطينة', 'الجزائر', 36.3650, 6.6147, 1),
  CityInfo('سطيف', 'الجزائر', 36.1911, 5.4137, 1),
  CityInfo('عنابة', 'الجزائر', 36.9000, 7.7667, 1),
  CityInfo('البليدة', 'الجزائر', 36.4700, 2.8300, 1),
  CityInfo('باتنة', 'الجزائر', 35.5559, 6.1741, 1),
  CityInfo('الجلفة', 'الجزائر', 34.6728, 3.2630, 1),
  CityInfo('بسكرة', 'الجزائر', 34.8504, 5.7280, 1),
  CityInfo('تلمسان', 'الجزائر', 34.8783, -1.3150, 1),
  CityInfo('ورقلة', 'الجزائر', 31.9493, 5.3250, 1),
  CityInfo('غرداية', 'الجزائر', 32.4909, 3.6735, 1),
  CityInfo('غليزان', 'الجزائر', 35.7373, 0.5560, 1),
  CityInfo('تيسمسيلت', 'الجزائر', 35.6072, 1.8108, 1),
  CityInfo('عين الدفلى', 'الجزائر', 36.2640, 1.9679, 1),
  CityInfo('الأغواط', 'الجزائر', 33.8000, 2.8651, 1),
  CityInfo('أدرار', 'الجزائر', 27.8742, -0.2939, 1),
  CityInfo('بشار', 'الجزائر', 31.6167, -2.2167, 1),
  CityInfo('تمنراست', 'الجزائر', 22.7850, 5.5228, 1),
  CityInfo('مكة المكرمة', 'السعودية', 21.4225, 39.8262, 3),
  CityInfo('المدينة المنورة', 'السعودية', 24.4672, 39.6112, 3),
  CityInfo('الرياض', 'السعودية', 24.7136, 46.6753, 3),
  CityInfo('القاهرة', 'مصر', 30.0444, 31.2357, 2),
  CityInfo('القدس الشريف', 'فلسطين', 31.7683, 35.2137, 2),
  CityInfo('تونس العاصمة', 'تونس', 36.8065, 10.1815, 1),
  CityInfo('الدار البيضاء', 'المغرب', 33.5731, -7.5898, 1),
  CityInfo('طرابلس', 'ليبيا', 32.8872, 13.1913, 2),
  CityInfo('عمّان', 'الأردن', 31.9454, 35.9284, 3),
  CityInfo('دمشق', 'سوريا', 33.5138, 36.2765, 3),
  CityInfo('بغداد', 'العراق', 33.3152, 44.3661, 3),
  CityInfo('الدوحة', 'قطر', 25.2854, 51.5310, 3),
  CityInfo('دبي', 'الإمارات', 25.2048, 55.2708, 4),
  CityInfo('إسطنبول', 'تركيا', 41.0082, 28.9784, 3),
  CityInfo('باريس', 'فرنسا', 48.8566, 2.3522, 1),
  CityInfo('لندن', 'بريطانيا', 51.5074, -0.1278, 0),
  CityInfo('مدريد', 'إسبانيا', 40.4168, -3.7038, 1),
  CityInfo('برلين', 'ألمانيا', 52.5200, 13.4050, 1),
  CityInfo('روما', 'إيطاليا', 41.9028, 12.4964, 1),
  CityInfo('موسكو', 'روسيا', 55.7558, 37.6173, 3),
  CityInfo('جاكرتا', 'إندونيسيا', -6.2088, 106.8456, 7),
  CityInfo('كوالالمبور', 'ماليزيا', 3.1390, 101.6869, 8),
  CityInfo('طوكيو', 'اليابان', 35.6762, 139.6503, 9),
  CityInfo('نيويورك', 'الولايات المتحدة', 40.7128, -74.0060, -5),
  CityInfo('مونتريال', 'كندا', 45.5017, -73.5673, -5),
  CityInfo('سيدني', 'أستراليا', -33.8688, 151.2093, 10),
];

const List<String> kAll114Surahs = [
  'الفاتحة','البقرة','آل عمران','النساء','المائدة','الأنعام','الأعراف','الأنفال','التوبة','يونس',
  'هود','يوسف','الرعد','إبراهيم','الحجر','النحل','الإسراء','الكهف','مريم','طه',
  'الأنبياء','الحج','المؤمنون','النور','الفرقان','الشعراء','النمل','القصص','العنكبوت','الروم',
  'لقمان','السجدة','الأحزاب','سبأ','فاطر','يس','الصافات','ص','الزمر','غافر',
  'فصلت','الشورى','الزخرف','الدخان','الجاثية','الأحقاف','محمد','الفتح','الحجرات','ق',
  'الذاريات','الطور','النجم','القمر','الرحمن','الواقعة','الحديد','المجادلة','الحشر','الممتحنة',
  'الصف','الجمعة','المنافقون','التغابن','الطلاق','التحريم','الملك','القلم','الحاقة','المعارج',
  'نوح','الجن','المزمل','المدثر','القيامة','الإنسان','المرسلات','النبأ','النازعات','عبس',
  'التكوير','الانفطار','المطففين','الانشقاق','البروج','الطارق','الأعلى','الغاشية','الفجر','البلد',
  'الشمس','الليل','الضحى','الشرح','التين','العلق','القدر','البينة','الزلزلة','العاديات',
  'القارعة','التكاثر','العصر','الهمزة','الفيل','قريش','الماعون','الكوثر','الكافرون','النصر',
  'المسد','الإخلاص','الفلق','الناس'
];

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});
  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  static const MethodChannel _channel = MethodChannel('com.rafiq.musalli/silent_mode');
  int _tabIndex = 0;
  CityInfo _selectedCity = kWorldCities[0];
  String _citySearch = '';
  double _distanceMeters = 180;
  double _mosqueRadius = 65;
  bool _geofenceEnabled = true;
  double _compassHeading = 0;
  int _selectedSurahIndex = 0;
  List<String> _currentAyahs = [
    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
    'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
    'الرَّحْمَٰنِ الرَّحِيمِ',
    'مَالِكِ يَوْمِ الدِّينِ',
    'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
    'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
    'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ'
  ];
  bool _loadingSurah = false;
  double _quranFontSize = 24.0;
  Color _quranTextColor = const Color(0xFFF8FAFC);
  Color _quranBgColor = const Color(0xFF031712);
  int _tasbihCount = 0;
  int _tasbihTotal = 0;

  bool get _isPhoneSilent => _geofenceEnabled && (_distanceMeters <= _mosqueRadius);

  Future<void> _syncNativeSilentMode() async {
    try {
      if (_isPhoneSilent) {
        await _channel.invokeMethod('enableMosqueSilent');
      } else {
        await _channel.invokeMethod('restoreNormalRinger');
      }
    } catch (_) {}
  }

  Map<String, String> _calculatePrayerTimes(CityInfo city) {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;
    final gamma = (2 * math.pi / 365.0) * (dayOfYear - 1 + 0.5);
    final eqTime = 229.18 * (0.000075 + 0.001868 * math.cos(gamma) - 0.032077 * math.sin(gamma) - 0.014615 * math.cos(2 * gamma) - 0.040849 * math.sin(2 * gamma));
    final decl = 0.006918 - 0.399912 * math.cos(gamma) + 0.070257 * math.sin(gamma);
    final latRad = city.lat * math.pi / 180.0;
    final dhuhr = 12.0 + city.tz - (city.lng / 15.0) - (eqTime / 60.0);

    double ha(double altDeg) {
      final altRad = altDeg * math.pi / 180.0;
      final c = ((math.sin(altRad) - math.sin(latRad) * math.sin(decl)) / (math.cos(latRad) * math.cos(decl))).clamp(-1.0, 1.0);
      return (math.acos(c) * 180.0 / math.pi) / 15.0;
    }

    String fmt(double h) {
      final totalMin = (((h % 24) + 24) % 24 * 60).round();
      final hh = (totalMin ~/ 60) % 24;
      final mm = totalMin % 60;
      return '${hh.toString().padLeft(2, '0')}:${mm.toString().padLeft(2, '0')}';
    }

    final sunriseHa = ha(-0.833);
    final fajrHa = ha(-18.0);
    final ishaHa = ha(-17.0);
    final asrAlt = math.atan(1.0 / (1.0 + (latRad - decl).abs())) * 180.0 / math.pi;
    final asrHa = ha(asrAlt);

    return {
      'الفجر': fmt(dhuhr - fajrHa),
      'الشروق': fmt(dhuhr - sunriseHa),
      'الظهر': fmt(dhuhr + 0.03),
      'العصر': fmt(dhuhr + asrHa),
      'المغرب': fmt(dhuhr + sunriseHa + 0.03),
      'العشاء': fmt(dhuhr + ishaHa),
    };
  }

  double _calculateQiblaBearing(CityInfo city) {
    final kaabaLat = 21.4225 * math.pi / 180.0;
    final kaabaLng = 39.8262 * math.pi / 180.0;
    final phi = city.lat * math.pi / 180.0;
    final dLng = kaabaLng - (city.lng * math.pi / 180.0);
    final y = math.sin(dLng);
    final x = math.cos(phi) * math.tan(kaabaLat) - math.sin(phi) * math.cos(dLng);
    return ((math.atan2(y, x) * 180.0 / math.pi) + 360.0) % 360.0;
  }

  Future<void> _loadSurahFromApi(int index) async {
    setState(() {
      _selectedSurahIndex = index;
      _loadingSurah = true;
    });
    try {
      final client = HttpClient();
      final req = await client.getUrl(Uri.parse('https://api.alquran.cloud/v1/surah/${index + 1}/quran-uthmani'));
      final res = await req.close();
      if (res.statusCode == 200) {
        final body = await res.transform(utf8.decoder).join();
        final data = jsonDecode(body);
        final List ayahsJson = data['data']['ayahs'];
        setState(() {
          _currentAyahs = ayahsJson.map((e) => e['text'].toString()).toList();
          _loadingSurah = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loadingSurah = false);
  }

  @override
  Widget build(BuildContext context) {
    final times = _calculatePrayerTimes(_selectedCity);
    final filteredCities = kWorldCities.where((c) => c.name.contains(_citySearch) || c.country.contains(_citySearch)).toList();
    final qiblaAngle = _calculateQiblaBearing(_selectedCity);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF06372C),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('رفيق المصلّي', style: TextStyle(fontWeight: FontWeight.bold)),
            Chip(
              backgroundColor: _isPhoneSilent ? Colors.amber.withOpacity(0.3) : const Color(0xFF041D17),
              label: Text(_isPhoneSilent ? '🔕 صامت المسجد مفعّل' : '🔔 الوضع العادي'),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [
          // 1. المواقيت ومدن العالم
          ListView(
            padding: const EdgeInsets.all(14),
            children: [
              Card(
                color: const Color(0xFF09382D),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('📍 ${_selectedCity.name} — ${_selectedCity.country}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4A843))),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: const InputDecoration(hintText: 'ابحث في مدن العالم والجزائر...'),
                        onChanged: (v) => setState(() => _citySearch = v),
                      ),
                      DropdownButton<CityInfo>(
                        value: filteredCities.contains(_selectedCity) ? _selectedCity : (filteredCities.isNotEmpty ? filteredCities.first : _selectedCity),
                        isExpanded: true,
                        dropdownColor: const Color(0xFF06372C),
                        items: (filteredCities.isEmpty ? kWorldCities : filteredCities)
                            .map((c) => DropdownMenuItem(value: c, child: Text('${c.name} (${c.country})')))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _selectedCity = v);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ...times.entries.map((e) => Card(
                    color: const Color(0xFF072B22),
                    child: ListTile(
                      title: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      trailing: Text(e.value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4A843))),
                    ),
                  )),
            ],
          ),
          // 2. صامت المسجد التلقائي
          ListView(
            padding: const EdgeInsets.all(14),
            children: [
              Card(
                color: _isPhoneSilent ? const Color(0xFF451A03) : const Color(0xFF09382D),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(_isPhoneSilent ? Icons.volume_off : Icons.volume_up, size: 54, color: const Color(0xFFD4A843)),
                      const SizedBox(height: 8),
                      Text(_isPhoneSilent ? 'الهاتف في الوضع الصامت تلقائياً داخل المسجد' : 'الهاتف في الوضع العام خارج المسجد',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      Text('المسافة عن المسجد: ${_distanceMeters.round()} متر'),
                      Slider(
                        value: _distanceMeters,
                        min: 0,
                        max: 300,
                        onChanged: (v) {
                          setState(() => _distanceMeters = v);
                          _syncNativeSilentMode();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() => _distanceMeters = 10);
                              _syncNativeSilentMode();
                            },
                            child: const Text('محاكاة دخول المسجد (صامت)'),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setState(() => _distanceMeters = 200);
                              _syncNativeSilentMode();
                            },
                            child: const Text('محاكاة الخروج'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 3. القبلة
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('اتجاه القبلة من ${_selectedCity.name}: ${qiblaAngle.toStringAsFixed(1)}°',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4A843))),
                const SizedBox(height: 24),
                Transform.rotate(
                  angle: (qiblaAngle - _compassHeading) * math.pi / 180.0,
                  child: const Icon(Icons.navigation, size: 110, color: Color(0xFFD4A843)),
                ),
                Slider(
                  value: _compassHeading,
                  min: 0,
                  max: 359,
                  onChanged: (v) => setState(() => _compassHeading = v),
                ),
              ],
            ),
          ),
          // 4. القرآن الكريم (114 سورة + تخصيص الخط واللون والخلفية)
          ListView(
            padding: const EdgeInsets.all(14),
            children: [
              Card(
                color: const Color(0xFF09382D),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      DropdownButton<int>(
                        value: _selectedSurahIndex,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF06372C),
                        items: List.generate(114, (i) => DropdownMenuItem(value: i, child: Text('${i + 1}. سورة ${kAll114Surahs[i]}'))),
                        onChanged: (v) {
                          if (v != null) _loadSurahFromApi(v);
                        },
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          ActionChip(
                            label: const Text('🌙 ليلي أخضر'),
                            onPressed: () => setState(() {
                              _quranBgColor = const Color(0xFF031712);
                              _quranTextColor = const Color(0xFFF8FAFC);
                            }),
                          ),
                          ActionChip(
                            label: const Text('📜 ورق كريمي'),
                            onPressed: () => setState(() {
                              _quranBgColor = const Color(0xFFFDF6E3);
                              _quranTextColor = const Color(0xFF1E1B18);
                            }),
                          ),
                          ActionChip(
                            label: const Text('📖 بني دافئ'),
                            onPressed: () => setState(() {
                              _quranBgColor = const Color(0xFFF4ECD8);
                              _quranTextColor = const Color(0xFF3B2712);
                            }),
                          ),
                          ActionChip(
                            label: const Text('✨ أسود ذهبي'),
                            onPressed: () => setState(() {
                              _quranBgColor = const Color(0xFF08080A);
                              _quranTextColor = const Color(0xFFF3C663);
                            }),
                          ),
                        ],
                      ),
                      Slider(
                        value: _quranFontSize,
                        min: 16,
                        max: 38,
                        onChanged: (v) => setState(() => _quranFontSize = v),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _quranBgColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFD4A843)),
                ),
                child: _loadingSurah
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        _currentAyahs.asMap().entries.map((e) => '${e.value} ﴿${e.key + 1}﴾').join(' '),
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: _quranFontSize, color: _quranTextColor, height: 2.0),
                      ),
              ),
            ],
          ),
          // 5. الأذكار والمسبحة
          ListView(
            padding: const EdgeInsets.all(14),
            children: [
              Card(
                color: const Color(0xFF09382D),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Text('المسبحة الإلكترونية الذكية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => setState(() {
                          _tasbihCount++;
                          _tasbihTotal++;
                        }),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('سبّح ($_tasbihCount) — الإجمالي: $_tasbihTotal', style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Card(
                color: Color(0xFF072B22),
                child: ListTile(
                  title: Text('دعاء دخول المسجد', style: TextStyle(color: Color(0xFFD4A843), fontWeight: FontWeight.bold)),
                  subtitle: Text('بِسْمِ الل
