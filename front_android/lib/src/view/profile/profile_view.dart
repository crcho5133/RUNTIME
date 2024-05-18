import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/profile/widget/friend_List_builder.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        viewModel.getFriendList();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(profileProvider);

    var user = UserService.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.profile,
          style: ref.typo.appBarMainTitle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            user.characterImgUrl,
            height: 200,
            fit: BoxFit.contain,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.nickname,
                style: ref.typo.headline1.copyWith(
                  fontSize: 36,
                ),
              ),
              const SizedBox(width: 5),
              PngImage(
                'tier/${user.tierName}',
                size: 30,
              ),
            ],
          ),
          GestureDetector(
            onTapUp: (details) => context.push(RoutePathHelper.profileEdit),
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: ref.color.profileEditButtonBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.current.profileEdit,
                    style: ref.typo.subTitle4.copyWith(
                      color: ref.color.profileText,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: 15,
                    color: ref.color.profileText,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: ref.color.profileText,
            height: 20,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          const FriendListBuilder(),
        ],
      ),
    );
  }
}