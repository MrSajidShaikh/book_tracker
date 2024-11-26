class BookModal {
  // Book Title, Author, Status
  String? id;

  String Title;
  String Author;
  String Status;

  BookModal(
      {this.id,

      required this.Title,
      required this.Author,
      required this.Status});

  Map<String, Object> toMap() {
    return {

      'Title': Title,
      'Author': Author,
      'Status': Status,
    };
  }

  factory BookModal.fromMap(Map m1) {
    return BookModal(
        Title: m1['Title'],
        Author: m1['Author'],
        Status: m1['Status']);
  }
}
