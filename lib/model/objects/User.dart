class User {
  //int id;
  String firstName;
  String lastName;
  String telephoneNumber;
  String email;
  String address;
  String username;

  User(
      {this.firstName,
      this.lastName,
      this.telephoneNumber,
      this.email,
      this.address,
      this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['nome'],
        lastName: json['cognome'],
        telephoneNumber: json['telefono'],
        email: json['email'],
        address: json['indirizzo'],
        username: json['username']);
  }

  Map<String, dynamic> toJson() => {
        'nome': firstName,
        'cognome': lastName,
        'telefono': telephoneNumber,
        'email': email,
        'indirizzo': address,
        'username': username
      };

  @override
  String toString() {
    return firstName + " " + lastName;
  }
}
