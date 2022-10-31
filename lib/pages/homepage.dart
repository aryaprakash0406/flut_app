import 'package:api_render/RemoteServices/remote_data.dart';
import 'package:api_render/models/overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/performance.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RemoteData _remoteData = RemoteData();
  OverviewModel? _OverViewModel;
  List<PerformanceModel>? _performanceList;
  bool isLoaded = false;

  getData() async {
    _OverViewModel = await _remoteData.fetchOverViewData();
    _performanceList = await _remoteData.fetchPerformancedata();
    if (_OverViewModel != null && _performanceList != null) {
      isLoaded = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stocks"),
      ),
      body: isLoaded
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "OverViewModel",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff000087)),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                      OverViewModelTile("Sector", true, _OverViewModel!.sector),
                      OverViewModelTile("Industry", true, _OverViewModel!.industry),
                      OverViewModelTile(
                          "Market Cap.", false, _OverViewModel!.mcap.toString()),
                      OverViewModelTile("Enterprise Value (EV)", false,
                          _OverViewModel!.ev.toString()),
                      OverViewModelTile("Book Value / Share", false,
                          _OverViewModel!.bookNavPerShare.toString()),
                      OverViewModelTile("Price-Earning Ratio (PE)", false,
                          _OverViewModel!.ttmpe.toString()),
                      OverViewModelTile(
                          "PEG Ratio", false, _OverViewModel!.pegRatio.toString()),
                      OverViewModelTile("Dividend Yeild", false,
                          _OverViewModel!.overviewModelYield.toString()),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "View More",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Performance",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff000087)),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _performanceList?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: performanceTile(
                                  _performanceList![index].label,
                                  _performanceList![index].changePercent),
                            );
                          }),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "View More",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Row performanceTile(String label, double percent) {
    var modifiedPercent = double.parse(percent.toStringAsFixed(1));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 60,
            child: Text(
              label,
            )),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 20,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffD9D9D9),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(microseconds: 800),
                  height: 20,
                  width:
                      percent > 200 ? 200 : 200 * modifiedPercent.abs() / 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: percent > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              percent > 0
                  ? const Icon(
                      CupertinoIcons.arrowtriangle_up_fill,
                      size: 10,
                      color: Colors.green,
                    )
                  : const Icon(
                      CupertinoIcons.arrowtriangle_down_fill,
                      size: 10,
                      color: Colors.red,
                    ),
              Text("${(percent).toStringAsFixed(1)}%")
            ],
          ),
        )
      ],
    );
  }

  Row OverViewModelTile(String title, bool isIcon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            isIcon
                ? const Icon(
                    Icons.account_balance,
                    color: Colors.orange,
                  )
                : Container(),
            const SizedBox(
              width: 10,
            ),
            value == "null" ? const Text("-") : Text(value)
          ],
        )
      ],
    );
  }
}
