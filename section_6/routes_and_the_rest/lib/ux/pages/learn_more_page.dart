import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  double _pixels;
  int _timestamp;

  void _scrollListener() {
    final pixels = _scrollController.position.pixels;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    if (_pixels != null) {
      var velocity = ((pixels - _pixels) / (timestamp - _timestamp)) / 100;
      if (velocity > 0) {
        velocity = min(velocity, 0.1);
      } else {
        velocity = max(velocity, -0.1);
      }
      _particleController.update(force: velocity);
    }
    _pixels = pixels;
    _timestamp = timestamp;
  }

  @override
  void initState() {
    _particleController = ParticleController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 10,
      ),
    );
    _animationController.repeat();

    // _scrollController.position.
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateDown() {
    _scrollController.animateTo(
      MediaQuery.of(context).size.height,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                _particleController.update();
                return CustomPaint(
                  painter: ParticlePainter(_particleController.particles),
                  child: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LearnMoreHeader extends StatefulWidget {
  const LearnMoreHeader({Key key, this.visibility = 1}) : super(key: key);
  final double visibility;

  @override
  _LearnMoreHeaderState createState() => _LearnMoreHeaderState();
}

class _LearnMoreHeaderState extends State<LearnMoreHeader>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  CurvedAnimation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.slowMiddle);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Learn More',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: antiFlashColor.withOpacity(widget.visibility),
                  fontSize: 36 * widget.visibility)),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: LinePainter(progress: _animation.value),
                child: child,
              );
            },
            child: const SizedBox(
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
  ParticleController({this.numberOfParticles = 20}) {
    List.generate(numberOfParticles, (_) {
      particles.add(Particle(random));
    });
  }

  final Random random = Random();

  int numberOfParticles;
  List<Particle> particles = [];

  void update({double force}) {
    for (final particle in particles) {
      particle.applyForceUp(force: force);
      if (particle.position.dy < 0.0) {
        final yPos = 1 + lerpDouble(0.1, 0.3, random.nextDouble());
        particle.reset(y: yPos);
      }
    }
  }
}

class Particle {
  Particle(this.random) {
    _init();
  }

  Offset _position;
  double radius;
  Paint paint;
  double _force;

  final Random random;

  Offset get position => _position;

  // static const List<Color> colors = [Colors.blue, Colors.red, Colors.green];

  void _init() {
    _position = Offset(random.nextDouble(), max(0.3, random.nextDouble()));
    paint = Paint()..color = Colors.white.withOpacity(random.nextDouble());
    radius = random.nextDouble() * 10;
    _force = _randomForce();
  }

  void applyForceUp({double force}) {
    final newForce = _force + (force ?? 0);
    _position += Offset(0, -newForce);
  }

  void reset({double y}) {
    y ??= random.nextDouble();
    _position = Offset(random.nextDouble(), y);
    _force = _randomForce();
  }

  double _randomForce() {
    return lerpDouble(0.001, 0.005, random.nextDouble());
  }
}

class ParticlePainter extends CustomPainter {
  const ParticlePainter(this.particles);

  final List<Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final pos = particle.position.scale(size.width, size.height);
      canvas.drawCircle(pos, particle.radius, particle.paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
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

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  // TODO: implement vsync
  TickerProvider get vsync => null;
}
