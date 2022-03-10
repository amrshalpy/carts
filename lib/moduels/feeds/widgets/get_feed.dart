import 'package:carts/compnement/compnement.dart';
import 'package:carts/model/posts.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

Widget getFeed(PostModel post) {
  return Card(
    elevation: 10,
    shadowColor: greyColor,
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/portrait-shocked-brunet-european-man-stares-surprisingly-camera-keeps-eyes-widely-opened-wears-round-spectacles-sweater-sees-something-breathtaking-isolated-beige-studio-background_273609-56718.jpg?w=740',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  customText(
                    txt: 'Amr Mohamed',
                    color: blacColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  customText(
                    txt: 'Flutter devloper',
                    color: greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  customText(
                    txt: '${post.date}',
                    color: greyColor,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onCanceled: () {},
                  itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () {},
                            child: Text('update'),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: InkWell(onTap: () {}, child: Text('delete')),
                          value: 2,
                        ),
                      ]),
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          height: 200,
          width: double.infinity,
          child: Image.network(
            '${post.imagePost}',
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: const ReadMoreText(
            'text texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            lessStyle: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.normal,
            ),
            moreStyle: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.normal,
            ),
            trimCollapsedText: 'read more',
            trimExpandedText: 'read less',
            trimLines: 5,
            trimMode: TrimMode.Line,
          ),
        ),
        Divider(
          thickness: 1,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('100'),
                  Icon(Icons.favorite_border),
                ],
              ),
              Row(
                children: [
                  Text('100'),
                  Icon(Icons.comment),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Like'),
                  Icon(Icons.favorite_border),
                ],
              ),
              Row(
                children: [
                  Text('Comment'),
                  Icon(Icons.comment),
                ],
              ),
              Row(
                children: [
                  Text('Share'),
                  Icon(Icons.share),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
