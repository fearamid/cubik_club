abstract class IQrCodeAble {
  String generateQr();
  String generateQrTitle();
}

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
