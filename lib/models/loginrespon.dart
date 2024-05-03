import 'dart:convert';

class Loginrespon {
	String? status;
	int? id;
	String? username;
	String? name;
	String? email;
	String? alamat;
	String? agama;
	String? tanggalLahir;
	String? noHp;
	String? message;

	Loginrespon({
		this.status, 
		this.id, 
		this.username, 
		this.name, 
		this.email, 
		this.alamat, 
		this.agama, 
		this.tanggalLahir, 
		this.noHp, 
		this.message, 
	});

	factory Loginrespon.fromMap(Map<String, dynamic> data) => Loginrespon(
				status: data['status'] as String?,
				id: data['id'] as int?,
				username: data['username'] as String?,
				name: data['name'] as String?,
				email: data['email'] as String?,
				alamat: data['alamat'] as String?,
				agama: data['agama'] as String?,
				tanggalLahir: data['tanggal_lahir'] as String?,
				noHp: data['no_hp'] as String?,
				message: data['message'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'status': status,
				'id': id,
				'username': username,
				'name': name,
				'email': email,
				'alamat': alamat,
				'agama': agama,
				'tanggal_lahir': tanggalLahir,
				'no_hp': noHp,
				'message': message,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Loginrespon].
	factory Loginrespon.fromJson(String data) {
		return Loginrespon.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Loginrespon] to a JSON string.
	String toJson() => json.encode(toMap());
}
