import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tictactoe/core/navigation/app_route_observer.dart';

/// Calls [onVisible] when this route becomes visible again after a route above it is popped.
void useOnRouteVisible(VoidCallback onVisible) {
  final context = useContext();
  final onVisibleRef = useRef(onVisible);
  onVisibleRef.value = onVisible;

  final routeAware = useMemoized(
    () => _OnRouteVisibleObserver(() => onVisibleRef.value()),
    const [],
  );

  useEffect(() {
    var isSubscribed = false;
    var isDisposed = false;

    void subscribeIfNeeded() {
      if (isDisposed || isSubscribed) {
        return;
      }

      final route = ModalRoute.of(context);
      if (route == null) {
        return;
      }

      appRouteObserver.subscribe(routeAware, route);
      isSubscribed = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => subscribeIfNeeded());

    return () {
      isDisposed = true;
      if (isSubscribed) {
        appRouteObserver.unsubscribe(routeAware);
      }
    };
  }, [routeAware]);
}

final class _OnRouteVisibleObserver with RouteAware {
  _OnRouteVisibleObserver(this._onPopNext);

  final VoidCallback _onPopNext;

  @override
  void didPopNext() {
    _onPopNext();
  }
}
