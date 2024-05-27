import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/ranking/ranking_view_model.dart';
import 'package:front_android/src/view/ranking/widgets/ranking_list_card.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class RankingView extends ConsumerStatefulWidget {
  const RankingView({super.key});

  @override
  ConsumerState<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends ConsumerState<RankingView> {
  late RankingViewModel viewModel;

  @override
  void initState() {
    // characterRepository = CharacterRepository();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        viewModel.clearRankingList();
        viewModel.getRankingList();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(rankingViewModelProvider);
    final rankings = viewModel.rankingList;
    // final rankinglists = List.generate(10, (index) {
    //   return {
    //     'rank': index + 1,
    //     'nickname': ranking.nickname,
    //     'tierImage': Image.network(ranking.tierImage, fit: BoxFit.contain)
    //   };
    // });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          color: ref.color.black,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          S.current.ranking,
          style: ref.typo.appBarSubTitle,
        ),
      ),
      body: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (context, index) {
          final ranking = rankings[index];
          final rank = (index + 1);
          Color color;
          Color fontColor = const Color(0xffffffff);
          FontWeight fontWeight = FontWeight.bold;
          Color nameColor = const Color(0xffffffff);
          if (rank == 1) {
            color = const Color(0xff1A202C);
          } else if (rank == 2) {
            color = const Color(0xff2D3748);
          } else if (rank == 3) {
            color = const Color(0xff4A5568);
          } else {
            color = const Color(0xffffffff); // 기본 색상
            fontColor = const Color(0xff718096);
            nameColor = const Color(0xff000000);
            fontWeight = FontWeight.normal;
          }
          return Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: color,

              //color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // 등수
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    rank.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: fontWeight,
                      color: fontColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // 닉네임
                Expanded(
                  child: Text(
                    ranking.nickname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: nameColor,
                    ),
                  ),
                ),
                // 티어 이미지
                Stack(
                  children: [
                    Positioned(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.network(
                        ranking.tierImage,
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: 150.0,
                      ),
                    )),
                    Positioned(
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              ranking.tierName,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: nameColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ranking.tierScore.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: nameColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
