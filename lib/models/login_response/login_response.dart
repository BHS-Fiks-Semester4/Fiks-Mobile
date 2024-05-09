import 'dart:convert';

import 'user.dart';

class LoginResponse {
	String? status;
	User? user;
	String? message;

	LoginResponse({this.status, this.user, this.message});

	factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
				status: data['status'] as String?,
				user: data['user'] == null
						? null
						: User.fromMap(data['user'] as Map<String, dynamic>),
				message: data['message'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'status': status,
				'user': user?.toMap(),
				'message': message,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
	factory LoginResponse.fromJson(String data) {
		return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
	String toJson() => json.encode(toMap());
}
