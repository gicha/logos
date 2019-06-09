part of logos.bloc;

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc _instance;

  static MainBloc getInstance() {
    if (_instance == null) _instance = MainBloc();
    return _instance;
  }

  @override
  MainState get initialState => MainInitState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    print(event);
    if (event is MainUpdateEvent) {
      yield MainUpdateState();
      if (event.courierId == null && currentState.courierId == null) {
        currentState.courierId =
            json.decode((await http.get('https://192.168.47.199:8443/courierAuth/79991234567')).body)["clientId"];
        print("currentState.courierId");
        print(currentState.courierId);
      }
      if (event.center == null && currentState.center == null)
        currentState.position = LatLng(currentState.position.latitude ?? 60, currentState.position.longitude ?? 30);
      if (event.zoom == null && currentState.zoom == null) currentState.zoom = 13.0;
      if (currentState.orders == null) currentState.orders = [];
      if (currentState.delivered == null) currentState.delivered = [];
      print(event.center);
      print(event.zoom);
      yield MainLoadedState()
        ..courierId = currentState.courierId
        ..center = event.center ?? currentState.center
        ..zoom = event.zoom ?? currentState.zoom
        ..position = event.position ?? currentState.position
        ..orders = currentState.orders
        ..delivered = currentState.delivered;
    }
    if (event is MainRefreshEvent) {
      yield MainRefreshState();
      List<Order> orders = [
        Order(59.933409426899935, 30.33400425872196, "Садовая ул. 20", "#143-912"),
        Order(59.93010081819922, 30.344840383142127, "Рубинштейна ул. 20", "#173-438"),
        Order(59.92678784725718, 30.347750579923286, "Большая Московская ул. 6", "#563-087"),
        Order(59.926591612230894, 30.350336229413642, "Достоевского ул. 4", "#692-314"),
        Order(59.960827, 30.277379, "улица Красного Курсанта, 30", "#429-895"),
        Order(59.946347, 30.264322, "13-я линия Васильевского острова, 72", "#821-325"),
        Order(59.915008, 30.328341, "Можайская улица, 29", "#789-325"),
        Order(59.917152, 30.320916, "Серпуховская улица, 1", "#821-654"),
        Order(59.913532, 30.337160, "набережная Обводного канала, 66", "#123-325"),
        Order(59.917658, 30.335765, "улица Марата, 90", "#821-987"),
      ];
      yield MainLoadedState()
        ..courierId = currentState.courierId
        ..center = currentState.center
        ..zoom = currentState.zoom
        ..position = currentState.position
        ..orders = orders ?? currentState.orders
        ..delivered = currentState.delivered;
    }
    if (event is MainConfirmEvent) {
      if (currentState.delivered == null) currentState.delivered = [];
      currentState.delivered.add(currentState.orders.removeAt(0));
      yield MainConfirmState()
        ..courierId = currentState.courierId
        ..center = currentState.center
        ..zoom = currentState.zoom
        ..position = currentState.position
        ..orders = currentState.orders
        ..delivered = currentState.delivered;
      await Future.delayed(const Duration(milliseconds: 500), () => "1");
      yield MainLoadedState()
        ..courierId = currentState.courierId
        ..center = currentState.center
        ..zoom = currentState.zoom
        ..position = currentState.position
        ..orders = currentState.orders
        ..delivered = currentState.delivered;
    }
  }
}
