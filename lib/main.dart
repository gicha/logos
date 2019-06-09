import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logos/blocs/bloc.dart';
import 'package:logos/screens/auth/index.dart';
import 'package:logos/screens/main/index.dart';
import 'package:logos/styles.dart';

import 'widgets/logo.dart';

bool isInDebugMode = false;
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  runZoned<Future<Null>>(() async {
    startHome();
  }, onError: (error, stackTrace) async {
    print('Caught error: $error');
    print(stackTrace);
  });
}

void startHome() async {
  var bloc = InitBloc.getInstance();
  NotificationBloc.getInstance();
  bloc.dispatch(InitInitEvent());

  runApp(
    MaterialApp(
      title: 'Logos',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: blueColor,
        primaryColor: blueColor,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Builder(
        builder: (context) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return Container(
              color: Colors.black,
              child: Text(
                "Внезапно",
                style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
              ),
            );
          };
          return BlocProvider(
            bloc: bloc,
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state == InitState.inited || state == InitState.noUser) {
                  return MainScreen();
                }
//                if (state == InitState.noUser) {
//                  return ScreenAuth();
//                }
                if (state == InitState.notInitedLoading) {
                  return SplashScreen();
                }
                return StubScreen();
              },
            ),
          );
        },
      ),
    ),
  );
}

class StubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: whiteColor,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 10,
            width: size.width * .5,
            child:
                LinearProgressIndicator(backgroundColor: lightGreyColor, valueColor: AlwaysStoppedAnimation(blueColor)),
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogo = false;
  bool isProgress = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 150)).then((_) {
        setState(() => isLogo = true);
        Future.delayed(Duration(milliseconds: 350)).then((_) {
          setState(() => isProgress = true);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 350),
              width: double.infinity,
              padding: EdgeInsets.only(bottom: isLogo ? 140 : 0),
              alignment: Alignment.center,
              child: LogoText(0.7, 0.04),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 350),
              opacity: isProgress ? 1 : 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 10,
                  width: size.width * .5,
                  child: LinearProgressIndicator(
                      backgroundColor: lightGreyColor, valueColor: AlwaysStoppedAnimation(blueColor)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
