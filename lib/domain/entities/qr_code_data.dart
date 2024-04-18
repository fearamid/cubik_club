abstract interface class IQrCodeAble {
  String generateQr();
  String generateQrTitle();
}

// TODO: It's has native QrCode class in qr code generator class with creation from data. Maybe use it?

class QrCodeData {
  final String title;
  final String data;
  const QrCodeData({
    required this.data,
    required this.title,
  });

  static fromEntity<T extends IQrCodeAble>(T entity) {
    return QrCodeData(
        data: entity.generateQr(), title: entity.generateQrTitle());
  }
}
