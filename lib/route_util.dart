import 'package:flutter/widgets.dart';

class RouteUtil {
  static Route newCommonPageRoute(
      Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static SlideTransition slideTransitionRTL(ctx, one, two, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(one),
      child: child,
    );
  }

  static SlideTransition slideTransitionLTR(ctx, one, two, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(one),
      child: child,
    );
  }
}
