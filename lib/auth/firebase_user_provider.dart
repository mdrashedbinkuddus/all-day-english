import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AllDayEnglishFirebaseUser {
  AllDayEnglishFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AllDayEnglishFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AllDayEnglishFirebaseUser> allDayEnglishFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AllDayEnglishFirebaseUser>(
            (user) => currentUser = AllDayEnglishFirebaseUser(user));
