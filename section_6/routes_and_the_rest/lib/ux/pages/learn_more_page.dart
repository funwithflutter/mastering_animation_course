import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

import '../extensions/bounce_extensions.dart';
import '../paint/line_painter.dart';
import '../styles/styles.dart';

class LearnMorePage extends StatefulWidget {
  const LearnMorePage({Key key}) : super(key: key);

  @override
  _LearnMorePageState createState() => _LearnMorePageState();
}

class _LearnMorePageState extends State<LearnMorePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  ParticleController _particleController;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _particleController = ParticleController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 10,
      ),
    );
    _animationController.forward();
    super.initState();
  }

  void _animateDown() {
    _scrollController.animateTo(
      MediaQuery.of(context).size.height,
      duration: Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: LearnMoreSliverDelegateHeader(
                  minExtent: 100,
                  maxExtent: MediaQuery.of(context).size.height,
                  onDownPressed: _animateDown,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      height: 200,
                      color: Colors.green,
                    ),
                    Container(
                      height: 200,
                      color: Colors.yellow,
                    ),
                    Container(
                      height: 200,
                      color: Colors.orange,
                    ),
                    Container(
                      height: 200,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
          // AnimatedBuilder(
          //   animation: _animationController,
          //   builder: (context, child) {
          //     _particleController.update();
          //     return CustomPaint(
          //       painter: ParticlePainter(_particleController.particles),
          //       child: Container(),
          //     );
          //   },
          // child: CustomPaint(
          //   painter: ParticlePainter(_particleController.particles),
          //   child: Container(),
          // ),
          // ),
        ],
      ),
    );
  }
}

class LearnMoreHeader extends StatefulWidget {
  LearnMoreHeader({Key key, this.visibility = 1}) : super(key: key);
  final double visibility;

  @override
  _LearnMoreHeaderState createState() => _LearnMoreHeaderState();
}

class _LearnMoreHeaderState extends State<LearnMoreHeader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text('Learn More',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: antiFlashColor.withOpacity(widget.visibility),
                    fontSize: 36 * widget.visibility)),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: LinePainter(progress: _animation.value),
                child: child,
              );
            },
            child: SizedBox(
              height: 20,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}

class ParticleController {
  final Random random = Random();

  ParticleController({this.numberOfParticles = 20}) {
    List.generate(numberOfParticles, (_) {
      particles.add(Particle(random));
    });
  }

  int numberOfParticles;
  List<Particle> particles = [];

  void update() {
    for (final particle in particles) {
      particle.applyForceUp();
    }
  }
}

class Particle {
  Offset _position;
  double radius;
  Paint paint;

  Particle(this.random) {
    _init();
  }
  final random;

  Offset get position => _position;

  void _init() {
    _position = Offset(random.nextDouble(), random.nextDouble());
    paint = Paint()..color = Colors.black;
    radius = random.nextDouble() * 10;
  }

  void reset() {
    _position = Offset(random.nextDouble(), random.nextDouble());
  }

  void applyForceUp({double force = 0.001}) {
    _position += Offset(0, -force);
  }
}

class ParticlePainter extends CustomPainter {
  static final Paint particlePaint = Paint()..color = Colors.black;
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    print(size);

    for (final particle in particles) {
      final pos = particle.position.scale(size.width, size.height);
      canvas.drawCircle(pos, 10, particlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class LearnMoreSliverDelegateHeader implements SliverPersistentHeaderDelegate {
  LearnMoreSliverDelegateHeader({
    @required this.minExtent,
    @required this.maxExtent,
    this.onDownPressed,
  });

  @override
  final double minExtent;
  @override
  final double maxExtent;

  final VoidCallback onDownPressed;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final visibility = _visibility(shrinkOffset);
    return Container(
      color: gummentalColor,
      child: Stack(
        children: <Widget>[
          LearnMoreHeader(
            visibility: visibility,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              icon: Icon(
                Icons.arrow_downward,
                color: antiFlashColor.withOpacity(visibility),
                size: 32,
              ),
              onPressed: onDownPressed,
            ),
          ).bounceDown
        ],
      ),
    );
  }

  double _visibility(double shrinkOffset) {
    return 1 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
