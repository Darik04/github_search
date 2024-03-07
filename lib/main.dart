import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:github_search/constants/main_config_app.dart';
import 'package:github_search/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:github_search/features/auth/presentation/views/login_view.dart';
import 'package:github_search/features/main/presentation/bloc/repo/repo_bloc.dart';
import 'package:github_search/locator.dart';



Future<void> main() async {
  setupInjections();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<RepoBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MainConfigApp.appName,
        themeAnimationCurve: Curves.easeInOutQuint,
        theme: ThemeData(
          primarySwatch: ColorStyles.primarySwath,
          primaryColor: ColorStyles.primary,
          appBarTheme: const AppBarTheme(
            foregroundColor: ColorStyles.white
          )
        ),
        home: const LoginView(),
      ),
    );
  }
}
