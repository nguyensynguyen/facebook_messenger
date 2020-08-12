abstract class LoginState {
  LoginState([List props = const []]) : super();
}
class InitalLogin extends LoginState{}

class LoadingLoginState extends LoginState{}

class LoginSuccessState extends LoginState{}

class LoginErrorState extends LoginState{}

class LogoutSuccessState extends LoginState{}

class LogoutErrorState extends LoginState{}

class RedirectHomeState extends LoginState{}

class RedirectLoginState extends LoginState{}