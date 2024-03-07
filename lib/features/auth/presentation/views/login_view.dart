import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:github_search/constants/texts/text_styles.dart';
import 'package:github_search/core/services/database/auth_params.dart';
import 'package:github_search/core/utils/toast.dart';
import 'package:github_search/core/widgets/btns/primary_btn.dart';
import 'package:github_search/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:github_search/features/main/presentation/views/search_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  void onLogin(AuthType authType){
    // showLoaderWrapper(context);
    context.read<AuthBloc>().add(SignInEvent(
      authType: authType
    ));
  }
  @override
  Widget build(BuildContext context) {
    // final authType = Platform.isIOS ? AuthType.apple : AuthType.google;

    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const SearchView()), (_) => false);
          }
          if(state is AuthErrorState){
            showAlertToast(state.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 64,),
                Text('GitHub search', style: TextStyles.black50w800,),
                
                Column(
                  children: [
                    // if(authType == AuthType.google)
                    PrimaryBtn(
                      onTap: () => onLogin(AuthType.google), 
                      isRed: true,
                      text: 'Login with Google'
                    ),
                    const SizedBox(height: 14,),
                    // else
                    PrimaryBtn(
                      onTap: () => onLogin(AuthType.apple), 
                      text: 'Login with Apple'
                    ),
                  ],
                ),
                const SizedBox(height: 64,),
                
              ],
            ),
          )
        ),
      ),
    );
  }
}