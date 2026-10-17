import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recap/core/service/hive_constants.dart';
import 'package:recap/features/auth/data/auth_respostiry.dart';

import 'features/auth/presention/cubit/auth_cubit.dart';
import 'features/auth/presention/views/login_view.dart';
import 'features/products/presention/views/home_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  final productBox = await Hive.openBox(HiveConstants.productsBox);
  final favBox = await Hive.openBox(HiveConstants.favouriteBox);
  final sessionBox = await Hive.openBox(HiveConstants.sessionBox);
  final userBox = await Hive.openBox(HiveConstants.userBox);

  final bool isLoggedIn = await AuthRespostiry().isLoggedIn();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRespostiry())),
      ],
      child: MaterialApp(home: isLoggedIn ? HomeView() : LoginView()),
    );
  }
}
