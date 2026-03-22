import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  final int _totalStories = 3;
  int _currentIndex = 0;

  final List<StoryData> stories = [
    StoryData(
      gradientColors: [const Color(0xFF4A7C8E), const Color(0xFF2C5364)],
      caption:
          'Exploring the obsidian echoes of the city at night. This digital era feels like magic. ✨ #ObsidianEcho',
      likes: '1.2k',
      comments: '84',
    ),
    StoryData(
      gradientColors: [const Color(0xFF1a1a2e), const Color(0xFF16213e)],
      caption:
          'Lost in the neon jungle. Every corner tells a story. 🌃 #NightVibes',
      likes: '3.4k',
      comments: '120',
    ),
    StoryData(
      gradientColors: [const Color(0xFF2d5016), const Color(0xFF1a3a0a)],
      caption:
          'Nature meets technology. Finding balance in the chaos. 🌿 #Digital',
      likes: '892',
      comments: '56',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _startStory();
  }

  void _startStory() {
    _progressController.reset();
    _progressController.forward().then((_) {
      if (_currentIndex < _totalStories - 1) {
        setState(() => _currentIndex++);
        _startStory();
      }
    });
  }

  void _onTapDown(TapDownDetails details) {
    _progressController.stop();
  }

  void _onTapUp(TapUpDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx < screenWidth / 2) {
      if (_currentIndex > 0) setState(() => _currentIndex--);
    } else {
      if (_currentIndex < _totalStories - 1) setState(() => _currentIndex++);
    }
    _startStory();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background gradient ──────────────────────────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: story.gradientColors,
                ),
              ),
            ),

            // ── Geometric 3D shapes ──────────────────────────────
            CustomPaint(painter: _ShapesPainter()),

            // ── Bottom gradient overlay ──────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 350,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
              ),
            ),

            // ── Top: progress bars + user info ───────────────────
            SafeArea(
              child: Column(
                children: [
                  // Progress bars
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      children: List.generate(_totalStories, (i) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: SizedBox(
                                height: 3,
                                child:
                                    i < _currentIndex
                                        ? Container(color: Colors.white)
                                        : i == _currentIndex
                                        ? AnimatedBuilder(
                                          animation: _progressController,
                                          builder:
                                              (
                                                _,
                                                __,
                                              ) => LinearProgressIndicator(
                                                value:
                                                    _progressController.value,
                                                backgroundColor: Colors.white30,
                                                valueColor:
                                                    const AlwaysStoppedAnimation(
                                                      Colors.white,
                                                    ),
                                              ),
                                        )
                                        : Container(color: Colors.white30),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // User info row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF4FC3F7),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Container(
                              color: const Color(0xFF2C5364),
                              child: const Icon(
                                Icons.person,
                                color: Colors.tealAccent,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Name & status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Alex Rivera',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 9,
                                    height: 9,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Active now • 12 mutuals',
                                style: TextStyle(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom: caption + actions + reply ────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Caption
                      Text(
                        story.caption,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Like / Comment / Share
                      Row(
                        children: [
                          _ActionBtn(
                            icon: Icons.favorite_border,
                            label: story.likes,
                          ),
                          const SizedBox(width: 20),
                          _ActionBtn(
                            icon: Icons.chat_bubble_outline,
                            label: story.comments,
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Reply row
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 46,
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Reply to Alex...',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          _CircleBtn(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.15),
                            child: const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          _CircleBtn(
                            color: const Color(0xFF2979FF),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helper Widgets ──────────────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionBtn({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final Color color;
  final Widget child;
  const _CircleBtn({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: child,
    );
  }
}

// ─── Custom Painter (3D geometric shapes) ───────────────────────────────────

class _ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Left face of big cube
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.55)
        ..lineTo(size.width * 0.35, size.height * 0.50)
        ..lineTo(size.width * 0.35, size.height * 0.80)
        ..lineTo(0, size.height * 0.85)
        ..close(),
      Paint()..color = Colors.white.withOpacity(0.07),
    );

    // Top face of big cube
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height * 0.45)
        ..lineTo(size.width * 0.25, size.height * 0.38)
        ..lineTo(size.width * 0.35, size.height * 0.50)
        ..lineTo(0, size.height * 0.55)
        ..close(),
      // ignore: deprecated_member_use
      Paint()..color = Colors.white.withOpacity(0.12),
    );

    // Right face of big cube
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.25, size.height * 0.38)
        ..lineTo(size.width * 0.55, size.height * 0.43)
        ..lineTo(size.width * 0.55, size.height * 0.72)
        ..lineTo(size.width * 0.35, size.height * 0.80)
        ..lineTo(size.width * 0.35, size.height * 0.50)
        ..close(),
      // ignore: deprecated_member_use
      Paint()..color = Colors.white.withOpacity(0.05),
    );

    // Small cube
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.38, size.height * 0.62)
        ..lineTo(size.width * 0.60, size.height * 0.58)
        ..lineTo(size.width * 0.60, size.height * 0.78)
        ..lineTo(size.width * 0.38, size.height * 0.82)
        ..close(),
      // ignore: deprecated_member_use
      Paint()..color = Colors.white.withOpacity(0.10),
    );

    // Sphere bottom right
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.78),
      size.width * 0.18,
      Paint()..color = Colors.white.withOpacity(0.08),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Data Model ──────────────────────────────────────────────────────────────

class StoryData {
  final List<Color> gradientColors;
  final String caption;
  final String likes;
  final String comments;

  const StoryData({
    required this.gradientColors,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}
