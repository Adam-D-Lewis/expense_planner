// don't need to inherit from STatelessWidget or StatefulWidget b/c we don't want to render this.  It's just a template for an object.
class Transaction {
  late final String id;
  late final String title;
  late final double amount;
  late final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
