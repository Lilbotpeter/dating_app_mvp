abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState{
  const SplashInitial();
}

class SplashLoading extends SplashState{
  const SplashLoading();
}

class SplashGoOnboard extends SplashState{
  const SplashGoOnboard();
}

class SplashGoHome extends SplashState{
  const SplashGoHome();
}

class SplashError extends SplashState{
  final String message;
  const SplashError(this.message);
}