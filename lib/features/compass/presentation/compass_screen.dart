import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/core/resources/colors.dart';
import 'package:quran_app/features/compass/presentation/widgets/ComputeQiblaAngle.dart';
import 'package:quran_app/features/compass/presentation/widgets/QiblaBackground.dart';
import 'package:quran_app/features/compass/presentation/widgets/QiblaCompass.dart';
import 'package:quran_app/features/compass/presentation/widgets/QiblaText.dart';

class QiblaDirectionPage extends StatefulWidget {
  @override
  _QiblaDirectionPageState createState() => _QiblaDirectionPageState();
}

class _QiblaDirectionPageState extends State<QiblaDirectionPage> with SingleTickerProviderStateMixin {
  double? _qiblaDirection;
  double _compassHeading = 0.0;
  Position? _currentPosition;

  late StreamSubscription<Position> _locationStreamSubscription;
  late AnimationController _animationController;
  late Animation<double> _needleRotationAnimation;

  final Color _mainColor = Color(0xffa85000);

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupLocation();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _needleRotationAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
  }

  void _setupLocation() {
    _locationStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
        _calculateQiblaDirection();
      });
    });
  }

  @override
  void dispose() {
    _locationStreamSubscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateQiblaDirection() {
    if (_currentPosition == null) return;
    double qibla = computeQiblaAngle(_currentPosition!.latitude, _currentPosition!.longitude);
    setState(() {
      _qiblaDirection = qibla;
      _animateNeedleToQibla();
    });
  }

  void _animateNeedleToQibla() {
    _animationController.reset();
    if (_qiblaDirection != null) {
      _needleRotationAnimation = Tween<double>(begin: _compassHeading, end: _qiblaDirection!).animate(_animationController);
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80), // Increased height for a modern look
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffa85000), Color(0xfff7a400)], // Smooth gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent, // Keep transparent to show gradient
              elevation: 0,
              title: Padding(
                padding:EdgeInsets.only(top: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, color: Colors.white, size: 26), // Compass icon
                    SizedBox(width: 8),
                    Text(
                      "اتجاه القبلة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'Cairo',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context), // Back button
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: _calculateQiblaDirection,
                ),
              ],
            ),
          ),
        ),
      body: Stack(
        children: [
          QiblaBackground(mainColor: _mainColor),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QiblaText(qiblaDirection: _qiblaDirection),
                SizedBox(height: 20),
                QiblaCompass(needleRotationAnimation: _needleRotationAnimation),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}