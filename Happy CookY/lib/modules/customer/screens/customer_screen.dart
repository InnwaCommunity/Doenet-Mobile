import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/config/routes/content_ext.dart';
import 'package:register_customer/config/routes/routes.dart';
import 'package:register_customer/customer_details.dart';
import 'package:register_customer/model/customer_data_model.dart';
import 'package:register_customer/modules/customer/bloc/customer_screen_state_manage_bloc.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  // final String title;

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Customer> customerList = [];
  // Future<List<Customer>>? _customers;
  // List<Customer>
  TextEditingController inputcontroller = TextEditingController();
  // SelectedCustomer? selectedCustomer;

  @override
  void initState() {
    super.initState();
    // _customers = CustomerService().fetchCustomers().then((value) => value!);
    getCustomerList();
  }

  void getCustomerList() {
    BlocProvider.of<CustomerScreenStateManageBloc>(context)
    .add(FetchCustomers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("Customers"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            // style: Padding(padding: Edgew),
            onPressed: () {
              Navigator.pushNamed(context, '/searchcustomer');
              // print('Search button pressed');
            },
          ),
        ],
      ),
      body: BlocConsumer<CustomerScreenStateManageBloc,
          CustomerScreenStateManageState>(
        listener: (context, state) {
          if (state is FetchCustomerSuccess) {
            customerList=state.cusList;
          }
        },
        builder: (context, state) {
          if (state is CustomerScreenStateManageInitial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return customerList.isNotEmpty ?
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: customerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Customer customer = customerList[index];
                    return ListTile(
                      title: Text(customer.customerName),
                      subtitle: Text('Address: ${customer.customerAddress}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CustomerDetails(customer: customer)));
                      },
                      tileColor: Colors.deepOrange[200],
                    );
                  },
                ))
              ],
            ) : const Center(
              child: Text('There is no Customer List'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => CustomerDetails()));
          context.left(Routes.login, (route) => false);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
