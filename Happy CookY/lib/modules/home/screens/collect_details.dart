import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/model/collect_model.dart';
import 'package:register_customer/model/user_data_model.dart';
import 'package:register_customer/modules/home/bloc/collect_report_state_management_bloc.dart';
part 'mixin/collect_report_mixin.dart';

class CollectDetails extends StatefulWidget {
  final String categoryIdval;
  const CollectDetails({super.key, required this.categoryIdval});

  @override
  State<CollectDetails> createState() => _CollectDetailsState();
}

class _CollectDetailsState extends State<CollectDetails>
    with _CollectReportMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectReportStateManagementBloc,
        CollectReportStateManagementState>(
      listener: (context, state) {
        if (state is CollectReportSuccess) {
          totalValue = state.total + 10000;
          possessValue = state.possessValue;
        }
        if (state is LoadedCollectReport) {
          collectDatas = state.collectDatas;
        }
      },
      builder: (context, state) {
        if (state is CollectReportStateManagementInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                possessValue > 0
                    ? SizedBox(
                        height: 370,
                        child: PieChart(
                          PieChartData(
                              sectionsSpace: 0,
                              centerSpaceRadius: 72.5,
                              startDegreeOffset: 90,
                              sections: [
                                PieChartSectionData(
                                  value: ((totalValue - possessValue) /
                                          totalValue) *
                                      100,
                                  title: 'Other',
                                  color: Colors.grey.shade300,
                                  radius: 50,
                                  badgePositionPercentageOffset: 1.15,
                                  badgeWidget: _Badge(
                                    Colors.blueAccent,
                                    value: ((totalValue - possessValue) /
                                            totalValue) *
                                        100,
                                    borderColor: Colors.black,
                                    size: 70,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: (possessValue / totalValue) * 100,
                                  title: 'Your Possess',
                                  color: Colors.blue,
                                  radius: 60,
                                  badgePositionPercentageOffset: 1.15,
                                  badgeWidget: _Badge(
                                    Colors.blueAccent,
                                    value: (possessValue / totalValue) * 100,
                                    borderColor: Colors.black,
                                    size: 70,
                                  ),
                                ),
                              ]),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  circularText(
                                      name: collectDatas[index].collectorName!),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            collectDatas[index].collectorName!),
                                        Text(collectDatas[index]
                                            .collectDescription!),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(collectDatas[index]
                                            .collectDate!
                                            .split('T')
                                            .first),
                                        Text(collectDatas[index]
                                            .collectValue!
                                            .toString()),
                                        // Text(useReportDetailModel[index].reportDescription!),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    '${collectDatas[index].commandCount.toString()} commands',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ))
                          ],
                        );
                      },
                      separatorBuilder: (context, ind) =>
                          const Divider(thickness: 0),
                      itemCount: collectDatas.length),
                )
              ],
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        key: stickyKey,
                        focusNode: myFocusNode,
                        keyboardType: keyboardType,
                        controller: addAmount
                            ? colAmountController
                            : descriptionController,
                        onChanged: (value) {
                          // _showOverlay(context);
                          if (descriptionController.text.contains('@')) {
                            String searchname=descriptionController.text.split('@').last;
                            searchUsers(searchname);
                          }
                        },
                        contextMenuBuilder: (context, editableTextState) {
                          return const Text('Size');
                        },
                        decoration: InputDecoration(
                            labelText: 'Add Collect Report',
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: addAmount
                                ? 'Add Collect Amount'
                                : 'Fill Discription'),
                      ),
                    ),
                    InkWell(
                        onDoubleTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text('Upward to Swipe'),
                                );
                              });
                        },
                        onTap: () {
                          addAmount
                              ? addAmount = false
                              : descriptionController.text.isEmpty
                                  ? null
                                  : sendCollectReport();
                          if (addAmount &&
                              colAmountController.text.isNotEmpty) {
                            setState(() {
                              addAmount = !addAmount;
                              keyboardType = TextInputType.text;
                              myFocusNode.unfocus();
                              Future.delayed(const Duration(milliseconds: 50))
                                  .then((value) {
                                myFocusNode.requestFocus();
                              });
                            });
                          } else if (descriptionController.text.isNotEmpty) {
                            sendCollectReport();
                          }
                        },
                        child: const Icon(Icons.send))
                  ],
                )),
          );
        }
      },
    );
  }

  Widget circularText({required String name, double? height, double? width}) {
    return Container(
      height: height ?? 55, //55
      width: width ?? 55, //55
      padding: const EdgeInsets.all(2),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey, //logoStatus.isSet! ? Colors.amberAccent :
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: Colors.white,
            width: 2.5,
          ),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48),
            child: Center(
              child: Text(
                name.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.bgColor, {
    required this.size,
    required this.borderColor,
    required this.value,
  });
  final Color bgColor;
  final double size;
  final Color borderColor;
  final double value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.topCenter,
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 0.01,
        ),
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text('${value.toStringAsFixed(2)}%'),
      ),
    );
  }
}
