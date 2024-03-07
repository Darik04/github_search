// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:github_search/core/utils/toasts.dart';
// import 'package:github_search/core/widgets/loaders/loader_v2.dart';
// import 'package:github_search/features/auth/presentation/bloc/auth/auth_bloc.dart';
// import 'package:github_search/features/auth/presentation/views/login_view.dart';
// import 'package:github_search/features/auth/presentation/views/register_view.dart';
// import 'package:github_search/features/main/presentation/views/main_view.dart';


// class SplashView extends StatefulWidget {

//   @override
//   _SplashViewState createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     context.read<AuthBloc>().add(CheckUserLoggedEvent());
//   }


//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state){
//         if(state is RegisterSuccessState){
//           Navigator.pop(context);
//         }
//         if(state is RequiredGetUserInfoState || state is LoginSuccessState || state is RegisterSuccessState){
//           Loader.hide();
//           context.read<AuthBloc>().add(GetUserInfoEvent());
//         }
//         if(state is RequiredCheckState){
//           context.read<AuthBloc>().add(CheckUserLoggedEvent());
//         }

//         if(state is ErrorState){
//           Loader.hide();
//         }
//         if(state is AuthErrorState){
//           Loader.hide();
//         }

//         if(state is InternetErrorState){
//           Loader.hide();
//         }

//         // if(state is LoginErrorState){
//         //   Loader.hide();
//         //   showAlertToast('Попробуйте заново');
//         //   context.read<AuthBloc>().add(CheckUserLoggedEvent());
//         // }

//       },
      
//       builder: (context, state) {
//         // if(state is InternetErrorState){
//         //   return InternetConnectErrorView();
//         // }
//         // if(state is ServerErrorState){
//         //   return ServerConnectErrorView();
//         // }
//         if(state is CheckedState){
//           return MainView();
//         }
//         if(state is UserIsNotLoggedState || state is AuthErrorState){
//           return LoginView();
//         }
//         return SplashWidget();
//       },
//     );
//   }
// }

// class SplashWidget extends StatelessWidget {
//   const SplashWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LoaderV2()
//     );
//   }
// }