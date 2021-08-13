
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:provider_sample/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SplashViewModel>.withoutConsumer(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.startTimer(context),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              'Provider sample',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
