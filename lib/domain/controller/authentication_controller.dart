import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController extends GetxController {
  //Crea el futuro para iniciar sesion, deben recibirse como params el email y contraseña

  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: theEmail, password: thePassword);

      print('OK');
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('NOK 1');
        return Future.error("User not found");
      } else if (e.code == 'wrong-password') {
        print('NOK 2');
        return Future.error("Wrong password");
      }
    }
    print('NOK');
  }
  /*
  Future<void> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
        print("Esta todo OK");
        return Future.value(true);
      } else {
        if (e.code == "user-not-found") {
          print("Error de logueo");
          return Future.error("usuario no encontrado");
        } else {
          if (e.code == "wrong-password") {
            print("Error en el password");
            return Future.error("Wrong password");
          }
        }
      }
      print("error");
    }
  }
 **/

  //Crea el futuro para el registro de nuevos usuarios, deben recibirse como params el email y contraseña

  Future<void> signUp(theemail, thepassword) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: theemail, password: thepassword);
      print("El usuario se ha creado correctamente");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error("contraseña con cumple con requerimietos");
      } else {
        if (e.code == "email-already-in-use") {
          return Future.error("La cuenta de correo se encuentra en uso");
        }
      }
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }
}
