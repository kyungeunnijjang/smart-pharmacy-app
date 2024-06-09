import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool _isHovered1 = false;
  bool _isHovered2 = false;
  bool _isHovered3 = false;

  void _onEnter(int index) {
    setState(() {
      if (index == 1) _isHovered1 = true;
      if (index == 2) _isHovered2 = true;
      if (index == 3) _isHovered3 = true;
    });
  }

  void _onExit(int index) {
    setState(() {
      if (index == 1) _isHovered1 = false;
      if (index == 2) _isHovered2 = false;
      if (index == 3) _isHovered3 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0), // 상단에서 100만큼 아래로 패딩 추가
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MouseRegion(
                  onEnter: (event) => _onEnter(1),
                  onExit: (event) => _onExit(1),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text("Hover me 1"),
                        onPressed: () {},
                      ),
                      Visibility(
                        visible: _isHovered1,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 1"),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 2"),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 3"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                MouseRegion(
                  onEnter: (event) => _onEnter(2),
                  onExit: (event) => _onExit(2),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text("Hover me 2"),
                        onPressed: () {},
                      ),
                      Visibility(
                        visible: _isHovered2,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 1"),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 2"),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 3"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                MouseRegion(
                  onEnter: (event) => _onEnter(3),
                  onExit: (event) => _onExit(3),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text("Hover me 3"),
                        onPressed: () {},
                      ),
                      Visibility(
                        visible: _isHovered3,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 1"),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 2"),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("Button 3"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
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
