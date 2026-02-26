import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ColorType {
  red(color: Colors.red),
  blue(color: Colors.blue);

  final Color color;

  const ColorType({required this.color});
}

// NOTIFIER
class ColorTapsNotifier extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;

  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;

  int getCount(ColorType type) {
    return switch (type) {
      ColorType.red => redTapCount,
      ColorType.blue => blueTapCount,
    };
  }

  void increment(ColorType type) {
    if (type == ColorType.red) {
      _redTapCount++;
    } else {
      _blueTapCount++;
    }
    notifyListeners();
  }
}



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorTapsNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Home()),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTapsNotifier tapsNotifier = context.watch<ColorTapsNotifier>();
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: tapsNotifier,
        builder: (context, child) => Column(
          children: [
            ColorTap(
              type: ColorType.red,
              tapCount: tapsNotifier.redTapCount,
              onTap: () => tapsNotifier.increment(ColorType.red),
            ),
            ColorTap(
              type: ColorType.blue,
              tapCount: tapsNotifier.blueTapCount,
              onTap: () => tapsNotifier.increment(ColorType.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final ColorType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTapsNotifier colorNotifier = context.read<ColorTapsNotifier>();
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Taps: ${colorNotifier.redTapCount}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Blue Taps: ${colorNotifier.blueTapCount}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
