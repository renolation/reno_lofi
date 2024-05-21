import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

/// Authentication class for this sample application.
/// It should be self-explanatory.
@freezed
sealed class Auth with _$Auth {
  const factory Auth.signedIn({
    required String id,
  }) = SignedIn;

  const Auth._();

  const factory Auth.signedOut() = SignedOut;

  bool get isAuth => switch (this) {
        SignedIn() => true,
        SignedOut() => false,
      };

}
