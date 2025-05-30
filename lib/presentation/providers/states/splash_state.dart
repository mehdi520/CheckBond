class SplashState {
  final bool isLoggedIn;

  const SplashState({this.isLoggedIn = false});

  SplashState copyWith({bool? isLoggedIn}) {
    return SplashState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}
