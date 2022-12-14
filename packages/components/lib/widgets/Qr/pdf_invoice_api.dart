import 'dart:io';
import 'dart:ui';
import 'package:barcode/barcode.dart';
import 'package:components/components.dart';
import 'package:components/util/util.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:remote_data/remote_data.dart';

import 'uniq_id.dart';

class PdfInvoiceApi {
  static Future<File> generate(Orders order) async {
    String totalQuantity(List<Variants> variants) {
      int quantity = 0;
      for (var variant in variants) {
        for (var subvariant in variant.subvariants!) {
          quantity += int.parse(subvariant.qty!);
        }
      }
      return quantity.toString();
    }

    String totalPrice(List<Variants> variants) {
      double price = 0;
      for (var variant in variants) {
        for (var subvariant in variant.subvariants!) {
          price += double.parse(subvariant.qty!);
        }
      }
      if (order.currency == '¥') {
        return price.toStringAsFixed(0);
      } else {
        return price.toString();
      }
    }

    final pdf = pw.Document();

    final iconImage =
        (await rootBundle.load(AppCIcon.logo)).buffer.asUint8List();

    /// Create the Barcode
    final rawSvg =
        Barcode.qrCode().toSvg('${order.sId}', width: 54, height: 54);

    DrawableRoot svgDrawableRoot = await svg.fromSvgString(rawSvg, 'null');
    Picture picture = svgDrawableRoot.toPicture();
    Image image = await picture.toImage(54, 54);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    var filename = byteData!.buffer.asUint8List();

    final tableHeaders = [
      'No',
      'Description',
      // 'Unit Price',
      'Quantity',
      'Total',
    ];

    final tableData = [
      for (int i = 0; i < order.items!.length; i++)
        [
          '${i + 1}',
          order.items![i].name!,
          totalQuantity(order.items![i].variants!),
          '${order.currency!} ${totalPrice(order.items![i].variants!)}',
        ]
    ];

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Column(children: [
            pw.Row(
              children: [
                pw.Image(pw.MemoryImage(iconImage), width: 12.w, height: 12.w),
                pw.SizedBox(width: 2.w),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Store Name',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Flutter Approach',
                      style: pw.TextStyle(
                        fontSize: 8.sp,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 5.w),
          ]);
        },
        build: (context) {
          return [
            pw.SizedBox(height: 1.h),
            pw.Row(
              children: [
                pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      height: 5.w,
                      color: PdfColors.yellow,
                    )),
                pw.SizedBox(width: 2.w),
                pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 12.sp,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 2.w),
                pw.Expanded(
                    child: pw.Container(
                  height: 5.w,
                  color: PdfColors.yellow,
                )),
              ],
            ),
            pw.SizedBox(height: 1.h),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Invoice To:',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 0.5.h),
                    pw.Text(
                      order.customer!.name!,
                      style: pw.TextStyle(
                        fontSize: 10.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(
                      width: 35.w,
                      child: pw.Text(
                        '${order.customer!.address!.streetAddress!} ${order.customer!.address!.city}\n${order.customer!.address!.postalCode}',
                        style: pw.TextStyle(fontSize: 10.sp),
                      ),
                    ),
                  ],
                ),
                pw.Expanded(
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Column(
                        mainAxisSize: pw.MainAxisSize.min,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Invoice:',
                            style: pw.TextStyle(
                              fontSize: 10.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 1.w),
                          pw.Text(
                            'Date:',
                            style: pw.TextStyle(
                              fontSize: 10.sp,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(width: 2.w),
                      pw.Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: pw.MainAxisSize.min,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            GUIDGen.generate(),
                            style: pw.TextStyle(fontSize: 10.sp),
                          ),
                          pw.SizedBox(height: 1.w),
                          pw.Text(
                            Utils.formatDate(DateTime.now()),
                            style: pw.TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1.h),
            pw.Divider(),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Table.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey200),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.center,
                // 4: pw.Alignment.centerRight,
              },
            ),
            // pw.Divider(),
            pw.Row(
              children: [
                pw.Spacer(),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 1.h),
                      pw.Container(height: 1, color: PdfColors.grey),
                      pw.SizedBox(height: 1.h),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Column(
                            mainAxisSize: pw.MainAxisSize.min,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Sub Total:',
                                style: pw.TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 2.w),
                              pw.Text(
                                'Tax:',
                                style: pw.TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(width: 8.w),
                          pw.Column(
                            mainAxisSize: pw.MainAxisSize.min,
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Row(
                                // mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    order.currency!,
                                    style: pw.TextStyle(fontSize: 9.sp),
                                  ),
                                  pw.SizedBox(width: 1.w),
                                  pw.Text(
                                    order.total!,
                                    style: pw.TextStyle(fontSize: 10.sp),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 2.w),
                              pw.Text(
                                '0.0%',
                                style: pw.TextStyle(fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 1.h),
                      pw.Container(height: 1, color: PdfColors.grey)
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 3.h),
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Text(
                    'Thank you for your purchase!',
                    style: pw.TextStyle(
                      fontSize: 10.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Container(
                  height: 8.w,
                  padding: pw.EdgeInsets.symmetric(horizontal: 2.w),
                  color: PdfColors.yellow,
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'Total:',
                        style: pw.TextStyle(
                          fontSize: 12.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 2.w),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              order.currency!,
                              style: pw.TextStyle(fontSize: 12.sp),
                            ),
                            pw.SizedBox(width: 1.w),
                            pw.Text(
                              order.total!,
                              style: pw.TextStyle(
                                fontSize: 13.sp,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 1.h),
            pw.Divider(),
            pw.Spacer(),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'Scan the QR code with your phone camera to provide feedback on your experience.',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 10.sp),
                  ),
                ),
                pw.SizedBox(width: 10.w),
                //
                //  buildBarcode(
                // Barcode.qrCode().toSvg('sudesh bandara'),
                // pw.Image(pw.Barcode.fromType(type)), billQrCode
                // )
                // TODO
                // pw.Image(pw.MemoryImage(iconQr), width: 15.w, height: 15.w),
                pw.Image(pw.MemoryImage(filename), width: 15.w, height: 15.w),
              ],
            ),
            pw.SizedBox(height: 1.h),
            // pw.Divider(),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text(
                    '+9430298952',
                    style: pw.TextStyle(fontSize: 10.sp),
                  ),
                  pw.Text(
                    'ShopEmail@gmail.com',
                    style: pw.TextStyle(fontSize: 10.sp),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(
        name: 'invoice-${GUIDGen.generate()}.pdf', pdf: pdf);
  }
}
