import 'package:flutter/material.dart';
import 'package:flutter_developer_assessment/view/location_view.dart';
import 'package:provider/provider.dart';
import '../constant/widget_designs.dart';
import '../view_model/auth_view_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AuthView extends StatelessWidget {
  FirebaseAnalytics analytics;
  FirebaseAnalyticsObserver observer;
  AuthView({required this.analytics, required this.observer});

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget loginButton = InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await AuthViewModel()
                  .loginWithViewModel(username.text, password.text);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationView(
                          analytics: analytics, observer: observer)),
                  (route) => false);
              await analytics.logLogin(loginMethod: "username-password");
            } catch (e) {
              /*ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
              print(e);
            }
          }
        },
        child: WidgetHelper().getLoginButtonDesign(
            context, 60, MediaQuery.of(context).size.width / 2, "Giriş", 20.0));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: context.watch<AuthViewModel>().state == AuthState.BUSY
            ? buildLoadingWidget()
            : context.watch<AuthViewModel>().state == AuthState.ERROR
                ? buildErrorWidget()
                : buildView(loginButton));
  }

  Center buildErrorWidget() =>
      const Center(child: Text('Something went wrong!'));

  Center buildLoadingWidget() =>
      const Center(child: CircularProgressIndicator());

  Widget buildView(Widget loginButton) {
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              TextFormField(
                controller: username,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Alan boş olamaz';
                  }
                },
                decoration: const InputDecoration(hintText: 'Kullanıcı adı'),
                style: const TextStyle(fontSize: 16.0),
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alan boş olamaz";
                  } else if (value.length < 4) {
                    return "Parola 4 karakterden kısa olamaz";
                  } else if (value.length > 20) {
                    return "Parola 20 karakterden uzun olamaz";
                  }
                },
                decoration: const InputDecoration(hintText: 'Parola'),
                style: const TextStyle(fontSize: 16.0),
              ),
              const Spacer(flex: 1),
              loginButton,
              const Spacer(flex: 4),
            ],
          ),
        ));
  }
}
