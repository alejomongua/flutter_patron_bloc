import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = Provider.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              // Fondo
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.blue,
                    ],
                  ),
                ),
              ),
              // Circulo
              Positioned(
                top: 84,
                left: 23,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              // Circulo
              Positioned(
                top: 40,
                right: -50,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              // Circulo
              Positioned(
                top: 120,
                right: 23,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              // Circulo
              Positioned(
                top: -40,
                left: -30,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.31),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              // Titulo
              SafeArea(
                child: Column(
                  children: [
                    Icon(
                      Icons.person_pin_circle,
                      color: Colors.white,
                      size: 80,
                    ),
                    SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    Text(
                      'Hello World',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              // Formulario
              SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(height: 100),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.symmetric(vertical: 40),
                      margin: EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 3,
                              offset: Offset(0, 5),
                              spreadRadius: 3,
                            )
                          ]),
                      child: Column(
                        children: [
                          Text(
                            'Identifíquese',
                            style: TextStyle(fontSize: 20),
                          ),
                          // Email
                          StreamBuilder(
                            stream: bloc.emailStream,
                            builder: (context, snapshot) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                    ),
                                    hintText: 'ejemplo@micorreo.com',
                                    labelText: 'Correo electrónico',
                                    errorText: snapshot.error == null
                                        ? null
                                        : snapshot.error as String,
                                  ),
                                  onChanged: bloc.changeEmail,
                                ),
                              );
                            },
                          ),
                          // Password
                          StreamBuilder(
                            stream: bloc.passwordStream,
                            builder: (context, snapshot) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                    ),
                                    labelText: 'Contraseña',
                                    errorText: snapshot.error == null
                                        ? null
                                        : snapshot.error as String,
                                  ),
                                  onChanged: bloc.changePassword,
                                ),
                              );
                            },
                          ),
                          // Botón
                          StreamBuilder(
                              stream: bloc.formValidStream,
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                  onPressed: snapshot.hasData
                                      ? () => Navigator.pushReplacementNamed(
                                            context,
                                            'home',
                                          )
                                      : null,
                                  child: Container(
                                    child: Text('Ingresar'),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 40,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Text('¿Olvidó la contraseña?'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
