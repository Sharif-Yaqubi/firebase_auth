import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String name;
  final String uid;
  final String image;
  final String email;
  final String? youtube;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  const Person({
    required this.name,
    required this.uid,
    required this.image,
    required this.email,
    this.youtube,
    this.facebook,
    this.twitter,
    this.instagram,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'image': image,
      'email': email,
      'youtube': youtube,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
    };
  }

  factory Person.fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Person(
      name: data['name'],
      uid: data['uid'],
      image: data['image'],
      email: data['email'],
      youtube: data['youtube'],
      facebook: data['facebook'],
      twitter: data['twitter'],
      instagram: data['instagram'],
    );
  }
}
