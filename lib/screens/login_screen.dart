import 'package:dinder/actions/app_user_actions.dart';
import 'package:dinder/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../services/auth.dart';
import '../models/app_user_state.dart';
import '../services/firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onWillChange: (previousViewModel, newViewModel) {
        if (newViewModel.isLoggedIn) {
          if (previousViewModel?.isLoggedIn != newViewModel.isLoggedIn) {
            Navigator.pushNamed(context, '/home');
          }
        } else {
          Navigator.pushNamed(context, '/login');
        }
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(children: [
            const Text("LOGIN"),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    vm.onSubmitEmailPassword(emailController.text,
                        passwordController.text, "Register");
                  },
                  child: Text('Register')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Creating User...")));
                  vm.onSubmitEmailPassword(
                      emailController.text, passwordController.text, "Login");
                },
                child: Text('Login with email and password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Creating User...")));
                  vm.onSubmitGoogle();
                },
                child: Text('Login with Google'),
              ),
            )
          ]),
        ));
      },
    );
  }
}

class _ViewModel {
  final String? displayName;
  final bool isLoggedIn;
  final dynamic Function(String email, String password, String loginType)
      onSubmitEmailPassword;
  final dynamic Function() onSubmitGoogle;

  static FirestoreService _firestoreService = FirestoreService.instance;
  static AuthService _authService = AuthService.instance;

  _ViewModel({
    required this.displayName,
    required this.isLoggedIn,
    required this.onSubmitGoogle,
    required this.onSubmitEmailPassword,
  });

  static fromStore(Store<AppState> store) {
    void logInUser(String id, AppUser loggedInUser) async {
      final AppUser? user = await _firestoreService.getUser(id).first;
      if (user == null) {
        _firestoreService.createUser(id, loggedInUser);
      } else {
        loggedInUser = loggedInUser.copyWith(
            displayName: user.displayName,
            friends: user.friends,
            dismissed: user.dismissed);
      }
      store.dispatch(LogInUser(loggedInUser));
    }

    return _ViewModel(
        isLoggedIn: store.state.userState.isLoggedIn,
        displayName: store.state.userState.displayName,
        onSubmitEmailPassword:
            (String email, String password, String loginType) async {
          try {
            AppUser? user;
            if (loginType == "Register") {
              user = await _authService.createUserWithEmailAndPassword(
                  email: email, password: password);
            } else {
              user = await _authService.signInWithEmailAndPassword(
                  email: email, password: password);
            }
            // This user is either a legit user thats logged in or a logged out dummy user
            bool isUserValid = user.isLoggedIn;
            if (isUserValid) {
              logInUser(user.id, user);
            } else {
              print("User was not valid");
            }
          } catch (e) {
            print('CATCH $e');
          }
        },
        onSubmitGoogle: () async {
          try {
            print('authservice ${_authService.toString()}');
            final AppUser user = await _authService.signInWithGoogle();
            print(user);
            if (user.isLoggedIn) {
              logInUser(user.id, user);
            } else {
              print("bummer");
            }
          } catch (e) {
            print('CATCH');
            print(e);
          }
        });
  }
}
