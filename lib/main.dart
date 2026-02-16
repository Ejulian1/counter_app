import 'package:flutter/material.dart';

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter & Toggle',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  bool _isDark = false;
  late AnimationController _controller;
  late Animation<double> _fade;
  bool _isFirstImage = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);

    _controller.value = 2.0; 
  }

  void _toggleImage() {
    if (_isFirstImage) {
      _controller.forward(); 
    } else {
      _controller.reverse(); 
    }
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter(int amount) {
    setState(() => _counter += amount);
  }

  void _decrementCounter(int amount) {
    if (_counter > 0) {
      setState(() => _counter -= amount);
    }
  }

  void _rest(int amount) {
    _counter = 0;
    setState(() {});
  }

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Counter & Toggle'),
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$_counter', style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _incrementCounter(1),
                    child: const Text('+1'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _incrementCounter(5),
                    child: const Text('+5'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _incrementCounter(10),
                    child: const Text('+10'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _decrementCounter(1),
                    child: const Text('-1'),
                  ),
                  
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _rest(1),
                    child: const Text('Reset'),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fade,
                child: Image.asset(
                  _isFirstImage
                      ? 'assets/image/image2.png'
                      : 'assets/image/image1.png',
                  width: 350,
                  height: 350,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
