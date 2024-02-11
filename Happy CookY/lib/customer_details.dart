import 'package:flutter/material.dart';
import 'package:register_customer/helper/customer_service.dart';
import 'package:register_customer/model/customer_data_model.dart';
import 'dart:developer';

// ignore: must_be_immutable
class CustomerDetails extends StatefulWidget {
  CustomerDetails({super.key, this.customer});

  Customer? customer;

  @override
  State<CustomerDetails> createState() => _CustomerState();
}

class _CustomerState extends State<CustomerDetails> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      namecontroller.text = widget.customer!.customerName;
      addresscontroller.text = widget.customer!.customerAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: TextField(
              controller: namecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Customer Name',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Flexible(
            child: TextField(
              controller: addresscontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Customer Address',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.customer == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Customer customer = Customer(
                            customerId: 0,
                            customerName: namecontroller.text,
                            customerAddress: addresscontroller.text,
                          );
                          try {
                            // Customer createdCustomer =
                            await CustomerService().createCustomer(customer);
                            setState(() {
                              Navigator.pushNamed(context, '/customerpage');
                            });
                          } catch (e) {
                            // print('Failed to create customer: $e');
                          }
                        },
                        child: const Text('Create'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Customer customer = Customer(
                            customerId: widget.customer!.customerId,
                            customerName: namecontroller.text,
                            customerAddress: addresscontroller.text,
                          );
                          log(customer.customerAddress);
                          try {
                            Customer createdCustomer = await CustomerService()
                                .updateCustomer(customer);
                            log(createdCustomer.toString());
                            setState(() {
                              Navigator.pushNamed(context, '/customerpage');
                            });
                          } catch (e) {
                            log('Failed to update customer: $e');
                          }
                        },
                        child: const Text('Update'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await CustomerService()
                                .deleteCustomer(widget.customer!.customerId!);
                            setState(() {
                              Navigator.pushNamed(context, '/customerpage');
                            });
                          } catch (e) {
                            log('Failed to delete customer: $e');
                          }
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
