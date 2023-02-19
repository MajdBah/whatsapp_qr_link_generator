import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp QR & link generator',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
      localizationsDelegates: const [
        flc.CountryLocalizations.delegate,
      ],
      home: const MyHomePage(title: 'Whatsapp QR & link generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController qrController = TextEditingController();
  String qr = "962782773939";

  List<Color> list = [
    Colors.black,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.brown,
    Colors.indigoAccent,
  ];

  Color qrColor = Colors.black;
  int _selectedColor = 0;
  String _error = "";
  var _countryCode;
  var _countryImage;
  final countryPicker = const FlCountryCodePicker(
    filteredCountries: [
      'AF',
      'AX',
      'AL',
      'DZ',
      'AS',
      'AD',
      'AO',
      'AI',
      'AQ',
      'AG',
      'AR',
      'AM',
      'AW',
      'AU',
      'AT',
      'AZ',
      'BS',
      'BH',
      'BD',
      'BB',
      'BY',
      'BE',
      'BZ',
      'BJ',
      'BM',
      'BT',
      'BO',
      'BQ',
      'BA',
      'BW',
      'BV',
      'BR',
      'IO',
      'BN',
      'BG',
      'BF',
      'BI',
      'KH',
      'CM',
      'CA',
      'CV',
      'KY',
      'CF',
      'TD',
      'CL',
      'CN',
      'CX',
      'CC',
      'CO',
      'KM',
      'CG',
      'CD',
      'CK',
      'CR',
      'CI',
      'HR',
      'CU',
      'CW',
      'CY',
      'CZ',
      'DK',
      'DJ',
      'DM',
      'DO',
      'EC',
      'EG',
      'SV',
      'GQ',
      'ER',
      'EE',
      'ET',
      'FK',
      'FO',
      'FJ',
      'FI',
      'FR',
      'GF',
      'PF',
      'TF',
      'GA',
      'GM',
      'GE',
      'DE',
      'GH',
      'GI',
      'GR',
      'GL',
      'GD',
      'GP',
      'GU',
      'GT',
      'GG',
      'GN',
      'GW',
      'GY',
      'HT',
      'HM',
      'VA',
      'HN',
      'HK',
      'HU',
      'IS',
      'IN',
      'ID',
      'IR',
      'IQ',
      'IE',
      'IM',
      'IT',
      'JM',
      'JP',
      'JE',
      'JO',
      'KZ',
      'KE',
      'KI',
      'KP',
      'KR',
      'XK',
      'KW',
      'KG',
      'LA',
      'LV',
      'LB',
      'LS',
      'LR',
      'LY',
      'LI',
      'LT',
      'LU',
      'MO',
      'MK',
      'MG',
      'MW',
      'MY',
      'MV',
      'ML',
      'MT',
      'MH',
      'MQ',
      'MR',
      'MU',
      'YT',
      'MX',
      'FM',
      'MD',
      'MC',
      'MN',
      'ME',
      'MS',
      'MA',
      'MZ',
      'MM',
      'NA',
      'NR',
      'NP',
      'NL',
      'AN',
      'NC',
      'NZ',
      'NI',
      'NE',
      'NG',
      'NU',
      'NF',
      'MP',
      'NO',
      'OM',
      'PK',
      'PW',
      'PS',
      'PA',
      'PG',
      'PY',
      'PE',
      'PH',
      'PN',
      'PL',
      'PT',
      'PR',
      'QA',
      'RS',
      'RE',
      'RO',
      'RU',
      'RW',
      'BL',
      'SH',
      'KN',
      'LC',
      'MF',
      'PM',
      'VC',
      'WS',
      'SM',
      'ST',
      'SA',
      'SN',
      'CS',
      'SC',
      'SL',
      'SG',
      'SX',
      'SK',
      'SI',
      'SB',
      'SO',
      'ZA',
      'GS',
      'SS',
      'ES',
      'LK',
      'SD',
      'SR',
      'SJ',
      'SZ',
      'SE',
      'CH',
      'SY',
      'TW',
      'TJ',
      'TZ',
      'TH',
      'TL',
      'TG',
      'TK',
      'TO',
      'TT',
      'TN',
      'TR',
      'XT',
      'TM',
      'TC',
      'TV',
      'UG',
      'UA',
      'AE',
      'GB',
      'US',
      'UM',
      'UY',
      'UZ',
      'VU',
      'VE',
      'VN',
      'VG',
      'VI',
      'WF',
      'EH',
      'YE',
      'ZM',
      'ZW',
    ],
    favorites: [
      'PS',
      'JO',
    ],
    showFavoritesIcon: true,
  );

  _launchURL() async {
    var url = 'https://api.whatsapp.com/send?phone=${qr.trim()}';

    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: qrColor,
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          color: _selectedColor == 0 ? Colors.white : Colors.black,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    // Show the country code picker when tapped.
                    final code =
                        await countryPicker.showPicker(context: context);
                    // Null check
                    if (code != null) {
                      setState(() {
                        _countryCode = code.dialCode.split("+").last;
                        _countryImage = code.flagImage(
                          width: 32,
                          fit: BoxFit.contain,
                        );
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: qrColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: const Text('Pick a Country',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _countryImage ?? Container(),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      _countryCode == null
                          ? "You must pick a country first!"
                          : "+$_countryCode",
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    enabled: _countryCode == null ? false : true,
                    decoration: const InputDecoration(
                        label: Text("Phone Number"),
                        helperText: "Enter phone number without country code",
                        prefixIcon: Icon(
                          Icons.phone,
                        )),
                    controller: qrController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _error = "Please Enter phone number";
                          qr = "962782773939";
                        });
                      }
                      if (_countryCode == null) {
                        setState(() {
                          _error = "Please Pick a country";
                        });
                      } else {
                        setState(() {
                          _error = "";
                        });
                      }

                      if (RegExp(r'^[0-9]+$').hasMatch(value)) {
                        setState(() {
                          qr = _countryCode + value;
                          _error = "";
                        });
                      } else {
                        setState(() {
                          _error = "Enter Valid phone number";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                qrColor = list[index];
                                _selectedColor = index;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: index == _selectedColor
                                    ? Colors.deepOrangeAccent
                                    : Colors.transparent,
                              ),
                              child: Icon(
                                Icons.circle_sharp,
                                weight: 25,
                                color: list[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: PrettyQr(
                    typeNumber: 4,
                    size: 200,
                    elementColor: qrColor,
                    image: const AssetImage("assets/whats.png"),
                    data: "https://api.whatsapp.com/send?phone=${qr.trim()}",
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                            text:
                                "https://api.whatsapp.com/send?phone=${qr.trim()}",
                          ));
                          const snackBar = SnackBar(
                            content: Text('Link Copied Successfully!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text(
                          "Copy link",
                          style: TextStyle(
                            color: qrColor,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () async {
                          await _launchURL();
                        },
                        child: Text(
                          "Chat Now",
                          style: TextStyle(
                            color: qrColor,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
