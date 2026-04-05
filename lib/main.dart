import 'package:flutter/material.dart';

void main() {
  runApp(const RydexApp());
}

class RydexApp extends StatelessWidget {
  const RydexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rydex Passenger',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LanguageScreen(),
    );
  }
}

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('RYDEX', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 60),
            const Text('Choose Language / Выберите язык / Dil seçin', textAlign: TextAlign.center),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(lang: 'en'))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text('🇬🇧 English', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(lang: 'ru'))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text('🇷🇺 Русский', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(lang: 'tr'))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text('🇹🇷 Türkçe', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String lang;
  const HomeScreen({super.key, required this.lang});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void _goToPage(int page) {
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RYDEX'), backgroundColor: Colors.blue),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildMapPage(),
          _buildSearchingPage(),
          _buildFoundPage(),
          _buildTripPage(),
          _buildFinishedPage(),
        ],
      ),
      floatingActionButton: _currentPage == 0
          ? FloatingActionButton(onPressed: () => _goToPage(1), backgroundColor: Colors.blue, child: const Icon(Icons.add))
          : null,
    );
  }

  Widget _buildMapPage() {
    return Column(
      children: [
        Expanded(child: Container(color: Colors.grey[200], child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.location_on, size: 100, color: Colors.blue), const SizedBox(height: 20), const Text('🚕 Order a Ride', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))])))),
        Container(padding: const EdgeInsets.all(20), child: Column(children: [TextField(decoration: InputDecoration(hintText: '📍 Where from?', prefixIcon: const Icon(Icons.location_on), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))), const SizedBox(height: 15), TextField(decoration: InputDecoration(hintText: '🏁 Where to?', prefixIcon: const Icon(Icons.location_on_outlined), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))), const SizedBox(height: 20), SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => _goToPage(1), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text('✅ Confirm', style: TextStyle(color: Colors.white, fontSize: 16))))])),
      ],
    );
  }

  Widget _buildSearchingPage() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const CircularProgressIndicator(color: Colors.blue), const SizedBox(height: 30), const Text('🔍 Looking for driver...', style: TextStyle(fontSize: 18)), const SizedBox(height: 50), ElevatedButton(onPressed: () => _goToPage(2), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('✅ Driver Found (Demo)', style: TextStyle(color: Colors.white)))]));

  Widget _buildFoundPage() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)), const SizedBox(height: 20), const Text('John Driver', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 10), const Text('⭐ 4.8 • Toyota Camry', style: TextStyle(fontSize: 16)), const SizedBox(height: 30), const Text('🎉 Driver Found!', style: TextStyle(fontSize: 18, color: Colors.green)), const SizedBox(height: 50), ElevatedButton(onPressed: () => _goToPage(3), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text('🚗 Trip Started', style: TextStyle(color: Colors.white)))]));

  Widget _buildTripPage() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.directions_car, size: 80, color: Colors.blue), const SizedBox(height: 20), const Text('🚗 Trip in Progress', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 30), const Text('Duration: 12 min', style: TextStyle(fontSize: 16)), const SizedBox(height: 50), ElevatedButton(onPressed: () => _goToPage(4), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('✅ Trip Finished', style: TextStyle(color: Colors.white)))]));

  Widget _buildFinishedPage() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.check_circle, size: 80, color: Colors.green), const SizedBox(height: 20), const Text('✅ Trip Complete', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 20), const Text('💵 \$12.50', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)), const SizedBox(height: 30), const Text('Rate the driver:', style: TextStyle(fontSize: 16)), const SizedBox(height: 15), Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (i) => GestureDetector(onTap: () {}, child: const Icon(Icons.star, size: 40, color: Colors.amber)))), const SizedBox(height: 50), ElevatedButton(onPressed: () => _goToPage(0), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text('New Order', style: TextStyle(color: Colors.white)))]));

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}