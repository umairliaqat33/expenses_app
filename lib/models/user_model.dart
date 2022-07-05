class UserModel {
  String? uid;
  String? Fname;
  String? Lname;
  String? email;

  //receiving data from firebase
  UserModel({this.uid, this.Fname, this.Lname, this.email});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        Fname: map['Fname'],
        Lname: map['Lname'],
        email: map['email']);
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'Uid': uid,
      'email': email,
      'firstname': Fname,
      'lastname': Lname,
    };
  }
}
