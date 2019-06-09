part of logos.bloc;

abstract class MainEvent {}

class MainUpdateEvent extends MainEvent {
  final LatLng position;
  final LatLng center;
  final double zoom;
  final String courierId;

  MainUpdateEvent({this.position, this.zoom, this.center, this.courierId});
}

class MainRefreshEvent extends MainEvent {
  MainRefreshEvent();
}

class MainConfirmEvent extends MainEvent {
  MainConfirmEvent();
}
