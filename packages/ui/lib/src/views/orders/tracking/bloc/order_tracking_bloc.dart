import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:data/orders/models/order.dart';
import 'package:data/orders/models/order_product.dart';
import 'package:data/orders/repository/order_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:data/utils/double_ext.dart';

part 'order_tracking_event.dart';
part 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  final OrderRepository _repository;
  OrderTrackingBloc(this._repository) : super(OrderTrackingLoading()) {
    on<OrderLoaded>((event, emit) async {
      final stream = _repository.streamOrderById(event.id);
      await emit.forEach(
        stream,
        onData: (data) {
          return data.fold((l) {
            return CurrentOrderTrackingError(l);
          }, (r) {
            return CurrentOrderTracking(r);
          });
        },
      );
    });

    on<OrderStatusUpdated>((event, emit) {
      _repository.saveStatusChanges(event.updated).then((value) {
        value.fold((left) {
          emit(CurrentOrderTrackingError(left));
        }, (right) => null);
      });
      emit(CurrentOrderTracking(event.updated));
    });

    on<OrderInvoiceGenerated>((event, emit) async {
      final logo =
          await _getBytesFromAssetImage('assets/images/logo.png', 60, 25);
      final bytes = await _generatePDF(event.order, logo);
      final file = await _saveFileInFolder(
          '${event.order.id}_invoice.pdf', bytes, 'EESUp');
      print(file);
    });
  }

  Future<Uint8List> _getBytesFromAssetImage(
      String assetPath, int width, int height) async {
    ByteData data = await rootBundle.load(assetPath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Either<EESUpException, File>> _saveFileInFolder(
    String fileName,
    List<int> fileBytes,
    String folderName,
  ) async {
    // Get the appropriate directory
    Directory? directory;

    if (Platform.isAndroid) {
      directory =
          await getExternalStorageDirectory(); // Use external storage on Android
    } else if (Platform.isIOS) {
      directory =
          await getApplicationDocumentsDirectory(); // Use app documents on iOS
    } else {
      return Left(EESUpException(message: 'Operation unsupported'));
    }

    if (directory != null) {
      // Create the folder if it doesn't exist
      final folderPath = '${directory.path}/$folderName';
      await Directory(folderPath).create(recursive: true);

      // Create and write to the file
      final filePath = '$folderPath/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);

      return Right(file);
    } else {
      return Left(EESUpException(message: 'Could not save the file'));
    }
  }

  Future<List<int>> _generatePDF(Order order, List<int> logo) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(48, 142, 88)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid(order);
    //Draw the header section by creating text element
    final PdfLayoutResult result =
        _drawHeader(page, pageSize, grid, order, logo);
    //Draw grid
    _drawGrid(page, grid, result, order);
    //Add invoice footer
    //_drawFooter(page, pageSize);
    //Save and dispose the document.
    final List<int> bytes = await document.save();
    document.dispose();

    return bytes;
  }

//Draws the invoice header
  PdfLayoutResult _drawHeader(
    PdfPage page,
    Size pageSize,
    PdfGrid grid,
    Order order,
    List<int> logo,
  ) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(48, 142, 88)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string

    page.graphics.drawImage(
      PdfBitmap(logo),
      const Rect.fromLTWH(5, 0, 100, 90),
    );

    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(5, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(48, 142, 88)));

    page.graphics.drawString('R${order.value.toRounded()}',
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Order Id: ${order.id} \r\n\r\nDate: ${format.format(order.createdAt ?? DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // const String address =
    //     'Bill To: \r\n\r\nAbraham Swearegin, \r\n\r\nUnited States, California, San Mateo, \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136';
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120),
    );

    return PdfTextElement(
            text: 'Bill To: ${order.fullName ?? order.corpName ?? ''}',
            font: contentFont)
        .draw(
      page: page,
      bounds: Rect.fromLTWH(5, 120, pageSize.width - (contentSize.width + 30),
          pageSize.height - 120),
    )!;
  }

//Draws the grid
  void _drawGrid(
    PdfPage page,
    PdfGrid grid,
    PdfLayoutResult result,
    Order order,
  ) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
    page.graphics.drawString('Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString('R${order.value.toRounded()}',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
  }

//Create PDF grid and return
  PdfGrid _getGrid(Order order) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(48, 142, 88));
    headerRow.style.textBrush = PdfBrushes.white;

    headerRow.cells[0].value = '';
    headerRow.cells[1].value = 'Price';
    headerRow.cells[2].value = 'Quantity';
    headerRow.cells[3].value = 'Total';

    for (final p in order.products) {
      _addProducts(p, grid);
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[0].width = 250;

    //for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[0].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    // }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        // if (j == 0) {
        //   cell.stringFormat.alignment = PdfTextAlignment.center;
        // }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

//Create and row for the grid.
  void _addProducts(
    OrderProduct product,
    PdfGrid grid,
  ) {
    final PdfGridRow row = grid.rows.add();

    row.cells[0].value = product.name;
    row.cells[1].value = product.price.toString();
    row.cells[2].value = product.quantity.toString();
    row.cells[3].value = product.price.toString();
  }
}
