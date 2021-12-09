import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider _authProvider;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    _authProvider = AuthProvider();
    _authProvider.addListener(_authProviderListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authProvider,
      builder: (context, _) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          'Welcome!'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 55),
                        ),
                        const Spacer(),
                        _buildAuthCard(context),
                        const Spacer(),
                        Text(
                          "Don't have an account?".tr(),
                          style: const TextStyle(color: Color(0xFFA4A4A4)),
                        ),
                        TextButton(
                          onPressed: _launchApp,
                          child: Text(
                            'Sign up on Leaf Wallet'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Container _buildAuthCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).shadowColor.withOpacity(0.125),
            spreadRadius: 5,
          )
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 14,
                  ),
              children: [
                TextSpan(text: 'Please enter your'.tr()),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = _launchApp,
                  text: ' ${'Leaf Wallet'.tr()} ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: 'credentials.'.tr()),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<AuthProvider>(
            builder: (context, _, __) => Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextField(
                    controller: _usernameController,
                    hintText: 'Username'.tr(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9a-z@.]'),
                      ),
                    ],
                    keyboardType: TextInputType.name,
                    suffixIcon: Icons.person,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthTextField(
                    controller: _passwordController,
                    hintText: 'Password'.tr(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    obscured: !_passwordVisible,
                    onSuffixPressed: _togglePasswordVisibility,
                    suffixIcon: _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubmitButton(
                    authProvider: _authProvider,
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              left: 8,
              right: 4,
              top: 8,
            ),
            child: Image.asset(
              'assets/images/leaf_logo_green.png',
              height: 40,
            ),
          ),
          Text(
            'Loans'.tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _launchApp() async {
    await AppLinks.launchApp();
  }

  void _authProviderListener() {
    if (_authProvider.loggedIn && !_authProvider.loading) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (route) => false,
      );
    }
    if (!_authProvider.loading && _authProvider.errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_authProvider.errorMessage.tr()),
        ),
      );
    }
  }
}
