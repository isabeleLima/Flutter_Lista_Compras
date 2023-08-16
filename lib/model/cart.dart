class Cart {
  String? id;
  String? text;
  String? amount = '1';
  bool isDone;

  Cart({
    required this.id,
    required this.text,
    this.amount,
    this.isDone = false,
  });

  static List<Cart> itemList() {
    return [
      Cart(id: '01', text: 'Arroz', amount: '1'),
      Cart(id: '02', text: 'Feijão', amount: '2'),
      Cart(id: '03', text: 'Batatas', amount: '1Kg'),
    ];
  }
}