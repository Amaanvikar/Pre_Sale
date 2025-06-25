class Enquiry {
  final int id;
  final String title;
  final String category;

  Enquiry({required this.id, required this.title, required this.category});

  // Convert a Enquiry into a Map. The keys must correspond to the names of the columns.
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'category': category};
  }

  // A method that retrieves a Enquiry object from a Map.
  factory Enquiry.fromMap(Map<String, dynamic> map) {
    return Enquiry(
      id: map['id'],
      title: map['title'],
      category: map['category'],
    );
  }
}
