class SignUpExceptions {
  final String message;

  const SignUpExceptions([this.message = "An unknown error occured."]);

  factory SignUpExceptions.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpExceptions('Weak Password Entered.');
      case 'invalid-email':
        return const SignUpExceptions('Invalid Email Entered.');
      case 'email-already-in-use':
        return const SignUpExceptions(
            'An account with this email already exists.');
      case 'operation-not-allowed':
        return const SignUpExceptions('Operation not allowed. Please retry.');
      case 'user-disabled':
        return const SignUpExceptions('User disabled.');
      default:
        return const SignUpExceptions();
    }
  }
}
