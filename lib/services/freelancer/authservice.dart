

import 'package:devjobs_updated/models/freelancer/user_model.dart';
import 'package:devjobs_updated/services/freelancer/userservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../common/register/RegisterUser.dart';

class AuthService {
  String? ImageUrl;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> createUser(UserModel user) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: user.email.toString(), password: user.password.toString());


      if (_userCredential.user != null) {

        final ref=FirebaseStorage.instance.ref().child('userImages').child(_userCredential.user!.uid+".jpg");
        await ref.putFile(ProfileImage!);
        final _uid=_userCredential.user!.uid;
        ImageUrl =await ref.getDownloadURL();

        UserService().registerUser(user, _userCredential.user!.uid,ImageUrl);

        // FirebaseFirestore.instance.collection('users').doc(_uid).set({
        //   'id':_uid,
        //   'email':user.email,
        //   'userImage':ImageUrl,
        //   'skills':user.skills,
        //   'createdAt':Timestamp.now(),
        // });

      }

      print(_userCredential.user!.email);
      print(_userCredential.user!.uid);
      print(_userCredential.user!.getIdToken());

      return _userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  //login


 Future<UserModel?>loginUser(UserModel user)async{

    try{

      UserCredential _userCredential =await _auth.signInWithEmailAndPassword(email: user.email.toString(), password: user.password.toString());


      if(_userCredential.user!=null){

      var data= await UserService().fetchUserData(_userCredential.user!.uid);

      if(data!=null){

       user=UserModel.fromSnapShot(data);

      }



      }

    }on FirebaseAuthException catch (e) {
      print(e.toString());
    }

    return user;


 }





  //logout
}
