import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static final String routeName = '/Jadwal';

  final String tag;
  final String title;
  final Widget child;
  final Color color;

  DetailScreen({
    @required this.tag,
    @required this.title,
    @required this.color,
    this.child,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  AnimationController scaleAnimation;
  @override
  void initState() {
    scaleAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    scaleAnimation.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: widget.tag + '_background',
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Hero(
              tag: widget.tag + '_back_button',
              child: Material(
                type: MaterialType.transparency,
                child: FadeTransition(
                  opacity: scaleAnimation,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            // width: double.infinity,
            // padding: MediaQuery.of(context).padding,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Hero(
                    tag: widget.tag + '_title',
                    transitionOnUserGestures: true,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: widget.tag + '_child',
                  child: Material(
                    type: MaterialType.transparency,
                    child: FadeTransition(
                      opacity: scaleAnimation,
                      child: ScaleTransition(
                        scale: scaleAnimation,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
