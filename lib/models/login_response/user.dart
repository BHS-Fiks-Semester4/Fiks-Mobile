import 'dart:convert';

class User {
	int? id;
	String? name;
	String? email;
	String? alamat;
	String? username;
	String? noHp;
	String? agama;
	String? tanggalLahir;

	User({
		this.id, 
		this.name, 
		this.email, 
		this.alamat, 
		this.username, 
		this.noHp, 
		this.agama, 
		this.tanggalLahir, 
	});

	factory User.fromMap(Map<String, dynamic> data) => User(
				id: data['id'] as int?,
				name: data['name'] as String?,
				email: data['email'] as String?,
				alamat: data['alamat'] as String?,
				username: data['username'] as String?,
				noHp: data['no_hp'] as String?,
				agama: data['agama'] as String?,
				tanggalLahir: data['tanggal_lahir'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'name': name,
				'email': email,
				'alamat': alamat,
				'username': username,
				'no_hp': noHp,
				'agama': agama,
				'tanggal_lahir': tanggalLahir,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
	factory User.fromJson(String data) {
		return User.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
	String toJson() => json.encode(toMap());


  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, alamat: $alamat, username: $username, noHp: $noHp, agama: $agama, tanggalLahir: $tanggalLahir}';
  }
}
