import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class ScanBarcodePage extends BaseStatefulPage {
  const ScanBarcodePage({super.key});

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends BaseStatefulState<ScanBarcodePage> {
  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  Widget body() {
    return MobileScanner(
      onDetect: (result) {
        print(result.barcodes.first.rawValue);
      },
    );
  }
}
