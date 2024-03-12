import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media/firebase_options.dart';
import 'package:media/providers/authentication_provider.dart';
import 'package:media/screens/home_screen.dart';

import 'components/login_page.dart';
import 'components/signup_page.dart';

final authProvider = ChangeNotifierProvider<AuthenticationProvider>((ref) {
  final auth = AuthenticationProvider();
  auth.init();
  return auth;
});
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: const Color(0xFFFFFEF4),
        useMaterial3: true,
      ),
      home: authUser.isAuthUser ? const HomeScreen() : const LoginPage(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SignupPage.routeName: (context) => const SignupPage(),
        LoginPage.routeName: (context) => const LoginPage(),
      },
    );
  }
}
