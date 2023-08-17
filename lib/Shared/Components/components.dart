import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Shared/Bloc/cubit.dart';
import 'package:news_app/web_view/web_view.dart';


  Widget defaultFormField({

    required TextInputType type,
    required TextEditingController controller,
    String? label,
    String? hint,
    IconData? preficon,
    IconData? sufficon,
    String? Function(String?)? validator,
    InputBorder? inputBorder,
    Color? fillColor,
    Color? labelColor,
    Color? hintColor,
    Color? cursorColor,
    Color? prefixColor ,
    void Function()? suffixPreesed,
    void Function(String)? onSubmit,
    void Function(String)? onChange,
    TextStyle? style ,
    bool isObsecure = false,
    void Function()? onTab,

  }) => TextFormField(
      style: style ,
      keyboardType: type,
      controller: controller,
      validator: validator,
      obscureText: isObsecure,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        fillColor: fillColor ,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        border: inputBorder,
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        prefixIcon: Icon(
          preficon,
          color: prefixColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            sufficon,
          ),
          onPressed: suffixPreesed,
        ),
      ),
      onTap: onTab,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );

   Widget buildArticleItem({required BuildContext context, required Map article}) {
    return InkWell(
      onTap: (){
        navigateTo(
            context: context,
            widget: WebViewScreen(
              url: article['url'],
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 141,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10.0),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/news.jpg'
                    ),
                    fit: BoxFit.cover,
                  )
              ),

            ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Container(
                height: 140,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:  NewsCubit.get(context).isDark? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),

                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
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
  }

   Widget articleBuilder({required List<dynamic> list, bool? isSearch}) {
    return ConditionalBuilder(
        condition: list.isNotEmpty,
        builder: (context) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildArticleItem(context: context, article: list[index]);
            },
            separatorBuilder: (context, index) =>
            const Divider(

              height: 1,
              indent: 15.0,
              endIndent: 15.0,
            ),
            itemCount: list.length,
          );
        },
        fallback: (context) {
          if (isSearch == null) {
            return const Center(child: CircularProgressIndicator());
          }
          else {
            return Container();
          }
        }
    );
  }

  void navigateTo({required BuildContext context, required Widget widget}) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget,
        ));
  }




