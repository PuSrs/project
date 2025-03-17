import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/common_widget/toast.dart';

class FirebaseAuthSevices {
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e){

      if (e.code == 'email-already-in-use'){
        showtoast(message: 'The email address is already in use.');
      } else{
        showtoast(message: 'Ah error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signinWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;

    } on FirebaseAuthException catch (e){

      if (e.code == 'user-not-found' || e.code == 'wrong-password'){
        showtoast(message: 'Invalid email or password');
      } else{
        showtoast(message: 'Ah error occurred: ${e.code}');
      }
    }
    return null;

  }
}