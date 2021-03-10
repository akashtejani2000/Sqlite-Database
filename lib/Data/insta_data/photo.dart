class Photo {
  int id;
  String photo_name;
  String user_name;

  Photo(this.id, this.photo_name, this.user_name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photo_name,
      'user_name': user_name,
    };
    print('map ======<> $map');
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photo_name = map['photo_name'];
    user_name = map['user_name'];
  }
}
