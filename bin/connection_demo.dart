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
