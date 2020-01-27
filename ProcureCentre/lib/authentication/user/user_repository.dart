import 'dart:async';
import 'package:ProcureCentre/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';


class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  fs.Firestore store = fb.firestore();


  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password, String displayName}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> setDisplayName({String displayName}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = displayName;
    user.updateProfile(updateInfo);
    user.reload();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    print(user.email);
    fs.DocumentSnapshot ref = await findUser(user.email.toString());
    print(user.email);

    //fs.DocumentReference ref = store.collection('companies').doc('TestCompany3').collection('users').doc('sjhbNeLim5dDwN3Ebqmd');
    //final fs.DocumentSnapshot currentDocument = await ref.get();
    return User.fromFirestore(ref);

  }

  void createUser(String userName, String email, String company) async {
  await store.collection('companies').doc(company).collection('users').add(
    {
      'Company' : company,
      'Username' : userName,
      'Email' : email
    });
}



//  Future<fs.DocumentReference> getUserRef(String userEmail) async {
//    String id;
//    String company;
//    List<String> companies = await companyList();

//   for (var i = 0; i < companies.length; i++) {
//           print(companies[i]);
//           fs.CollectionReference users = store.collection('companies').doc(companies[i]).collection('users');
//           fs.QuerySnapshot user = await users.limit(1).where("Email", '==', userEmail).get();
          
//           }
//             fs.DocumentReference ref = store.collection('companies').doc(company.toString()).collection('users').doc(id.toString());
//   return ref;
//         }

    Future<fs.DocumentReference> getUserRef (String userEmail) async {
    String comp;
    String id;
    List<String> companies = await companyList();
        for (var i = 0; i < companies.length; i++) {
          store.collection('companies').doc(companies[i]).collection('users').get().
          then((val) {
            val.forEach((user){
              if(user.data()['Email'] == userEmail) {
                comp = user.data()['company'];
                id = user.id;
              }
            });
         
          });
        }

      fs.DocumentReference ref = store.collection('companies').doc(comp).collection('users').doc(id);

    return ref;
  }

  Future<fs.DocumentSnapshot> findUser (String userEmail)async {
    var query = store.collectionGroup("users").where("Email", "==", userEmail);
    var querySnapshot = await  query.get();
    fs.DocumentSnapshot userDocumentRef = querySnapshot.docs[0];
    print(userDocumentRef.id);
    return userDocumentRef;
  }



  Future<List<String>> companyList() async {

   List<String> companies = [];

   await store
    .collection('companies')
    .get()
    .then((fs.QuerySnapshot snapshot) {
      snapshot.forEach((callback){
        companies.add(callback.id);
      });
    });

    return companies;
 }
}



