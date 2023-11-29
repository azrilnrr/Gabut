import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_trial/model/invoice.dart';
import 'package:pdf_trial/product_inv_card.dart';

class Controller {
  static void createPdf() async {
    final pdf = Document();

    var dataImage = await rootBundle.load("assets/logo.png");
    var myImage = dataImage.buffer.asUint8List();

    List<InvoiceItem> listItem = [
      const InvoiceItem(
          name: 'EG Premium Single', quantity: '3', unitPrice: '50000'),
      const InvoiceItem(
          name: 'EG Fantastico Single', quantity: '5', unitPrice: '65000'),
      const InvoiceItem(
          name: 'AL Grand Corona', quantity: '1', unitPrice: '30000'),
      const InvoiceItem(
          name: 'Lauk Daun Single', quantity: '10', unitPrice: '75000'),
      const InvoiceItem(
          name: 'BR Half Corona', quantity: '3', unitPrice: '25000'),
    ];

    int total = 0;
    for (var item in listItem) {
      total += (int.parse(item.quantity) * int.parse(item.unitPrice));
    }

    pdf.addPage(
      Page(
          pageFormat: PdfPageFormat.roll80,
          build: (Context context) {
            return Center(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      MemoryImage(myImage),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Besuki Raya Cigar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Jl. Hayam Wuruk No.139, Krajan, Sempusari, Kec. Kaliwates, Kabupaten Jember, Jawa Timur 68131',
                    style: const TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      direction: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (Context context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.8),
                          child: Container(
                            height: 0.8,
                            width: 5,
                            color: PdfColors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("18-11-2023", style: const TextStyle(fontSize: 8)),
                      Text('Via Vallen', style: const TextStyle(fontSize: 8)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("18:11:24", style: const TextStyle(fontSize: 8)),
                      Text('Nella Kharisma',
                          style: const TextStyle(fontSize: 8)),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      direction: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (Context context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.8),
                          child: Container(
                            height: 0.8,
                            width: 5,
                            color: PdfColors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    itemCount: listItem.length,
                    itemBuilder: (Context context, int index) {
                      return ProductInvCard(
                          item: listItem[index], index: index);
                    },
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      direction: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (Context context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.8),
                          child: Container(
                            height: 0.8,
                            width: 5,
                            color: PdfColors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$total',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Charge (Cash)',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        '1400000',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Return',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        '670000',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Thankyou for your bussiness',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }),
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final file = File('$tempPath/example.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);
  }
}
