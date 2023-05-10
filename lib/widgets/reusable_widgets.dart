import 'package:flutter/material.dart';

class ReusableWidgets {
  // ignore: non_constant_identifier_names
  static String time_passed(DateTime datetime, {bool full = true}) {
    DateTime now = DateTime.now();
    DateTime ago = datetime;
    Duration dur = now.difference(ago);
    int days = dur.inDays;
    int years = days ~/ 365;
    int months = (days - (years * 365)) ~/ 30;
    int weeks = (days - (years * 365 + months * 30)) ~/ 7;
    int rdays = days - (years * 365 + months * 30 + weeks * 7).toInt();
    int hours = (dur.inHours % 24).toInt();
    int minutes = (dur.inMinutes % 60).toInt();
    int seconds = (dur.inSeconds % 60).toInt();
    var diff = {
      "d": rdays,
      "w": weeks,
      "m": months,
      "y": years,
      "s": seconds,
      "i": minutes,
      "h": hours
    };

    Map str = {
      'y': 'tahun',
      'm': 'bulan',
      'w': 'minggu',
      'd': 'hari',
      'h': 'jam',
      'i': 'menit',
      's': 'detik',
    };

    str.forEach((k, v) {
      if (diff[k]! > 0) {
        str[k] = '${diff[k]} $v${diff[k]! > 1 ? '' : ''}';
      } else {
        str[k] = "";
      }
    });
    str.removeWhere((index, ele) => ele == "");
    List<String> tlist = [];
    str.forEach((k, v) {
      tlist.add(v);
    });
    if (full) {
      return str.isNotEmpty ? "${tlist.join(", ")} yang lalu" : "Baru saja";
    } else {
      return str.isNotEmpty ? "${tlist[0]} yang lalu" : "Baru Saja";
    }
  }

  static alertNotification(BuildContext context, String? txt, IconData n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 1500),
          child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.9),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            title: Icon(
              n,
              size: 40,
              color: Colors.blue,
            ),
            content: Text(
              txt!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
