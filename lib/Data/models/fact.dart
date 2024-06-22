class Fact{
  String id;
  String text;

  Fact({required this.id, required this.text});

  //Les données venant du JSON
  factory Fact.fromJson(Map<String,dynamic> json) => Fact(
    id: json['id'] as String,
    text: json['text'] as String
  );

  //Conversion en JSON
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> json=<String,dynamic>{};
    json['id']=id;
    json['text']=text;

    return json;
  }
}