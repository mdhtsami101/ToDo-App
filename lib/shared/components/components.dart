

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';






Widget defaultButton({
   double width = double.infinity ,
   double radius = 0.0 ,
   Color background=Colors.blue ,
   bool isUpperCase = true,
  required Function  ,
  required String text ,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed:   Function ,
        child: Text(
         isUpperCase? text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required Function ,
  required String text ,
})=>TextButton(
onPressed:Function,
child: Text(text.toUpperCase(),),
);




Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onChange,
  onTap,
  required  validat,
  bool isPassword = false,
  required String lable ,
  required IconData prefix,
  IconData? suffix ,
  suffixPressed,
})=>
TextFormField(
  controller: controller,
  keyboardType: type ,
  onFieldSubmitted:onSubmit ,
  onChanged: onChange,
  validator: validat,
  onTap: onTap,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText:lable, //hintText: 'Email Address'
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed:suffixPressed ,
      icon: Icon(
          suffix,
      ),
    ) : null,
  ),
);

Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text(

            '${model['time']}',

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['data']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'done', id: model['id']);

            },

            icon:Icon(

              Icons.check_box,

              color: Colors.green,

            ),

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'archived', id: model['id']);

            },

            icon:Icon(

              Icons.archive,

              color: Colors.black45,

            ),

        ),

      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);


Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);


Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


void navigateTo(context , widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
);

void navigateAndFinish (context , widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
  (Route<dynamic>route) => false,
);


