abstract class LoginEvent  {
  LoginEvent([List props = const []]) : super();
}
class GetProfileUser extends LoginEvent{}

class LoginAppEvent extends LoginEvent{}

class LogoutAppEvent extends LoginEvent{}

class RedirectLogin extends LoginEvent{}

class RedirectHome extends LoginEvent{}