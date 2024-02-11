import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:register_customer/model/customer_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService {
  final customerUrl = 'https://172.31.132.67:7034/api/Customer';

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken') ?? '';
    if (kDebugMode) {
      print('tokensharepre $token');
    }
    return token;
  }

  Future<List<Customer>?> fetchCustomers() async {
    try {
      if (kDebugMode) {
        // print('fetchCustomers methods token ' + await getToken());
      }
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer ${await getToken()}'
      };
      Uri url = Uri.parse(customerUrl);
      var response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        final jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList.map((json) => Customer.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        log('Unauthorized Error');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Customer> fetchCustomerById(int id) async {
    final response = await http.get(
      Uri.parse('$customerUrl/$id'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      log(json.toString());
      return Customer.fromJson(json);
    } else {
      throw Exception('Failed to fetch customer');
    }
  }

  Future<List<Customer>> searchCustomers(String query) async {
    final response = await http.post(
      Uri.parse('$customerUrl/searchcustomer/$query'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
      },
    );
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List<dynamic>;
      return json.map((e) => Customer.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search customers');
    }
  }

  Future<Customer> createCustomer(Customer customer) async {
    try {
      final response = await http.post(
        Uri.parse(customerUrl),
        headers: {
          'Authorization': 'Bearer ${await getToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(customer.toJson()),
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Customer.fromJson(json);
      } else {
        throw Exception('Failed to create customer');
      }
    } catch (e) {
      throw Exception('Failed to create customer: $e');
    }
  }

  Future<Customer> updateCustomer(Customer customer) async {
    final response = await http.put(
      Uri.parse('$customerUrl/${customer.customerId}'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(customer.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print('json  $json');
      }
      return Customer.fromJson(json);
    } else {
      throw Exception('Failed to update customer');
    }
  }

  Future<void> deleteCustomer(int id) async {
    final response = await http.delete(
      Uri.parse('$customerUrl/$id'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete customer');
    }
  }
}
