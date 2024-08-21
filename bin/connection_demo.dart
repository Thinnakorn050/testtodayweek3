// import 'package:connection_demo/connection_demo.dart' as connection_demo;

// void main(List<String> arguments) {
//   print('Hello world: ${connection_demo.calculate()}!');
// }

//------------Exercise 1: Get a remote JSON.-----------------//

// for json decode
// import 'dart:convert';
// // for http connection
// import 'package:http/http.dart' as http;
// void main() async {
//   // Observe async and await
//   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
//   final response = await http.get(url);
//   if (response.statusCode != 200) {
//     print('Connection failed');
//     return;
//   }
//   final jsonResult = json.decode(response.body) as Map;
//   print("Title: ${jsonResult['title']}");
//   print("Body: ${jsonResult['body']}");
// }

//------------------------------------------------------------------------//

// ------------Exercise 2: Get a remote JSON array.-------------//
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() async {
//   final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
//   final response = await http.get(url);
//   if (response.statusCode != 200) {
//     print('Connection failed');
//     return;
//   }
//   final jsonResult = json.decode(response.body) as List;
//   print(jsonResult[0]['name']);
//   print(jsonResult[0]['address']['city']);
// }

// // for json decode
// import 'dart:convert';
// // for http connection
// import 'package:http/http.dart' as http;
// void main() async {
//   final url = Uri.parse('http://localhost:3000/expenses');
//   final response = await http.get(url);
//   if (response.statusCode != 200) {
//     print('Failed to retrieve the http package!');
//     return;
//   }
//   // the body is JSON string
//   final jsonResult = json.decode(response.body) as List;

//   print("------------- All expenses ----------");
//   for (var exp in jsonResult) {
//     print("${exp['id']}. ${exp['item']} : ${exp['paid']}฿");
//   }
// }

//------------------------------------------------------------------------//

// https://api.dart.dev/stable/3.4.4/dart-core/DateTime-class.html

// for json decode
// import 'dart:convert';
// // for http connection
// import 'package:http/http.dart' as http;

// void main() async {
//   final url = Uri.parse('http://localhost:3000/expense');
//   final response = await http.get(url);
//   if (response.statusCode != 200) {
//     print('Failed to retrieve the http package!');
//     return;
//   }
//   // the body is JSON string
//   final jsonResult = json.decode(response.body) as List;

//   int total = 0;
//   print("------------- All expenses ----------");
//   for (var exp in jsonResult) {
//     // print(exp['id'].runtimeType);
//     // print(exp['item'].runtimeType);
//     // print(exp['paid'].runtimeType);
//     // print(exp['date'].runtimeType);

//     // get datetime and convert to local time zone
//     // cast by ‘as DateTime’ should also work
//     final dt = DateTime.parse(exp['date']);
//     final dtLocal = dt.toLocal();
//     // print('${dtLocal.day}/${dtLocal.month}/${dtLocal.year}');
//     // print('${dtLocal.hour}:${dtLocal.minute}');

//     print(
//         "${exp['id']}. ${exp['item']} : ${exp['paid']}฿ @ ${dtLocal.toString()}");
//     // exp['paid'] is considered type of 'num' in dart, need to cast to 'int'
//     total += exp['paid'] as int;
//   }
//   print("Total expenses = $total฿");
// }

//------------------------------------------------------------------------//
// for http connection
// import 'package:http/http.dart' as http;
// // for stdin
// import 'dart:io';

// void main() async {
//   print("===== Login =====");
//   // Get username and password
//   stdout.write("Username: ");
//   String? username = stdin.readLineSync()?.trim();
//   stdout.write("Password: ");
//   String? password = stdin.readLineSync()?.trim();
//   if (username == null || password == null) {
//     print("Incomplete input");
//     return;
//   }
//   final body = {"username": username, "password": password};
//   final url = Uri.parse('http://localhost:3000/login');
//   final response = await http.post(url, body: body);
//   // note: if body is Map, it is encoded by "application/x-www-form-urlencoded" not JSON
//   if (response.statusCode == 200) {
//     // the response.body is String
//     final result = response.body;
//     print(result);
//   } else if (response.statusCode == 401 || response.statusCode == 500) {
//     final result = response.body;
//     print(result);
//   } else {
//     print("Unknown error");
//   }
// }

//------------------------------------------------------------------------//

//ต้นฉบับ//
// // for http connection
// import 'package:http/http.dart' as http;
// // for stdin
// import 'dart:io';

// void main() async {
//   await login();
//   print("Good bye");
// }
// Future<void> login() async {
//   print("===== Login =====");
//   // Get username and password
//   stdout.write("Username: ");
//   String? username = stdin.readLineSync()?.trim();
//   stdout.write("Password: ");
//   String? password = stdin.readLineSync()?.trim();
//   if (username == null || password == null) {
//     print("Incomplete input");
//     return;
//   }

//   final body = {"username": username, "password": password};
//   final url = Uri.parse('http://localhost:3000/login');
//   final response = await http.post(url, body: body);
//   // note: if body is Map, it is encoded by "application/x-www-form-urlencoded" not JSON
//   if (response.statusCode == 200) {
//     // the response.body is String
//     final result = response.body;
//     print(result);
//   } else if (response.statusCode == 401 || response.statusCode == 500) {
//     final result = response.body;
//     print(result);
//   } else {
//     print("Unknown error");
//   }
// }
//------------------------------------------------------------------------//

// Assignment 1: From the previous database, create a registration app.

// for http connection
// import 'package:http/http.dart' as http;
// // for stdin
// import 'dart:io';

// void main() async {
//   await login();
//   print("Insert done");
// }
// Future<void> login() async {
//   print("===== Registration =====");
//   // Get username and password
//   stdout.write("Username: ");
//   String? username = stdin.readLineSync()?.trim();
//   stdout.write("Password: ");
//   String? password = stdin.readLineSync()?.trim();
//   if (username == null || password == null) {
//     print("Incomplete input");
//     return;
//   }

//   final body = {"username": username, "password": password};
//   final url = Uri.parse('http://localhost:3000/login');
//   final response = await http.post(url, body: body);
//   // note: if body is Map, it is encoded by "application/x-www-form-urlencoded" not JSON
//   if (response.statusCode == 200) {
//     // the response.body is String
//     final result = response.body;
//     print(result);
//   } else if (response.statusCode == 401 || response.statusCode == 500) {
//     final result = response.body;
//     print(result);
//   } else {
//     print("Unknown error");
//   }
// }

//------------------------------------------------------------------------//
// Create a Dart app to have a login and a menu to show expenses of the user. Observe that the menu is a loop.
import 'dart:io';

void main() async {
  if (await login()) {
    await showMenu();
  }
  print("Bye -----");
}

Future<bool> login() async {
  print("===== Login =====");
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();

  if (username == null || password == null) {
    print("Incomplete input");
    return false;
  }

  if (username == "Tom" && password == "2222") {
    return true;
  } else {
    print("Invalid credentials");
    return false;
  }
}

Future<void> showMenu() async {
  List<Expense> allExpenses = [
    Expense("lunch", 50, DateTime(2024, 8, 9, 13, 27, 33)),
    Expense("bun", 20, DateTime(2024, 8, 9, 21, 02, 36)),
  ];

  while (true) {
    print("========= Expense Tracking App =========");
    print("Wellcome tom");
    print("1. All expenses");
    print("2. Today's expense");
    print("3. Search expense");
    print("4. Add new expense");
    print("5. Delete an expense");
    print("6. Exit");
    stdout.write("Choose... ");

    String? choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case "1":
        showAllExpenses(allExpenses);
        break;
      case "2":
        showTodayExpenses(allExpenses);
        break;
      case "3":
        searchExpense(allExpenses);
        break;
      case "4":
        addNewExpense(allExpenses);
        break;
      case "5":
        deleteExpense(allExpenses);
        break;
      case "6":
        return;
      default:
        print("Invalid choice. Please try again.");
    }
  }
}

void showAllExpenses(List<Expense> expenses) {
  print("---------- All expenses ----------");
  int total = 0;
  for (var i = 0; i < expenses.length; i++) {
    print("${i + 1}. ${expenses[i]}");
    total += expenses[i].amount;
  }
  print("Total expenses = $total");
}

void showTodayExpenses(List<Expense> expenses) {
  print("---------- Today's expenses ----------");
  DateTime today = DateTime.now();
  List<Expense> todayExpenses = expenses
      .where((e) =>
          e.date.year == today.year &&
          e.date.month == today.month &&
          e.date.day == today.day)
      .toList();

  if (todayExpenses.isEmpty) {
    print("No expenses for today.");
    return;
  }

  int total = 0;
  for (var i = 0; i < todayExpenses.length; i++) {
    Expense e = todayExpenses[i];
    print(
        "${i + 1}. ${e.name} : ${e.amount}฿ - ${e.date.toString().substring(0, 19)}");
    total += e.amount;
  }
  print("Total expenses = $total");
}

void searchExpense(List<Expense> expenses) {
  stdout.write("Enter item name to search: ");
  String? keyword = stdin.readLineSync()?.trim();

  if (keyword == null || keyword.isEmpty) {
    print("Invalid input.");
    return;
  }

  List<Expense> searchResults = expenses
      .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
      .toList();

  if (searchResults.isEmpty) {
    print("No item  '$keyword'");
    return;
  }

  print("----- Search Results -----");
  for (var i = 0; i < searchResults.length; i++) {
    print("${i + 1}. ${searchResults[i]}");
  }
}

void addNewExpense(List<Expense> expenses) {
  stdout.write("Enter item name: ");
  String? name = stdin.readLineSync()?.trim();
  stdout.write("Enter amount: ");
  String? amountInput = stdin.readLineSync()?.trim();

  if (name == null || amountInput == null || name.isEmpty || amountInput.isEmpty) {
    print("Invalid input.");
    return;
  }

  int? amount = int.tryParse(amountInput);
  if (amount == null) {
    print("Invalid amount.");
    return;
  }

  expenses.add(Expense(name, amount, DateTime.now()));
  print("Inserted!.");
}

void deleteExpense(List<Expense> expenses) {
  stdout.write("Enter the ID of the item to delete: ");
  String? idInput = stdin.readLineSync()?.trim();

  if (idInput == null || idInput.isEmpty) {
    print("Invalid input.");
    return;
  }

  int? id = int.tryParse(idInput);
  if (id == null || id < 1 || id > expenses.length) {
    print("Invalid ID.");
    return;
  }

  expenses.removeAt(id - 1);
  print("Deleted!.");
}

class Expense {
  String name;
  int amount;
  DateTime date;

  Expense(this.name, this.amount, this.date);

  @override
  String toString() {
    return "$name : $amount฿ - ${date.toString().substring(0, 19)}";
  }
}
