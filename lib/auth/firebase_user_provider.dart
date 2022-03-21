import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HealthAIFirebaseUser {
  HealthAIFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

HealthAIFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HealthAIFirebaseUser> healthAIFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<HealthAIFirebaseUser>(
            (user) => currentUser = HealthAIFirebaseUser(user));
