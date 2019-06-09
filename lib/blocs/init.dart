part of digibreak.bloc;

abstract class InitEvent {}

class InitInitEvent extends InitEvent {}

class LogoutInitEvent extends InitEvent {}

class LoginInitEvent extends InitEvent {
  final String token;
  LoginInitEvent(this.token);
}

class ForceInitEvent extends InitEvent {}

enum InitState { notInitedLoading, noUser, loading, inited }

class InitBloc extends Bloc<InitEvent, InitState> {
  static InitBloc _instance;
  static InitBloc getInstance() {
    if (_instance == null) _instance = InitBloc();
    return _instance;
  }

  @override
  InitState get initialState => InitState.notInitedLoading;

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    if (event is InitInitEvent) {
      yield InitState.notInitedLoading;

      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      if (Platform.isAndroid)
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
      else
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await DataBase().open();
      await initializeDateFormatting();

      var store = StoreRef<String, dynamic>.main();
      String authToken = await store.record("auth").get(DataBase.db);
      if (authToken == null) {
        Api.init();
        await Future.delayed(Duration(milliseconds: 1500));
        yield InitState.noUser;
      } else {
        Config.authToken = authToken;
        Api.init(authToken);
        await Future.delayed(Duration(milliseconds: 1500));
        yield InitState.inited;
      }
    }
    if (event is LoginInitEvent) {
      yield InitState.loading;
      var store = StoreRef<String, dynamic>.main();
      store.record("auth").put(DataBase.db, event.token);
      Config.authToken = event.token;
      Api.init(event.token);
      yield InitState.inited;
    }
    if (event is LogoutInitEvent) {
      Api.logout();
      DataBase.db.clear();
      yield InitState.noUser;
    }
    if (event is ForceInitEvent) yield InitState.inited;
  }
}
