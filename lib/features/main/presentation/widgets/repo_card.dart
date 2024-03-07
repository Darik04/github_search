import 'package:flutter/material.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:github_search/constants/texts/text_styles.dart';
import 'package:github_search/features/main/domain/enities/repo_entity.dart';



class RepoCard extends StatelessWidget {
  final RepoEntity repoEntity;
  const RepoCard({super.key, required this.repoEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyles.grey888),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repoEntity.title, style: TextStyles.black18w700,),
          const SizedBox(height: 10,),
          Text(repoEntity.description, style: TextStyles.black14w400,),
          const SizedBox(height: 10,),
          Row(
            children: [
              Text('Stars: ', style: TextStyles.black14w400,),
              Text(repoEntity.stars.toString(), style: TextStyles.black14w700.copyWith(color: ColorStyles.primary),),
            ],
          )
          // const SizedBox(height: 10,),
          // Row(
          //   children: [
          //     Text('Author: ', style: TextStyles.black14w400,),
          //     Text(e.comments.toString(), style: TextStyles.black14w700,),
          //   ],
          // ),
        ],
      ),
    );
  }
}