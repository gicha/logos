part of logos.bloc;


class MainState {
  String courierId;
  List<Order> orders = <Order>[];
  List<Order> delivered = <Order>[];
  LatLng position;
  LatLng center;
  double zoom;
}

class MainInitState extends MainState {}

class MainUpdateState extends MainState {}

class MainLoadedState extends MainState {}

class MainConfirmState extends MainState {}

class MainRefreshState extends MainState {}
