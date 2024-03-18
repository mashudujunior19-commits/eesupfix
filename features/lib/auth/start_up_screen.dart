import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:features/core/widgets/loading_state.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StartUpScreen extends StatelessWidget {
  const StartUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    return const SafeArea(
      child: Scaffold(
        key: Key('start_up_screen'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LoadingStateWidget(size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
