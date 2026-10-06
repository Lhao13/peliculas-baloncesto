
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_pelis/Pantalla_Listaquierover.dart';
import 'package:proyecto_pelis/Pantalla_buscarPelicula.dart';
import 'package:proyecto_pelis/Pantalla_ListaVista.dart';
import 'package:proyecto_pelis/Pantalla_Recomendados.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> main(List<String> arguments) async {
   runApp(MyApp());
}

Future<void> sendLogIn(String correo, String contrasena, BuildContext context) async {
  final headers = {
  'Access-Control-Allow-Origin': '*',
};
  try {
    var url = Uri.parse('http://10.0.2.2:38080/logIn?correo=$correo&contrasena=$contrasena');
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200) {
      var bodyUtf8 = utf8.decode(response.bodyBytes);
      List<dynamic> nombre = jsonDecode(bodyUtf8);
      var primerNombre;
      var primerApellido;
      for (var nombres in nombre) {
        primerNombre = nombres['primerNombre'];
        primerApellido = nombres['primerApellido'];
        id = nombres['personaId'];
        preferencia = nombres['preferencia'];
      }
      if(primerNombre == null || primerApellido == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo o contraseña incorrectos'),
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PantallaPrincipal()),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correo o contraseña incorrectos'),
        ),
      );
    }
  } catch (e) {
    print('Error: ${e.toString()}');    
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error de conexión'),
      ),
    );
  }
}
//fix the birthday 
Future<void> sendSignUp(bool check, String primer_nombre, String primer_apellido, DateTime birthday, bool genero, preferencia, String correo, String contrasena, BuildContext context) async {
  final headers = {
  'Access-Control-Allow-Origin': '*',
};
  String birth = (birthday.year.toString() + '-' + birthday.month.toString() + '-' + birthday.day.toString());
  if(primer_nombre == "" || primer_apellido == "" || correo == "" || contrasena == "" || preferencia==0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todos los campos son requeridos'),
      ),
    );
    return;
  }
  if(check==true){
  try {
    var url = Uri.parse('http://10.0.2.2:38080/signUp?primer_nombre=$primer_nombre&primer_apellido=$primer_apellido&birthday=$birth&genero=$genero&preferencia=$preferencia&correo=$correo&contrasena=$contrasena');
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200) {
      var bodyUtf8 = utf8.decode(response.bodyBytes);
      List<dynamic> nombre = jsonDecode(bodyUtf8);
      var primerNombre;
      var primerApellido;
      for (var nombres in nombre) {
        primerNombre = nombres['primerNombre'];
        primerApellido = nombres['primerApellido'];
        id = nombres['personaId'];
        preferencia = nombres['preferencia'];
      }
    
      if(primerNombre == "01") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El correo debe de tener un @'),
          ),
        );
        return;
      }
      if(primerNombre == "02") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La fecha proporcionada esta fuera de rango'),
          ),
        );
        return;
      }
      if(primerNombre == "03") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La cantidad máxima de caracteres para el apellido es 50'),
          ),
        );
        return;
      }
      if(primerNombre == "04") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La cantidad máxima de caracteres para el nombre es 50'),
          ),
        );
        return;
      }
      if(primerNombre == null || primerApellido == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo ya esta en uso'),
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PantallaPrincipal()),
      );

    } 
    else {
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo crear usuario'),
        ),
      );
    }
  } catch (e) {
    print('Error: ${e.toString()}');    
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error de conexión'),
      ),
    );
  }
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Debe aceptar los términos y condiciones'),
      ),
    );
  }
}

//global variables
const List<String> list = <String>['Male', 'Female'];
const List<String> pref = <String>['Seleccionar Preferencia','Otro', 'Internacional','High School', 'NCAA/College','NBA/WNBA' ];
String dropdownValue = list.first;
bool gender = false;
int id=0;
int preferencia=0;
//main app stateless widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        ),
        body: 
        MyCustomLayout(),
      ),
    );
  }
}
//stateful login
class MyCustomLayout extends StatefulWidget {
  @override
  _MyCustomLayoutState createState() => _MyCustomLayoutState();
}
//para iniciar el login
class _MyCustomLayoutState extends State<MyCustomLayout> {

  @override
  Widget build(BuildContext context) {
    return 
     LogInRoute();      
  }
  
}
class LogInRoute extends StatefulWidget {
  @override
  _LogInRoute createState() => _LogInRoute();
}
//login layout with logo, email textfield, password textfield, log in button, sign up button and forgot password button.
class _LogInRoute extends State<LogInRoute> {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: 
//listview with logo, email textfield, password textfield, log in button, sign up button and forgot password button.      
      ListView(
        padding: const EdgeInsets.all(56.0),
        children: <Widget> [
          Center(
            child: 
      Column(

        crossAxisAlignment: CrossAxisAlignment.start,
      
      children: <Widget>  [
//logo        
    const SizedBox(
          height: 20.0, 
        ),
//email text
Center(
        
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45, 
            child: Image.asset(
              "assets/imagenes/MatchUp.png",              
            ),
          ),
        ),
        const  Text (
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(              
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//email textfield
          Center(
            child: 
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: "example@email.com",
                    ),
            style: const TextStyle(fontSize: 12), 
                    ),
                    ),
//password text
        const  Text (
            "Password",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//password textfield
          Center(
            child: 
          TextFormField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "*********",
              suffixIcon: IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
              setState(() {
              _isPasswordVisible = !_isPasswordVisible;
              }
              );
            },
          ),
        ),
              style: const TextStyle(fontSize: 12),
      ),
    ), 

    const SizedBox(
          height: 20.0, 
        ),
//log in elevated button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
             ),
            child: ElevatedButton(
              onPressed: () async {
                    await sendLogIn(emailController.text, passwordController.text,context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                backgroundColor: const Color.fromRGBO(255, 131, 81, 1),

              ),
              child: const Column(
                children: <Widget>[

                                  Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
  
                                   
                ],
                
              ),
              
              
            ),
          ),
//sign up text button
          Center(child: 

          TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpRoute()),
                      ),
                      child: const Text(
                      "Sign Up",
                      style: TextStyle(
                      color: Color.fromRGBO(255, 131, 81, 1), fontSize: 12,
                      )
                      ),
                      ), 
          ),
                               
      ],   
    ),
          )
    ],
      ),

    );
  }
}
//stateful signup
class SignUpRoute extends StatefulWidget {
  @override
  _SignUpRoute createState() => _SignUpRoute();
}
 //signup layout with a lot of text fields, buttons, drop down box, checkbox and text buttons. 
class _SignUpRoute extends State<SignUpRoute> {
  bool _isChecked = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  DateTime selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1919),
      lastDate: DateTime.now(),
    );
      setState(() {selectedDate = picked!;});
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: 
//list view with column inside with sign up stuff. it has a lot of text fields and buttons. drop button, 
//checkbox, elevated and text buttons.      
      ListView(
        padding: const EdgeInsets.all(56.0),

        children: <Widget> [
        
      Column(

        

        crossAxisAlignment: CrossAxisAlignment.start,

      
      children: <Widget>  [
//logo
        Center(
         child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45, 
            child: Image.asset(
              "assets/imagenes/MatchUp.png",
            ),
          ),
        ),      
//first name
        const  Text (
            "First Name",
            textAlign: TextAlign.left,
            style: TextStyle(              
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//first name textfield
          Center(
            child: 
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: "Enter your first name",
                    ),
            style: const TextStyle(fontSize: 12), 
                    ),
                    ),
//last name
        const  Text (
            "Last Name",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//first lastname textfield
          Center(
            child: 
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: "Enter your last name",
                    ),
            style: const TextStyle(fontSize: 12), 
                    ),
                    ),  
//birthday
          const Text (
            "Birthday",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//birthday select date button            
            Center(child: 
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            ),
            Center(
            child:
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                        shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
              child: const Text(
                      "Select Date",
                      style: TextStyle(
                      color: Color.fromRGBO(115,115,115,0.8), fontSize: 12,
                      )
                      ),
                      
            ),
            ),
//gender
                  const  Text (
            "Biological Gender",
            textAlign: TextAlign.left,
            style: TextStyle(              
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//gender drop box with global variable
          Center(
            child: 
            DropdownButton<String>(
            value: dropdownValue,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(115, 115, 115, 0.8)
              ),
      underline: Container(
        height: 2,
        color:const Color.fromRGBO(115, 115, 115, 0.5),
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          gender = !gender;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),                  
     ),             

//preferencias
          const Text (
            "Preferencia de Contenido",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//preferencias drop box with global variable
          Center(
            child: 
            DropdownButton<String>(
            value: pref[preferencia],
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(115, 115, 115, 0.8)
              ),
      underline: Container(
        height: 2,
        color:const Color.fromRGBO(115, 115, 115, 0.5),
      ),
      onChanged: (String? value) {
        setState(() {
          preferencia = pref.indexOf(value!);
        });
      },
      items: pref.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),                  
     ),


//email
          const Text (
            "Email",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//email textfield
          Center(
            child: 
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: "Enter your email",
                    ),
            style: const TextStyle(fontSize: 12), 
                    ),
                    ),  
//password
          const Text (
            "Password",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),
//password box
          Center(
            child: 
          TextFormField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "*********",
              suffixIcon: IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
              }
              );
            },
          ),
        ),
              style: const TextStyle(fontSize: 12),
      ),
    ),
//checkbox and some text buttons
SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
          Row(
            children: <Widget> [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                    setState(() {
                    _isChecked = value!;
                });
                },
              ),
              const Text(
                "I agree to the",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),

              TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TSRoute()),
                      ),
                      child: const Text(
                      "Terms of Service",
                      style: TextStyle(
                      color: Color.fromRGBO(255, 131, 81, 1), fontSize: 12, fontWeight: FontWeight.bold,
                      )),
                      ), 



              const Text(
                "and",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),

                TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TSRoute()),
                      ),
                      child: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                      color: Color.fromRGBO(255, 131, 81, 1), fontSize: 12, fontWeight: FontWeight.bold,
                      )),
                      ), 



            ],
          ),
),
//signup elevated button          

           Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            child: ElevatedButton(
              
                       onPressed: () async {
                    await sendSignUp(_isChecked, firstNameController.text, lastNameController.text, selectedDate, gender, preferencia,emailController.text, passwordController.text, context);
                     },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 131, 81, 1),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  
                  
                ),

              ),
              child: const Column(
                children: <Widget>[

                                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
  
                                   
                ],
                
              ),
              
              
            ),
          ),
//back to login text button
    Center(
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
          const Text(
            "Already have an account?",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(122, 128, 177, 1),
            ),
          ),
          TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (_) => LogInRoute()),
                      ),
                      child: const Text(
                      "Log In",
                      style: TextStyle(
                      color: Color.fromRGBO(255, 131, 81, 1),
                      )),
                      )
      ],
    ),
    ),


                 
      ],   
    )
    ],
      ),
    );
  }
}

class TSRoute extends StatefulWidget {
  @override
  _TSRoute createState() => _TSRoute();
}

class _TSRoute extends State<TSRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  

      body:     ListView(
                padding: const EdgeInsets.all(56.0),


        children: <Widget> [ Column(

      children: <Widget>  [
           Center(
         child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45, 
            child: Image.asset(
              "assets/imagenes/MatchUp.png",
            ),
          ),
        ),

     const   Text (
            "Terms of Service and Privacy",
            textAlign: TextAlign.left,
            style: TextStyle(              
              fontSize: 20,
              color: Color.fromRGBO(255, 131, 81, 1),
            ),
          ),

            const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        
            ),
  const   Text(
  'Terms of Service\n',
  style: TextStyle(
    fontWeight: FontWeight.bold,
  ),
),
const Text(
          // Paste your terms of service text here
          "Welcome to MovieUp! \nThese terms outline the rules and regulations for the use of MovieUp's mobile application.\nBy accessing this app, we assume you accept these terms and conditions. Do not continue to use MovieUp if you do not agree to all of the terms and conditions stated on this page."
        
        ),
  const   Text(
  '\nLicense\n',
  style: TextStyle(
    fontWeight: FontWeight.bold,
  ),
),

const Text(
  'Unless otherwise stated, MovieUp and/or its licensors own the intellectual property rights for all material on MovieUp. All intellectual property rights are reserved. You may access this from MovieUp for your own personal use subjected to restrictions set in these terms and conditions.'
  ),
  const   Text(
  'You must not:',
  style: TextStyle(
    fontWeight: FontWeight.bold,
  ),
  ),
         const ListTile(
      leading: Icon(Icons.donut_small_rounded),
      title: Text('Republish material from MovieUp'),
    ),
            const ListTile(
      leading: Icon(Icons.donut_small_rounded),
      title: Text('Sell, rent or sub-license material from MovieUp'),
    ),
                const ListTile(
      leading: Icon(Icons.donut_small_rounded),
      title: Text('Reproduce, duplicate or copy material from MovieUp'),
    ),
                   const ListTile(
      leading: Icon(Icons.donut_small_rounded),
      title: Text('Redistribute content from MovieUp'),
    ),
     const   Text(
  '\nPrivacy Policy\n',
  style: TextStyle(
    fontWeight: FontWeight.bold,
  ),
     ),
    
       const Text(
        "Your privacy is important to us. It is MovieUp's policy to respect your privacy regarding any information we may collect from you across our app.\nWe only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.\nWe only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.\nWe don’t share any personally identifying information publicly or with third-parties, except when required to by law.\nOur app may link to external sites that are not operated by us. Please be aware that we have no control over the content and practices of these sites, and cannot accept responsibility or liability for their respective privacy policies.\nBy using our app, you hereby consent to our Privacy Policy and agree to its terms.",
       ),
    const   Text(
  '\nChanges to our Terms of Service and Privacy Policy\n',
  style: TextStyle(
    fontWeight: FontWeight.bold,
  ),
     ),
const Text(
       "We reserve the right to modify these terms from time to time at our sole discretion. Therefore, you should review these pages periodically. Your continued use of the app after any such change constitutes your acceptance of the new terms.",
),

          Center(
            child: 
          TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpRoute()),
                      ),
                      child: const Text(
                      "Back",
                      style: TextStyle(
                      color: Color.fromRGBO(255, 131, 81, 1),
                      )),
                      )
          ),                   
      ],   
    ),
        ]
      ),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      
      
      body: ListView(
        padding: const EdgeInsets.all(56.0),
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              
           const SizedBox(height: 250),

        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45, 
            child: Image.asset(
              "assets/imagenes/MatchUp.png",
            ),
          ),
        ),
            ],
          ),


                    Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: const LinearGradient(
                stops: [0.01, 0.99],
                colors: [
                  Color.fromARGB(255, 0, 195, 0),
                  Color.fromARGB(255, 0, 195, 0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Recomendados()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/imagenes/Kronii.png', height: 40),
                  const Text(
                    'Películas Para Ti',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        
                const SizedBox(height: 20),

             

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: const LinearGradient(
                stops: [0.01, 0.99],
                colors: [
                  Color.fromRGBO(255, 0, 0, 1),
                  Color.fromRGBO(255, 0, 0, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PantallaBusqueda()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
              ),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/imagenes/cut.png',
                    height: 40,
                  ),
                                  const Text(
                    'Buscar y Agregar una Nueva',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                                  const Text(
                    'Pelicula',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),                  
  
                                   
                ],
                
              ),
              
              
            ),
          ),
          
          const SizedBox(height: 20),


          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: const LinearGradient(
                stops: [0.01, 0.99],
                colors: [
                  Color.fromARGB(255, 255, 194, 64),
                  Color.fromARGB(255, 255, 194, 64)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pelisvitas()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                foregroundColor: Colors.transparent,
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/imagenes/lista.png', height: 40),
                  const Text(
                    'Peliculas Vistas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: const LinearGradient(
                stops: [0.01, 0.99],
                colors: [
                  Color.fromARGB(255, 105, 129, 194),
                  Color.fromARGB(255, 105, 129, 194)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PelisQuieroVer()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/imagenes/lista.png', height: 40),
                  const Text(
                    'Peliculas Que Quiero Ver',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(
          height: 20.0, 
        ),
          
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                        MaterialPageRoute(builder: (_) => LogInRoute()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                backgroundColor: const                   Color.fromARGB(255, 169, 160, 156),


              ),
              child: const Column(
                children: <Widget>[

                                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
  
                                   
                ],
                
              ),
              
              
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String text;

  CustomTextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: GoogleFonts.asap(
          fontSize: 18,
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

