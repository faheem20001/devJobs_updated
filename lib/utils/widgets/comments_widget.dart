


import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {

  final String commentId;
  final String commenterId;
  final String commenterName;
  final String commentBody;
  final String commentImageUrl;

 const  CommentWidget({
    required this.commentId,
    required this.commenterId,
    required this.commenterName,
    required this.commentBody,
    required this.commentImageUrl,
}

);



  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}


class _CommentWidgetState extends State<CommentWidget> {
  final List<Color> _colors=[
    Colors.amber,
    Colors.orange,
    Colors.pink.shade200,
    Colors.cyan,
    Colors.blueAccent,
    Colors.deepOrange
  ];


  @override
  Widget build(BuildContext context) {
    _colors.shuffle();

    return InkWell(
      onTap: (){

      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(flex: 1,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border:Border.all(
                width: 2,
                color: _colors[1]
              ) ,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    widget.commentImageUrl == null
                        ? 'https://placehold.co/600x400.png'
                        : widget.commentImageUrl!

                ),
                fit: BoxFit.fill,


              )

            ),
          ),
          ),
          SizedBox(width: 6,

          ),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(widget.commenterName,
               style: TextStyle(
                 fontStyle: FontStyle.normal,
                 fontWeight: FontWeight.bold,
                 color: Colors.white,
                 fontSize: 16,
               ),
               ),
              Text(widget.commentBody,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),


            ],
          ))
        ],
      ),
    );
  }
}
