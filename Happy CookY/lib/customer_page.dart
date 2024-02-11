// import 'package:flutter/material.dart';
// import 'package:register_customer/customer_details.dart';
// import 'package:register_customer/helper/customer_service.dart';
// import 'package:register_customer/model/customer_data_model.dart';

// class CustomerPage extends StatefulWidget {
//   const CustomerPage({super.key});

//   // final String title;

//   @override
//   State<CustomerPage> createState() => _CustomerPageState();
// }

// class _CustomerPageState extends State<CustomerPage> {
//   List<Customer> customerList = [];
//   Future<List<Customer>>? _customers;
//   TextEditingController inputcontroller = TextEditingController();
//   // SelectedCustomer? selectedCustomer;

//   @override
//   void initState() {
//     super.initState();
//     _customers = CustomerService().fetchCustomers().then((value) => value!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Customers"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             iconSize: 30,
//             // style: Padding(padding: Edgew),
//             onPressed: () {
//               Navigator.pushNamed(context, '/searchcustomer');
//               // print('Search button pressed');
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             child: FutureBuilder<List<Customer>>(
//               future: _customers,
//               builder: (BuildContext context,
//                   AsyncSnapshot<List<Customer>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     List<Customer> customers = snapshot.data ?? [];
//                     customers.sort(
//                         (a, b) => a.customerName.compareTo(b.customerName));

//                     return ListView.builder(
//                       itemCount: customers.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         Customer customer = customers[index];
//                         return ListTile(
//                           title: Text(customer.customerName),
//                           subtitle:
//                               Text('Address: ${customer.customerAddress}'),
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) =>
//                                     CustomerDetails(customer: customer)));
//                           },
//                           tileColor: Colors.deepOrange[200],
//                         );
//                       },
//                     );
//                   }
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => CustomerDetails()));
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

//from above codes
// Container(
//             height: 580,
//             child: FutureBuilder<List<Customer>>(
//               future: _customers,
//               builder: (BuildContext context,
//                   AsyncSnapshot<List<Customer>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     List<Customer> customers = snapshot.data ?? [];
//                     customers.sort(
//                         (a, b) => a.customerName.compareTo(b.customerName));

//                     return ListView.builder(
//                       itemCount: customers.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         Customer customer = customers[index];
//                         return Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                           ),
//                           padding: EdgeInsets.all(16.0),
//                           child: GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         CustomerDetails(customer: customer)));
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         customer.customerName,
//                                         style: const TextStyle(
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         // textAlign: TextAlign.right,
//                                       ),
//                                       const SizedBox(height: 1),
//                                       Text(
//                                         customer.customerAddress,
//                                         style: const TextStyle(
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         // textAlign: TextAlign.right,
//                                       ),
//                                     ],
//                                   ),

//                                   IconButton(
//                                     onPressed: () async {
//                                       // CustomerService.deleteCustomer(index);
//                                     },
//                                     icon: const Icon(
//                                         Icons.delete_forever_rounded),
//                                     // alignment: Alignment.centerLeft,
//                                   ),
//                                   // Expanded(
//                                   //   child: Text(
//                                   //     customers[index].customerAddress,
//                                   //     style: const TextStyle(
//                                   //       fontSize: 15.0,
//                                   //       fontWeight: FontWeight.bold,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                 ],
//                               )),
//                         );
//                       },
//                     );
//                   }
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),

// class CustomerPage extends StatefulWidget {
//   const CustomerPage({super.key});

//   @override
//   State<CustomerPage> createState() => _CustomerPageState();
// }

// class _CustomerPageState extends State<CustomerPage> {
//   int tmpId = 0;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   List<Customer> customerList = [];
//   Future<List<Customer>>? _customers;
//   Customer? customer;

//   retrieveData() async {
//     final Future<List<Customer>?> data = CustomerService().fetchCustomers();
//     setState(() {
//       _customers = data as Future<List<Customer>>?;
//       nameController.text = '';
//       addressController.text = '';
//       tmpId = 0;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     CustomerService().fetchCustomers().then((value) => value!);
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Customer Details'),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await retrieveData();
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 5),
//             Flexible(
//               child: TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Address Customer Name',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Flexible(
//               child: TextField(
//                 controller: addressController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Add Customer Address',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                     onPressed: () async {
//                       tmpId = 0;
//                       await retrieveData();
//                     },
//                     child: const Text('Retrieve')),
//                 ElevatedButton(
//                     onPressed: () async {
//                       Customer customer = Customer(
//                         customerName: nameController.text,
//                         customerAddress: addressController.text,
//                       );
//                       CustomerService().createCustomer(customer);
//                       await retrieveData();
//                     },
//                     child: const Text('Add')),
//                 ElevatedButton(
//                     onPressed: () async {
//                       Customer customer = Customer(
//                         customerName: nameController.text,
//                         customerAddress: addressController.text,
//                       );
//                       CustomerService().updateCustomer(customer);
//                       await retrieveData();
//                     },
//                     child: const Text('Update')),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Container(
//               height: 580,
//               child: FutureBuilder<List<Customer>>(
//                 future: _customers,
//                 builder: (BuildContext context,
//                     AsyncSnapshot<List<Customer>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       List<Customer> customers = snapshot.data ?? [];
//                       customers.sort(
//                           (a, b) => a.customerName.compareTo(b.customerName));

//                       return ListView.builder(
//                         itemCount: customers.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Customer customer = customers[index];
//                           return Container(
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                             ),
//                             padding: EdgeInsets.all(16.0),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   nameController.text =
//                                       widget.customer.customerName;
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           customers[index].customerName,
//                                           style: const TextStyle(
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           // textAlign: TextAlign.right,
//                                         ),
//                                         const SizedBox(height: 1),
//                                         Text(
//                                           customers[index].customerAddress,
//                                           style: const TextStyle(
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           // textAlign: TextAlign.right,
//                                         ),
//                                       ],
//                                     ),
//                                     IconButton(
//                                       onPressed: () async {
//                                          try {
//                             await CustomerService()
//                                 .deleteCustomer(widget.customer!.customerId!);
//                             setState(() {
//                               Navigator.pushNamed(context, '/customerpage');
//                             });
//                           } catch (e) {
//                             print('Failed to delete customer: $e');
//                           }
//                                       },
//                                       icon: const Icon(
//                                           Icons.delete_forever_rounded),
//                                       // alignment: Alignment.centerLeft,
//                                     ),
//                                   ],
//                                 )),
//                           );
//                         },
//                       );
//                     }
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


     // ListTile(
                            //             title: Text(customer.customerName),
                            //             subtitle:
                            //                 Text('Address: ${customer.customerAddress}'),
                            //             onTap: () {
                            //               // Navigator.of(context).push(MaterialPageRoute(
                            //               //     builder: (context) =>
                            //               //         CustomerDetails(customer: customer)));
                            //             },
                            //             tileColor: Colors.deepOrange[200],
                            //           ),
