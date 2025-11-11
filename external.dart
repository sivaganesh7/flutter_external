import 'package:flutter/material.dart';

void main() {
  runApp(Animation_App());
}

class Animation_App extends StatelessWidget {
  const Animation_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Styles',
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
  bool fade = false, slide = false;
  late AnimationController controller;
  late Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    slideAnim = Tween(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() => controller.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fade & Slide Animations")),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => fade = !fade),
                  child: Text(fade ? "Hide Fade Box" : "Show Fade Box"),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: fade ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: buildBox("Fade Box", Colors.greenAccent),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => slide = !slide);
                    slide ? controller.forward() : controller.reverse();
                  },
                  child: Text(slide ? "Hide Slide Box" : "Show Slide Box"),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: slideAnim,
                  child: buildBox("Slide Box", Colors.orangeAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBox(String text, Color color) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
