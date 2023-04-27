import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wemeet_dapps/api_services/api_chat.dart';
import 'package:wemeet_dapps/shared/constants.dart';
import 'package:wemeet_dapps/widget/widgets.dart';

class MessageTile extends StatefulWidget {

  final bool isSentByMe;
  final String message;
  final String date;
  final int chatId;

  const MessageTile({super.key, required this.isSentByMe, required this.message, required this.date, required this.chatId});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
 double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  
  @override
  Widget build(BuildContext context) {
    
final String dateFormat = DateFormat.yMd().add_jm().format(DateTime.parse(widget.date).toLocal());
    return GestureDetector(
       onLongPress: () {
        
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            width: 50.w,
            padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.12,vertical: deviceHeight(context) * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('copy');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.content_copy),
                        const SizedBox(width: 16.0),
                        Text(
                          'Copy',       
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.black,
                             fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('delete');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        const SizedBox(width: 16.0),
                        Text(
                          'Delete',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    
    ).then((value) {
      if (value == 'copy') {
        Clipboard.setData(ClipboardData(text: widget.message));
        showSnackBarSuccessful(context, "Message Copied");
      } else if (value == 'delete') {
        if(widget.isSentByMe == true) {
           deleteChat(widget.chatId);
        }else {
          showSnackCannotDelete(context, "Cannot Delete Chat");
        }
         
      }
    });
  },
      child: Container(
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
      ),
    );
  }

   //delete chat 
  deleteChat(int chatId) async {
    var responseChat = await new Chat().deleteMessage(chatId);

     if(responseChat['success']) {
      nextScreenPop(context);
    }else{
      throw Exception(responseChat['message']);
    }
  }
  //show snackbar successful copied message
  void showSnackBarSuccessful(BuildContext context, String content) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03,vertical:deviceWidth(context) * 0.05),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 22, color: Colors.white,),
              SizedBox(width: 5.w,),
              Text(
            content,
            style: TextStyle(
               fontWeight: FontWeight.bold, 
               fontFamily: 'Poppins',
               fontSize: 16,
               color: Colors.white
             ),  
            ),

            ],
          ),
          duration: Duration(seconds: 3),
         ),
      );
  }

  //show snackbar cannot delete message
  void showSnackCannotDelete(BuildContext context, String content) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          padding:EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.03,vertical:deviceWidth(context) * 0.05),
          backgroundColor: Constants().secondaryColor,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 22, color: Colors.white,),
              SizedBox(width: 5.w,),
              Text(
            content,
            style: TextStyle(
               fontWeight: FontWeight.bold, 
               fontFamily: 'Poppins',
               fontSize: 16,
               color: Colors.white
             ),  
            ),

            ],
          ),
          duration: Duration(seconds: 3),
         ),
      );
  }

}