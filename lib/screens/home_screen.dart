import 'package:flutter/material.dart';
import 'package:siam/utils/metrics.dart';
import 'package:siam/utils/api.dart';
import 'package:siam/utils/is_dark.dart';
import 'package:siam/components/detail.dart';
import 'package:siam/screens/jadwal_screen.dart';
import 'package:siam/screens/absensi_screen.dart';
import 'package:siam/screens/khs_screen.dart';
import 'package:siam/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const pages = [
  {'text': 'Jadwal', 'color': Colors.red},
  {'text': 'Absensi', 'color': Colors.green},
  {'text': 'KHS', 'color': Colors.blue},
  {'text': 'Profile', 'color': Colors.grey},
];

class _HomeScreenState extends State<HomeScreen> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  Widget _selectChild(String text) {
    switch (text) {
      case 'Jadwal':
        return JadwalScreen();
      case 'Absensi':
        return AbsensiScreen();
      case 'KHS':
        return KHSScreen();
      case 'Profile':
        return ProfileScreen();
      default:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Test hello"),
            ],
          ),
        );
    }
  }

  _buildPages(String text, Color color, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 4 : 0;
    final double top = active ? 140 : 180;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
      margin: EdgeInsets.only(top: top, bottom: top, right: 8, left: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                // return JadwalScreen();
                return DetailScreen(
                  tag: text,
                  title: text,
                  color: color,
                  child: _selectChild(text),
                );
              },
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, 1.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 1000),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: blur,
                offset: Offset(offset, offset),
              )
            ],
          ),
          child: Stack(
            children: <Widget>[
              Hero(
                tag: text + '_background',
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Center(
                child: Hero(
                  tag: text + '_title',
                  transitionOnUserGestures: true,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 40,
                        color: isDark(color) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: text + "_back_button",
                child: Material(
                  type: MaterialType.transparency,
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(0.0),
                    child: ScaleTransition(
                      scale: AlwaysStoppedAnimation(0.0),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: text + "_child",
                child: Material(
                  type: MaterialType.transparency,
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(0.0),
                    child: ScaleTransition(
                      scale: AlwaysStoppedAnimation(0.0),
                      child: Container(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: ctrl,
        itemCount: pages.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("SIAM APPS"),
                  FlatButton(
                    child: Text("LOGOUT"),
                    onPressed: () async {
                      api.clearAuthToken();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    },
                    color: colors.secondary,
                    textColor: Colors.white,
                  ),
                ],
              ),
            );
          } else if (pages.length >= index) {
            bool active = index == currentPage;
            return _buildPages(
                pages[index - 1]['text'], pages[index - 1]['color'], active);
          }
        },
      ),
    );
  }
}
