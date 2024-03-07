import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_search/constants/colors/color_styles.dart';
import 'package:github_search/constants/main_config_app.dart';
import 'package:github_search/constants/texts/text_styles.dart';
import 'package:github_search/core/utils/toast.dart';
import 'package:github_search/core/widgets/loaders/loader.dart';
import 'package:github_search/features/main/presentation/bloc/repo/repo_bloc.dart';
import 'package:github_search/features/main/presentation/widgets/default_text_input.dart';
import 'package:github_search/features/main/presentation/widgets/repo_card.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  @override
  void initState() {
    super.initState();
    final repoBloc = context.read<RepoBloc>();
    repoBloc.add(GetRepoEvent());
  }


  final TextEditingController searchController = TextEditingController();


  void onSearch(){
    final repoBloc = context.read<RepoBloc>();
    if(searchController.text.isNotEmpty){
      repoBloc.add(GetRepoEvent(query: searchController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final repoBloc = context.read<RepoBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorStyles.black2,
        title: Text(MainConfigApp.appName, style: TextStyles.white20w700,),
      ),
      body: BlocConsumer<RepoBloc, RepoState>(
        listener: (context, state) {
          if(state is RepoErrorState){
            showAlertToast(state.message);
          }
        },
        builder: (context, state) {
          if(state is RepoLoadingState || state is RepoInitialState){
            return const Center(
              child: Loader(),
            );
          }

          final repositories = repoBloc.mainEntity.items;

          

          return RefreshIndicator(
            onRefresh: () async{
              onSearch();
              return;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: 85,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultTextFormField(
                              hint: 'Search..',
                              controller: searchController,
                            )
                          ),
                          GestureDetector(
                            onTap: onSearch,
                            child: Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorStyles.black2,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: SvgPicture.string('<svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16.375 14.5H15.3813L15.0375 14.1562C16.2625 12.7375 17 10.8938 17 8.875C17 4.3875 13.3625 0.75 8.875 0.75C4.3875 0.75 0.75 4.3875 0.75 8.875C0.75 13.3625 4.3875 17 8.875 17C10.8938 17 12.7375 16.2625 14.1562 15.0438L14.5 15.3875V16.375L20.75 22.6125L22.6125 20.75L16.375 14.5ZM8.875 14.5C5.76875 14.5 3.25 11.9812 3.25 8.875C3.25 5.76875 5.76875 3.25 8.875 3.25C11.9812 3.25 14.5 5.76875 14.5 8.875C14.5 11.9812 11.9812 14.5 8.875 14.5Z" fill="white"/></svg>'),
                            ),
                          )
                        ],
                      ),
                    ),

                    if(repositories.isEmpty)
                    Center(
                      child: Text('Repositories is Empty, search please!', style: TextStyles.black11w400,),
                    )
                    else
                    //Showing repositores
                    ...repositories.map((e) 
                      => RepoCard(repoEntity: e)
                    ).toList()
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}