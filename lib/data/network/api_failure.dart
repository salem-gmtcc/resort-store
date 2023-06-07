class AppFailure {
  final String message;
  final int? code;

  const AppFailure({
    required this.message,
    this.code,
  });
}
