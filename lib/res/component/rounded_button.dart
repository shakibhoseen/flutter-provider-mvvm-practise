import "package:flutter/material.dart";

class RoundedButton extends StatefulWidget {
  bool isLoading;
  String title;
  VoidCallback onPress;

  RoundedButton({Key? key, required this.title,required this.onPress, this.isLoading = false, })
      : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  ValueNotifier onPressNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTapDown: (pointer){
       onPressNotifier.value = !onPressNotifier.value;
       print("down");
       widget.onPress();
     },
    onTapUp: (pointer) {
          onPressNotifier.value = !onPressNotifier.value;
          print("up");
        },
        onTapCancel: (){
          onPressNotifier.value = !onPressNotifier.value;
          print("cancel");
        },
        child: ValueListenableBuilder(
          valueListenable: onPressNotifier,
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: !value
                    ? [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(3, 3),
                            blurRadius: 15),
                      ]
                    : [],
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.lightGreen,
                    Colors.greenAccent.shade700,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: value? Colors.greenAccent : Colors.green,
                  width: 1,
                )
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if (widget.isLoading)
                      SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
