import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "flutter-gsheet-382116",
  "private_key_id": "81a58c3364df6d09292f928222ab7db5e93835bc",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGuJrSsWzZehHi\nMf4X+TefleCgvmJkAmIrF16rSRDzfUBQ1lI6IPXxFrc7goZ4HiRd7iwpw3eOL1UA\nx7jx6IPH2gQmd6yhNMF17/woZ9iJJls9kfmQ1sh11wtERhzYbSRDWRNPO8QlZove\nMmBwA+EhUacTi3QQPZDBjpBGElMXmUMR3eCDCAaQrX1PugW1KjHZC0vlFOofItao\n4OU53z2rE+bFU5E6pV6HTYLX4Eqq+7P6eABq+Vjan/R7NMq9NxeVCT31MFh+E9wq\ngT2JzlUgelB79yciYZnp2gjQjOOp3M3e7P44RAhTkShb6iiPm/YkYL6TAs8nAhP3\nhIzeffB7AgMBAAECggEAMRrb8zVxqtndwnHNEpp8UryD+eShxonKPVC0jYnsHOb1\n9iPHxOJxM8aDt7pcxSDZprZchmNtTx7GF//CZVCqA8ANZ34KE/nH1n9bZZanrNhk\nEnZYX6Cbf3cIqzHSHe72V4gS2/DuWrmY1WrIZtWmk4esTAmZQAwekZ3La+1KSBmg\n/3xkHsHS+l7REqxQsic5X1BashaDoccHQiJLbhT4DZG3cTjbdCIfz/jpPlOn5/oL\niWwl47+5LOlkjMlyWyIGs8gg3eJsy1lkgOdmXKYt8TFoixG5FM+/2RNpkdGpxHTz\nM6M9LhNM3D2xjDvYljq0so5HCrEQqe5FpFgxwY3JDQKBgQDxJFmox8f750cGnSXt\ndBoHtHa+SQfF98qlmNZ1lmTIKb6YDi8P37s2bHGStz0jpfiy/kBlNfSdlOBziSHP\nfZov5X5CEbb6PsfGydjTCDJJlIGnN7lmfihE2AkuhNvdYyu9EabboG9BsWEqDnFN\n1Ucx52E/20KkkADtvxEIKg0knwKBgQDS9yEf5hcch4b9OvZdwPk4GcGY8dhU6ImV\nKchx/O24Pss1xYfo+8ovqNdx9h2mzNTaR75/XPyfkSyQA/oAt3xP1rOblEGkiE+G\nJ2VAk0Ii99SfncG81tPX7fu2nyMr6aa1gJdRtBBzliAP+hhn3e8DPoIQ8NTAHcJo\nJzUdh/TqpQKBgFWy4HZeQdFheVl9YexItbOFTCoGFFAj5w4BCj6R61FDnKu3ZrxS\ne9s0oQxOONlBc+hQ+Zu+mCeksDv/QVfXQIPDIKLkXs4Cn8cjFv6wzAZgU8+UuzwU\nm8UTrfetWeINC49PBajKFKAZJPnoVhYeNQYkP+iMyNtpHhtgKvJm13LrAoGADx6p\nIBkkhOXttc55A8Ul13B5IJYMtCEqYydod0ryWqcdd1Ad6oPJPNsz/bXu8Bp0EuTb\ncVNfw6vq7rNqQozj+vDfVIIupjUixfGi3xruvYTXl0z+KqOW8T3cMX18TtRjH1UF\nA1UNbMtQpvR8tU0BqVDcj4xDIzW+ziopM2GgGwUCgYBuovlY/INFWr1EaMToAiD0\n8m0rLiNUM3Cc++BO2o7p1u5VwTZPvv4pbWbJzQJZlz/t/416U9nyrZBHLrznYFI6\ncTmHohcSRXLkKCqUeeImNC0W1rDRJKFZ7yboL+zuQZuqT7hHNubgxZX+Jqo6cn5s\nwRcIuxjl3X8EkMmx/NHN9w==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets@flutter-gsheet-382116.iam.gserviceaccount.com",
  "client_id": "111177202635138010081",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheet-382116.iam.gserviceaccount.com"
}

  ''';

  static final _spreadsheetId = '1e9AD9-3Iz3Toad5bEn3nvrOWtDH203Ejw7tnNpQMyQ8';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // static Future<Worksheet> _getWorkSheet(
  //   Spreadsheet spreadsheet, {
  //   required String title,
  // }) async {
  //  try{ return await spreadsheet.addWorksheet('Worksheet1');}
  //  catch(e){
  //   return spreadsheet.worksheetByTitle('Worksheet1');
  //  }

  // }

  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    loadTransactions();
  }

  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);
      final String transactionId =
          await _worksheet!.values.value(column: 4, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
          transactionId
        ]);
      }
    }
    // stop loading indicator
    loading = false;
  }

  static Future insert(
      String name, String amount, bool _isIncome, String xid) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions
        .add([name, amount, _isIncome == true ? 'income' : 'expense', xid]);
    await _worksheet!.values.appendRow(
        [name, amount, _isIncome == true ? 'income' : 'expense', xid]);
  }

  static Future<bool> delete(int id) async {
    if (_worksheet == null) return false;

    final index = await _worksheet!.values.rowIndexOf(id);
    if (index == -1) return false;

    return _worksheet!.deleteRow(index);
  }

  // Future deleteuser() async {
  //   final user = Worksheet1[index];
  // }

  static Future deleteRow(int id) async {
    _worksheet?.deleteRow(id);
  }

  // total INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // totla EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
