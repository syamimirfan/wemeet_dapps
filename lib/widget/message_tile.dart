import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/shared/constants.dart';

class MessageTile extends StatefulWidget {

  final bool isSentByMe;
  final String message;
  final String date;

  const MessageTile({super.key, required this.isSentByMe, required this.message, required this.date});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
final String dateFormat = DateFormat.yMd().add_jm().format(DateTime.parse(widget.date).toLocal());
    return Container(
      padding: EdgeInsets.only(
      top: 10,
      bottom: 12,
      left: widget.isSentByMe ? 0 : 24,
      right: widget.isSentByMe ? 24: 0
      ),
      alignment: widget.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
        margin: widget.isSentByMe ? const EdgeInsets.only(left: 30)
        : const EdgeInsets.only(right: 30),
        padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: widget.isSentByMe ? 
          const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            
          )
          : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: widget.isSentByMe ? Constants().secondaryColor : Constants().messageGreyColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
             widget.message,
             textAlign: TextAlign.start,
             style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.white,
             ),
            ),
            SizedBox(height: 1.h,),
              Text(
             dateFormat,
             textAlign: TextAlign.start,
             style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold
             ),
            ),
          ],
        ),
      ),
    );
  }
}