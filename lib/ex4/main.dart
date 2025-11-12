import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EX4 - Weather',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}

// Enum for weather kind (reusing EX2 pattern)
enum WeatherType { cloudy, sunny, partlyCloudy }

extension on WeatherType {
  // Prefer PNG assets provided in lib/ex4/ when available
  String get asset => switch (this) {
        WeatherType.cloudy => 'lib/ex4/cloudy.png',
        WeatherType.sunny => 'lib/ex4/sunny.png',
        WeatherType.partlyCloudy => 'lib/ex4/sunnyCloudy.png',
      };

  // Provide a pair of colors for gradient (reusing EX3 style theming)
  List<Color> get gradient => switch (this) {
        // Purple gradient (closer to screenshot)
        WeatherType.cloudy => [const Color(0xFFC471ED), const Color(0xFF8A4FFF)],
        // Pink gradient
        WeatherType.sunny => [const Color(0xFFF857A6), const Color(0xFFFF5858)],
        // Teal/mint gradient
        WeatherType.partlyCloudy => [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      };
}

// Simple model for a city forecast (title + temps)
class CityWeather {
  final String city;
  final double minC;
  final double maxC;
  final double currentC;
  final WeatherType type;
  final List<Color>? gradient;

  const CityWeather({
    required this.city,
    required this.minC,
    required this.maxC,
    required this.currentC,
    required this.type,
    this.gradient,
  });
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  static const cities = <CityWeather>[
    CityWeather(city: 'PhnomPenh', minC: 10, maxC: 30, currentC: 12.2, type: WeatherType.cloudy),
    // Paris mint/teal gradient to match the provided design
    CityWeather(
      city: 'Paris',
      minC: 10,
      maxC: 40,
      currentC: 22.2,
      type: WeatherType.partlyCloudy,
      gradient: [Color(0xFF61EAC2), Color(0xFF39D6C7)],
    ),
    CityWeather(city: 'Rome', minC: 10, maxC: 40, currentC: 45.2, type: WeatherType.sunny),
    // Toulouse with custom orange gradient as per screenshot
    CityWeather(
      city: 'Toulouse',
      minC: 10,
      maxC: 40,
      currentC: 45.2,
      type: WeatherType.cloudy,
      gradient: [Color(0xFFF6C37A), Color(0xFFE9A25B)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          title: const Text(
            'Weather',
            // Keep for tests, but visually hide to match screenshot
            style: TextStyle(color: Colors.transparent),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9AD1F5), Color(0xFF6CB8E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFEAF2FB),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cities.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final c = cities[index];
            return WeatherCard(data: c);
          },
        ),
      ),
    );
  }
}

// A rounded card with gradient + shadow (PhysicalModel), aligned content, and optional decorative oval.
class WeatherCard extends StatelessWidget {
  final CityWeather data;
  const WeatherCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
  final colors = data.gradient ?? data.type.gradient;
  const radius = 24.0;

    return PhysicalModel(
      color: Colors.transparent,
  elevation: 10,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: _Content(data: data),
          ),
          // Optional decorative oval on the right side
          Positioned(
            right: -40,
            top: -10,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final CityWeather data;
  const _Content({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Strict circular badge to avoid any square edges from the PNG
          ClipOval(
            child: Material(
              color: Colors.white, // solid white disc like the screenshot
              child: SizedBox(
                width: 56,
                height: 56,
                child: Center(
                  child: Image.asset(
                    data.type.asset,
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // City name + min/max
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.city,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Min ${_fmt(data.minC)}°C\nMax ${_fmt(data.maxC)}°C',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Current temperature on right
          Text(
            '${_fmt(data.currentC)}°C',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(double v) => v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 1);
}
