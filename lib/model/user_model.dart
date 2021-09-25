
class UserModel{
  String name ;
  int age;
  UserModel({this.name,this.age});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'age': this.age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }


}