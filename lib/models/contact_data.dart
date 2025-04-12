class ContactData 
{
  final Map<String, String> data;
  
  ContactData({required this.data});
  
  factory ContactData.fromJson(Map<String, dynamic> json) 
  {
    Map<String, String> data = {};
    json.forEach((key, value) {
      data[key] = value.toString();
    });
    return ContactData(data: data);
  }
  
  String toJson() 
  {
    return "{${data.entries.map((e) => '"${e.key}":"${e.value}"').join(',')}}";
  }
}