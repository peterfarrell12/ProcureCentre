import 'package:firebase/firestore.dart' as fs;

class User {
  String documentId;
  String username;
  String company;
  String email;

  User({this.documentId,this.username, this.company, this.email});

  factory User.fromFirestore(fs.DocumentSnapshot doc) {
    Map data = doc.data();
    return User(
      documentId: doc.id,
      username: data['Username'],
      company: data['Company'],
      email: data['Email']
    );
  }
  @override
  String toString() {
   return '{ documentId: $documentId, username: $username, company: $company, email: $email}';
  }
}
