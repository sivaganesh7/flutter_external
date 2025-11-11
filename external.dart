import 'package:flutter/material.dart';

void main() => runApp(AnimationApp());

class AnimationApp extends StatelessWidget {
  const AnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      debugShowCheckedModeBanner: false,
      home: AnimationExample(),
    );
  }
}

class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  bool _fadeVisible = false;
  bool _slideVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleFade() => setState(() => _fadeVisible = !_fadeVisible);

  void _toggleSlide() {
    setState(() {
      _slideVisible = !_slideVisible;
      _slideVisible ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fade & Slide Animations"),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Fade Animation Column
            Column(
              children: [
                ElevatedButton(
                  onPressed: _toggleFade,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  child: Text(_fadeVisible ? "Hide Fade Box" : "Show Fade Box"),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _fadeVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Text("Fade Box")),
                  ),
                ),
              ],
            ),

            // Slide Animation Column
            Column(
              children: [
                ElevatedButton(
                  onPressed: _toggleSlide,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[300],
                  ),
                  child: Text(_slideVisible ? "Hide Slide Box" : "Show Slide Box"),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Text("Slide Box")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
