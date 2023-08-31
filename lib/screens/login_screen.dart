import 'package:clientes_articulos/blocs/theme.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:clientes_articulos/utils/utils.dart';
import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final Map<String, String> _formValues = {
    'email': '',
    'password': '',
  };
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final themeDynamic = Provider.of<ThemeChanger>(context, listen: false);
    final Color colorInputLogin = Color(0xff7F7F79);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF0F0F0),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: size.height * 0.13,
          backgroundColor: Colors.transparent,
          title: Container(
            height: size.height * 0.13,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/logos/LGO FARMENLACE.png',
                  
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "FARMAHELP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff7F7F79),
                    fontSize: size.height > size.width
                        ? size.height * 0.06
                        : size.height * 0.08,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formkey,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        AuthField(
                          color: colorInputLogin,
                          hintText: 'Usuario',
                          value: 'email',
                          formValues: _formValues,
                        ),
                        const SizedBox(height: 15),
                        AuthField(
                          color: colorInputLogin,
                          hintText: 'Contraseña',
                          value: 'password',
                          formValues: _formValues,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          text: "INGRESAR",
                          color: const Color(0xff004885),
                          onPressed: authProvider.isLoading
                              ? () {
                                  return Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                  );
                                }
                              : () async {
                                  try {
                                    if (Utils.validateEmptyField(_formValues)) {
                                      FocusScope.of(context).unfocus();
                                      Utils.showLoading(context);
                                      await authProvider.postLogin(
                                          _formValues['email']!,
                                          _formValues['password']!);

                                      themeDynamic.setTheme(
                                          authProvider.themeIsMedi
                                              ? AppTheme.mediTheme
                                              : AppTheme.ecoTheme);

                                      Future.microtask(() {
                                        Navigator.of(context).pop();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '/home', (route) => false);
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      Utils.errorMessage(
                                          context,
                                          "¡Credenciales Inválidas!",
                                          "Estimado ususario, revise sus credenciales y vuelva a intentar.");
                                    }
                                  } catch (e) {
                                    Navigator.of(context).pop();
                                    Utils.errorMessage(context,
                                        "¡Error de Login!", e.toString());
                                  }
                                },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
