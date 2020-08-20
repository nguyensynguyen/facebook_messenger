abstract class LoginEvent  {
  LoginEvent([List props = const []]) : super();
}
class GetProfileUser extends LoginEvent{}

class LoginAppEvent extends LoginEvent{
  String email;
  String password;
  LoginAppEvent({this.email,this.password});
}

class LogoutAppEvent extends LoginEvent{}

class RedirectLogin extends LoginEvent{}

class RedirectHome extends LoginEvent{}

class SignUp extends LoginEvent{
  String email;
  String password;
  SignUp({this.email,this.password});
}