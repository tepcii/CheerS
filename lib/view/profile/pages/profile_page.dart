import 'package:cheers_app/data_models/host_party.dart';
import 'package:cheers_app/data_models/user.dart';
import 'package:cheers_app/generated/l10n.dart';
import 'package:cheers_app/style.dart';
import 'package:cheers_app/utils/constants.dart';
import 'package:cheers_app/view/common/components/button_with_icon.dart';
import 'package:cheers_app/view/profile/components/profile_photo_part.dart';
import 'package:cheers_app/view/profile/components/profile_post_tile.dart';
import 'package:cheers_app/view/profile/components/profile_setting_part.dart';
import 'package:cheers_app/view/profile/components/sub/profile_application_of_friends_part.dart';
import 'package:cheers_app/view/profile/components/sub/profile_friend_request_by_me_part.dart';
import 'package:cheers_app/view/profile/components/sub/profile_number_of_friends_part.dart';
import 'package:cheers_app/view/profile/screens/profile_application_of_friends_screen.dart';
import 'package:cheers_app/view/profile/components/sub/profile_detail_part.dart';
import 'package:cheers_app/view/profile/components/sub/profile_likes_part.dart';
import 'package:cheers_app/view/profile/screens/change_photo_screen.dart';
import 'package:cheers_app/view/profile/screens/profile_edit_screen.dart';
import 'package:cheers_app/view/profile/screens/profile_friend_request_by_me_screen.dart';
import 'package:cheers_app/view/profile/screens/profile_number_of_friends_screen.dart';
import 'package:cheers_app/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  final HostParty hostParty;
  final bool isImageFromFile;
  final int index;

  ProfilePage(
      {@required this.profileMode,
      this.selectedUser,
      this.hostParty,
      this.isImageFromFile,
      this.index});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    //???????????????????????????????????????????????????????????????
    profileViewModel.setProfileUser(widget.profileMode, widget.selectedUser);

    Future(() => profileViewModel.getParties(widget.profileMode));

    return Consumer<ProfileViewModel>(builder: (context, model, child) {
      final profileUser = model.profileUser;
      final profileImageFromFile = model.imageFile;
      final isFollowing = profileViewModel.isFollowingProfileUser;
      final isFriends = profileViewModel.isFriends;
      return Scaffold(
        appBar: AppBar(
          title: Text(profileUser.inAppUserName),
          actions: [
            ProfileSettingPart(
              mode: widget.profileMode,
            ),
          ],
        ),
        body: model.isProcessing
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //""""""""""""?????????????????????????????????"""""""""""""""""""""""""""
                    profileViewModel.isProcessing
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 400,
                              child: InkWell(
                                // onTap: () => _openProfilePhotoExpandedScreen(context,index),
                                child: ProfilePhotoPart(
                                  profileImageFromFile: profileImageFromFile,
                                  mode: widget.profileMode,
                                  isImageFromFile: false,
                                ),
                              ),
                            ),
                          ),

                    ///""""""""""""??????????????????????????????"""""""""""""""""""""""""""
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ProfileLikesPart(
                            hostParty: widget.hostParty,
                          ),
                        ),

                        ///""""""""""""???????????????????????????"""""""""""""""""""""""""""
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () =>
                                _openProfileNumberOfFriendsScreen(context),
                            child: ProfileNumberOfFriendsPart(),
                          ),
                        ),

                        ///""""""""""""????????????????????????"""""""""""""""""""""""""""
                        widget.profileMode == ProfileMode.MYSELF
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: () =>
                                        _openProfileFriendRequestScreen(
                                            context),
                                    child: ProfileFriendRequestByMePart()),
                              )
                            : Container(),

                        ///""""""""""""???????????????????????????"""""""""""""""""""""""""""
                        widget.profileMode == ProfileMode.MYSELF
                            ? Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: () =>
                                        _openProfileApplicationOfFriendsScreen(
                                            context),
                                    child: ProfileApplicationOfFriendsPart()),
                              )
                            : Container(),
                      ],
                    ),

                    //""""""""""""????????????????????????????????????????????????????????????????????????????????????????????????????????????"""""""""""""""""""""""""""
                    widget.profileMode == ProfileMode.MYSELF
                        ? ButtonWithIcon(
                            onPressed: () => _openChangePhotoScreen(context),
                            label: S.of(context).changePhoto,
                            iconData: FontAwesomeIcons.portrait,
                          )
                        : profileViewModel.isFriends
                            //???????????????????????????????????????????????????????????????????????????????????????????????????or????????????????????????
                            ? ButtonWithIcon(
                                onPressed: () {
                                  setState(() {
                                    _quitFriends(context);
                                  });
                                },
                                label: S.of(context).quitBeingFriends,
                                iconData: FontAwesomeIcons.heartBroken,
                              )
                            : profileViewModel.isFollowingProfileUser
                                ? ButtonWithIcon(
                                    onPressed: null,
                                    label: S.of(context).requestFromYou,
                                    iconData: FontAwesomeIcons.handshake,
                                  )
                                : ButtonWithIcon(
                                    onPressed: () {
                                      setState(() {
                                        _follow(context);
                                      });
                                    },
                                    label: S.of(context).becomeFriend,
                                    iconData: FontAwesomeIcons.handshake,
                                  ),

                    //""""""""""""???????????????????????????????????????????????????"""""""""""""""""""""""""""
                    widget.profileMode == ProfileMode.MYSELF
                        ? ButtonWithIcon(
                            onPressed: () => _openProfileEditScreen(context),
                            label: S.of(context).editProfile,
                            iconData: FontAwesomeIcons.edit,
                          )
                        : Container(),

                    //""""""""""""??????????????????????????????"""""""""""""""""""""""""""

                    ProfileDetailPart(),
                    widget.profileMode == ProfileMode.MYSELF
                        ? Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Center(
                                  child: Text(
                                S.of(context).partyInSession,
                                style: profileEditTitleTextStyle,
                              )),
                              SizedBox(
                                height: 10.0,
                              ),

                              //""""""""""""???????????????????????????"""""""""""""""""""""""""""

                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: model.parties.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: ProfilePostTile(
                                        profileMode: widget.profileMode,
                                        hostParty: model.parties[index],
                                      ),
                                    );
                                  }),

                            ],
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              ),
      );
    });
  }

  _openProfileEditScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileEditScreen(),
        ));
  }

  _openChangePhotoScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePhotoScreen(),
      ),
    );
  }

  _follow(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);

    profileViewModel.follow();
  }

  _openProfileApplicationOfFriendsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileApplicationOfFriendsScreen(),
      ),
    );
  }

  _openProfileNumberOfFriendsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileNumberOfFriendsScreen(numberOfFriendsScreenOpenMode: NumberOfFriendsScreenOpenMode.FROM_PROFILE,),
      ),
    );
  }

  _openProfileFriendRequestScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileFriendRequestByMeScreen(),
      ),
    );
  }

  _quitFriends(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);

    profileViewModel.quitFriends();
  }
}
