class TransactionModel {
  final int nominal;
  final String note;
  final String category;
  final bool isIncome;
  final DateTime date;

  TransactionModel({
    required this.nominal,
    required this.note,
    required this.category,
    required this.isIncome,
    required this.date,
  });

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'nominal': nominal,
      'note': note,
      'category': category,
      'isIncome': isIncome,
      'date': date.toIso8601String(),
    };
  }

  // Create object from Map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      nominal: map['nominal'] ?? 0,
      note: map['note'] ?? '',
      category: map['category'] ?? '',
      isIncome: map['isIncome'] ?? true,
      date: DateTime.parse(map['date']),
    );
  }
}
