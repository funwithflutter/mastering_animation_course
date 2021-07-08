import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class WigglePath {
  WigglePath({
    this.width,
    this.height,
  }) {
    _generateBasePoints();
    randomize();
  }

  final _random = Random();

  final double width;
  final double height;

  final List<Offset> _basePoints = [];
  List<Offset> _targetPoints = [];
  List<Offset> _currentPoints = [];
  List<Offset> _previousPoints = [];

  List<Offset> get points => _currentPoints;

  void _generateBasePoints() {
    _basePoints
      ..add(const Offset(0, 0))
      ..add(Offset(0, height / 2))
      ..add(Offset(0, height))
      ..add(Offset(width / 3, height))
      ..add(Offset(width * 2 / 3, height))
      ..add(Offset(width, height))
      ..add(Offset(width, 0))
      ..add(Offset(width * 2 / 3, 0))
      ..add(Offset(width / 3, 0));

    _targetPoints = List.from(_basePoints);
    _currentPoints = List.from(_basePoints);
    _previousPoints = List.from(_basePoints);
  }

  void randomize() {
    _previousPoints = List.from(_currentPoints);
    for (var i = 0; i < points.length; i++) {
      _targetPoints[i] = _basePoints[i] + _randomOffset();
    }
  }

  void moveTo(double progress) {
    for (var i = 0; i < points.length; i++) {
      _currentPoints[i] =
          Offset.lerp(_previousPoints[i], _targetPoints[i], progress);
    }
  }

  Offset _randomOffset() {
    final dx = _random.nextDouble();
    final dy = _random.nextDouble();
    return Offset(lerpDouble(-10, 10, dx), lerpDouble(-30, 30, dy));
  }
}
