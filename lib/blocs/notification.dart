part of digibreak.bloc;

class NotificationState {}

class ErrorState extends NotificationState {
  final String text;
  ErrorState(this.text);
}

class NotificationBloc extends Bloc<dynamic, NotificationState> {
  static NotificationBloc _instance;
  static NotificationBloc getInstance() {
    if (_instance == null) _instance = NotificationBloc();
    return _instance;
  }

  Map<String, Post> posts = {};
  @override
  NotificationState get initialState => NotificationState();

  @override
  Stream<NotificationState> mapEventToState(dynamic data) async* {
    if (data is String) yield ErrorState(data);
    yield NotificationState();
  }
}
