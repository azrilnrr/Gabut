import 'package:pdf/widgets.dart';
import 'package:pdf_trial/model/invoice.dart';

class ProductInvCard extends StatelessWidget {
  final int index;
  final InvoiceItem item;
  ProductInvCard({required this.item, required this.index});

  @override
  Widget build(Context context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${index + 1}. ',
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
              Text(
                item.name,
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${item.quantity} ',
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    'x ',
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    item.unitPrice,
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              Text(
                '${int.parse(item.unitPrice) * int.parse(item.quantity)}',
                style: TextStyle(fontSize: 8),
              ),
            ],
          )
        ],
      ),
    );
  }
}
