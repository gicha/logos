import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/styles.dart';
import 'package:logos/widgets/logo.dart';

import 'bloc.dart';

class ScreenAuth extends StatefulWidget {
  @override
  _ScreenAuthState createState() => _ScreenAuthState();
}

class _ScreenAuthState extends State<ScreenAuth> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final GlobalKey<FormState> _formKey = new GlobalKey();

  TextEditingController _emailController = TextEditingController(text: "test3@logos.com");
  TextEditingController _passwordController = TextEditingController(text: "111111");

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  AuthFormBloc authFormBloc;

  void submit() async {
    _emailFocus.unfocus();
    _passwordFocus.unfocus();
    authFormBloc.dispatch(SubmitAuthFormEvent());
  }

  @override
  void initState() {
    authFormBloc = AuthFormBloc();
    _emailController.addListener(() {
      authFormBloc.dispatch(EmailAuthFormEvent(_emailController.value.text));
    });
    _passwordController.addListener(() {
      authFormBloc.dispatch(PasswordAuthFormEvent(_passwordController.value.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    authFormBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LogoText(),
            buildForm(),
            if (MediaQuery.of(context).viewInsets.bottom == 0) Container(),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: BlocBuilder(
        bloc: authFormBloc,
        builder: (context, AuthFormState state) {
          return Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  _emailFocus.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: state.isError ? BorderSide(color: redColor, width: 2) : BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: state.isError ? BorderSide(color: redColor, width: 2) : BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (term) {
                  submit();
                },
                decoration: InputDecoration(
                  labelText: "Пароль",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: state.isError ? BorderSide(color: redColor, width: 2) : BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: state.isError ? BorderSide(color: redColor, width: 2) : BorderSide(),
                  ),
                ),
              ),
              if (state.isError == true) ...[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    SizedBox(width: 5),
                    Text("Неверный логин или пароль", style: genTextStyle(redColor, 16)),
                  ],
                ),
                SizedBox(height: 30),
              ] else
                SizedBox(height: 50),
              Container(
                width: double.infinity,
                height: 48,
                child: FlatButton(
                  child: Text("Войти", style: genTextStyle(whiteColor, 18, boldWeight)),
                  disabledColor: greyColor,
                  color: state.isSubmitEnabled == true ? blueColor : greyColor,
                  onPressed: state.isSubmitEnabled == true ? submit : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
