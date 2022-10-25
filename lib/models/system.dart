class System{
  late String pod;

  System({required this.pod});

  System.fromMap(Map<String, dynamic> map){
    this.pod = map['pod'];
  }

  Map<String, dynamic> toMap(){
    return {
      'pod': this.pod,
    };
    }
}