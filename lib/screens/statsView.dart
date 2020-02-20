import 'package:corona_tracker/provider/info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Color(0xff6a1b9a),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Stats",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Consumer<InfoNotifier>(
          builder: (ctx, info, child) {
            return ListView.builder(
              itemCount: info.places.length,
              itemBuilder: (context, index) {
                String infected = "";
                try {
                  infected = info.places[index].report.infected.toString();
                } catch (ex) {
                  infected = "N/A";
                }
                String countryFlag =
                    "assets/flags/${info.places[index].country.toLowerCase()}.png";
                return ListTile(
                  leading: Image.asset(countryFlag),
                  title: Text(info.places[index].name),
                  subtitle: Text(
                    DateFormat('EEEE, d MMM, yyyy').format(
                      DateFormat('yyyy-MM-dd')
                          .parse(info.places[index].createdAt),
                    ),
                  ),
                  trailing: Text(
                    infected,
                    style: TextStyle(
                      color: Color(0xff512da8),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
