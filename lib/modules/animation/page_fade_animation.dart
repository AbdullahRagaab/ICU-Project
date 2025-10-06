import 'package:flutter/cupertino.dart';

class PageFadeAnimation extends PageRouteBuilder {
  dynamic page;
  PageFadeAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            // transitionDuration: const Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              return Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            });
}
