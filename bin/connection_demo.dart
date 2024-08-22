import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Login successful: ${data['userId']}');
      return true;
    } else {
      print('Login failed');
      return false;
    }
  }

  Future<List> getExpenses(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/expenses?userId=$userId'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<void> addExpense(int userId, String item, double paid, String date) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'item': item,
        'paid': paid,
        'date': date,
      }),
    );
    if (response.statusCode == 200) {
      print('Expense added successfully');
    } else {
      print('Failed to add expense');
    }
  }

  Future<void> deleteExpense(int expenseId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/expenses/$expenseId'),
    );
    if (response.statusCode == 200) {
      print('Expense deleted successfully');
    } else {
      print('Failed to delete expense');
    }
  }
}
