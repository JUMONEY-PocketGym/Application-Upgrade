import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

//loading indicator code is a modified and simplified version of this code
//https://github.com/fayaz07/ots

final _tKey = GlobalKey(debugLabel: 'overlay_parent');

/// Updates with the latest [OverlayEntry] child
late OverlayEntry _loaderEntry;

/// is dark theme
bool isDarkTheme = false;

/// To keep track if the [Overlay] is shown
bool _loaderShown = false;

class Loading extends StatelessWidget {
  final Widget? child;
  final bool darkTheme;

  const Loading({Key? key, this.child, this.darkTheme = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;

  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  // ignore: unused_element
  context.visitChildElements(visitor);

  assert(navigator != null, '''unable to show overlay''');
  return navigator!.overlay;
}

/// To handle a loader for the application
Future<void> showLoadingIndicator({bool isModal = true, Color? modalColor}) async {
  try {
    debugPrint('Showing loading overlay');
    final _child = Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black45,
      child: Center(
          child: SizedBox(
        child: CircularProgressIndicator(),
        /*(Platform.isAndroid
                      ? CircularProgressIndicator()
                      : CupertinoActivityIndicator()),*/
        width: 30,
        height: 30,
      )
          // SizedBox(
          //   child: CircularProgressIndicator(),
          //   /*(Platform.isAndroid
          //           ? CircularProgressIndicator()
          //           : CupertinoActivityIndicator()),*/
          //   width: 30,
          //   height: 30,
          // ),
          ),
    );
    await _showOverlay(
      child: isModal
          ? Stack(
              children: <Widget>[
                ModalBarrier(
                  color: modalColor,
                ),
                _child
              ],
            )
          : _child,
    );
    // await 3.delay();
    // hideLoadingIndicator();
  } catch (err) {
    debugPrint('Exception showing loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> hideLoadingIndicator() async {
  try {
    debugPrint('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    debugPrint('Exception hiding loading overlay');
    throw err;
  }
}

///----------------------------------------------------------------------------
/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({required Widget child}) async {
  try {
    final overlay = _overlayState;

    if (_loaderShown) {
      debugPrint('An overlay is already showing');
      return Future.value(false);
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay?.insert(overlayEntry);
    _loaderEntry = overlayEntry;
    _loaderShown = true;
  } catch (err) {
    debugPrint('Exception inserting loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> _hideOverlay() async {
  try {
    _loaderEntry.remove();
    _loaderShown = false;
  } catch (err) {
    debugPrint('Exception removing loading overlay\n${err.toString()}');
    throw err;
  }
}

getLoadingAsset(int v) {
  switch (v) {
    case 1:
      return "assets/lottie/loading1.json";
    case 2:
      return "assets/lottie/loading2.json";
    case 3:
      return "assets/lottie/loading3.json";
    case 4:
      return "assets/lottie/loading4.json";
    case 5:
      return "assets/lottie/loading5.json";
    case 6:
      return "assets/lottie/loading6.json";
    case 7:
      return "assets/lottie/loading7.json";
    case 8:
      return "assets/lottie/loading8.json";
    case 9:
      return "assets/lottie/loading9.json";
    case 10:
      return "assets/lottie/loading10.json";
    default:
      return "assets/lottie/loading1.json";
  }
}
