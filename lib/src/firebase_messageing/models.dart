import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String? uid;
  List<String>? tokens;
  UserModel({
    this.uid,
    this.tokens,
  });

  UserModel copyWith({
    String? uid,
    List<String>? tokens,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'tokens': tokens,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      tokens: List<String>.from(map['tokens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(uid: $uid, tokens: $tokens)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.uid == uid &&
      listEquals(other.tokens, tokens);
  }

  @override
  int get hashCode => uid.hashCode ^ tokens.hashCode;
}
