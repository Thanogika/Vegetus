class Farmer {
  final String UserId;
  final String Name;
   final String userType;
  final String Email;
  final String location;
  final String phone;

  Farmer(
      {this.UserId,
      this.userType,
      this.Name,
      
      this.Email,
      this.phone,
      this.location});
  Map<String, dynamic> toMap() {
    return {
      'Email': Email,
      'Name': Name,
      'UserId': UserId,
      'location': location,
      'phone': phone,
      'userType': userType
      
      
      
    };
  }

  Farmer.fromFirestore(Map<String, dynamic> firestore)
      : UserId = firestore['UserId'],
        Name = firestore['Name'],
        userType=firestore['userType'],
        location = firestore['location'],
        phone = firestore['phone'],
        Email = firestore['Email'];
}
