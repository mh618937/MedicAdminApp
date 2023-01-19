import 'dart:io';

import 'package:medicadmin/data/models/admin_model.dart';
import 'package:medicadmin/data/models/mongo_user.dart';
import 'package:medicadmin/data/models/order_model.dart';
import 'package:medicadmin/services/adminprovider.dart';
import 'package:medicadmin/services/invoice_service/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../utils/utilities.dart';

class PdfInvoiceApi {
  PdfApi pdfApi = PdfApi();
  static Future<File> generate(OrderModel invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(adminModel!),
    ));

    return PdfApi.saveVideo(
        name:
            '${invoice.user!.name!}${(DateTime.parse(invoice.addedon!)).toString().substring(0, 10)}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(OrderModel invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(adminModel!),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.sId!,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.user!),
              buildInvoiceInfo(invoice),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(MongoUser customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("To", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address!),
        ],
      );

  static Widget buildInvoiceInfo(OrderModel order) {
    // final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Id:',
      'Order Date:',
    ];
    final data = <String>[
      adminModel!.medicalstorename!.substring(0, 6) +
          order.sId!.substring(0, 6),
      DateTime.parse(order.addedon!).toString().substring(0, 19)
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(AdminModel supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("From", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.storeaddress!),
        ],
      );

  static Widget buildTitle() {
    String invoicedescription =
        "${adminModel!.medicalstorename}" "\n ${adminModel!.storeaddress}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INVOICE',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Text(invoicedescription),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
      ],
    );
  }

  static Widget buildInvoice(OrderModel invoice) {
    final headers = ['Description', 'Qty', 'PPU(INR)', 'Total(INR)'];
    final data = invoice.items!.map((item) {
      final total = item.style!.price! * item.quantity!;

      return [
        item.product!.title! + item.style!.title!,
        '${item.quantity!}',
        (item.style!.price!.toStringAsFixed(2)),
        (total.toStringAsFixed(2)),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerRight,
      },
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(OrderModel invoice) {
    final total = invoice.totalordervalue!;

    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'total',
                  value: formatPrice(total.toDouble()),
                  unite: true,
                ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: formatPrice(total),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(AdminModel admin) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: admin.storeaddress!),
          SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
