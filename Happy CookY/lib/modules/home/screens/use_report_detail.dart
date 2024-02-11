import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_customer/model/category_model.dart';
import 'package:register_customer/model/use_report_model.dart';
import 'package:register_customer/model/user_data_model.dart';
import 'package:register_customer/modules/home/bloc/use_report_state_management_bloc.dart';
part 'mixin/use_report_mixin.dart';

class UseReportDetail extends StatefulWidget {
  final CategoryModel categoryModel;
  const UseReportDetail({super.key, required this.categoryModel});

  @override
  State<UseReportDetail> createState() => _UseReportDetailState();
}

class _UseReportDetailState extends State<UseReportDetail>
    with _UseReportMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UseReportStateManagementBloc,
        UseReportStateManagementState>(
      listener: (context, state) {
        if (state is LoadUseReportSuccess) {
          useReportDetailModel = state.useReportList;
        }
        if (state is SaveUseReportSuccess) {
          getUseReportList();
        }
        if (state is FrashUserListSuccess) {
          users=state.userDatas;
        }
        if (state is UseReportBlocError) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Use Report'),
                  content: Text(state.error),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is UseReportStateManagementInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return useReportDetailModel.isNotEmpty
              ? SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, index) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      circularText(
                                          name: useReportDetailModel[index]
                                              .reporterName!),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(useReportDetailModel[index]
                                                .reporterName!),
                                            Text(useReportDetailModel[index]
                                                .reportDescription!,overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(useReportDetailModel[index]
                                                .reportDate!
                                                .split('T')
                                                .first),
                                            Text(useReportDetailModel[index]
                                                .useAmount!
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
                                        '${useReportDetailModel[index].commandCount.toString()} commands',
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ))
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 0,
                          ),
                          itemCount: useReportDetailModel.length,
                        ),
                      ),
                      mentionBox && myFocusNode.hasFocus && users.isNotEmpty && descriptionController.text.contains('@')? 
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 100,
                        child: ListView.separated(itemBuilder: (BuildContext context,int ind){
                          return Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: InkWell(
                              onTap: (){
                                mentionBox=false;
                                descriptionController.text=descriptionController.text.replaceAll('@', users[ind].userName!);
                                mentionUsers.add(users[ind]);
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                            circularText(
                                                name: users[ind].userName!,
                                                height: 40,
                                                width: 40),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(users[ind].userName!)
                                          ],
                              ),
                            ),
                          );
                        }, separatorBuilder: (context, index) => const Divider(
                          thickness: 0,
                        ),
                         itemCount: users.length),
                      )  : Container(),
                      Padding(
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
                                      ? useAmountController
                                      : descriptionController,
                                  onChanged: (value) {
                                    // _showOverlay(context);
                                    if (descriptionController.text.contains('@')) {
                                      String searchname=descriptionController.text.split('@').last;
                                      searchUsers(searchname);
                                      
                                    }
                                  },
                                  contextMenuBuilder:
                                      (context, editableTextState) {
                                    return const Text('Size');
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Create Use Report',
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      hintText: addAmount
                                          ? 'Add Use Amount'
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
                                    // addAmount ? addAmount=false : descriptionController.text.isEmpty ? null : sendUseReport();
                                    if (addAmount &&
                                        useAmountController.text.isNotEmpty) {
                                      setState(() {
                                        addAmount = !addAmount;
                                        keyboardType = TextInputType.text;
                                        myFocusNode.unfocus();
                                        Future.delayed(const Duration(
                                                milliseconds: 50))
                                            .then((value) {
                                          myFocusNode.requestFocus();
                                        });
                                      });
                                    } else if (descriptionController
                                        .text.isNotEmpty) {
                                      sendUseReport();
                                    }
                                  },
                                  child: const Icon(Icons.send))
                            ],
                          ))
                    ],
                  ),
                )
              : const Center(
                  child: Row(
                    children: [
                      Text('There is No Use Reports'),
                    ],
                  ),
                );
        }
      },
    );
  }

  void _showOverlay(BuildContext contexts) async {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      maintainState: true,
      builder: (_) {
        return ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (_, value, child) {
            return Positioned(
              left: MediaQuery.of(contexts).size.width * 0.03,
              right: MediaQuery.of(contexts).size.width * 0.03,
              bottom: MediaQuery.of(context).size.height * 0.45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Theme.of(context).colorScheme.secondary,
                  child: StatefulBuilder(builder: (context, setState) {
                    return Container(
                        color: Colors.blue,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        width: MediaQuery.of(contexts).size.width * 0.8,
                        height: MediaQuery.of(contexts).size.height * 0.2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    removeNotifier.value = true;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Usage Amount'),
                                Text(useAmountController.text)
                                // TextButton(onPressed: (){
                                //   setState((){
                                //     addAmount = true;
                                //   keyboardType=TextInputType.number;
                                //         myFocusNode.unfocus();
                                //         Future.delayed(const Duration(
                                //                 milliseconds: 50))
                                //             .then((value) {
                                //           myFocusNode.requestFocus();
                                //         });
                                //   });
                                // }, child: Text(useAmountController.text))
                              ],
                            ),
                            const Text('Description'),
                            Text(descriptionController.text)
                          ],
                        ));
                  }),
                ),
              ),
            );
          },
        );
      },
    );

    // inserting overlay entry
    overlayState.insert(overlayEntry);

    /// remove overlay entry
    removeNotifier.addListener(() {
      if (removeNotifier.value) {
        overlayEntry?.remove();
        overlayEntry = null;
      }
    });

    /// add false value when remove overlay to arrive original state
    if (overlayEntry != null) {
      overlayEntry!.addListener(
        () {
          if (overlayEntry == null) {
            removeNotifier.value = false;
          }
        },
      );
    }
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
