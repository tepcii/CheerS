import 'package:cheers_app/data_models/host_party.dart';
import 'package:cheers_app/data_models/user.dart';
import 'package:cheers_app/generated/l10n.dart';
import 'package:cheers_app/utils/constants.dart';
import 'package:cheers_app/view/common/dialog/confirm_dialog.dart';
import 'package:cheers_app/view/host_party/pages/sub/invited_friends_part.dart';
import 'package:cheers_app/view/profile/screens/profile_screen.dart';
import 'package:cheers_app/view_models/host_party_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style.dart';
import '../../home_screen.dart';

class HostPartyConfirmationScreen extends StatelessWidget {
  final HostParty hostParty;
  final PostCaptionOpenMode from;
  final FeedMode feedMode;
  final User hostPartyUser;
  final List<User> selectedFriends;
  final int index;

  HostPartyConfirmationScreen(
      {@required this.hostParty,
      @required this.from,
      this.feedMode,
      @required this.hostPartyUser,
      @required this.selectedFriends,
      this.index});

  @override
  Widget build(BuildContext context) {
    final hostPartyViewModel =
        Provider.of<HostPartyViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: from == PostCaptionOpenMode.FROM_POST
            ? Text(S.of(context).confirmationPost)
            : Text(S.of(context).confirmationUpdates),
        actions: [
          //投稿の更新処理と、新規投稿の条件分岐

          from == PostCaptionOpenMode.FROM_POST

              //############新規投稿#############
              ? IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () => showConfirmDialog(
                      context: context,
                      title: S.of(context).post,
                      content: S.of(context).postConfirm,
                      onConfirmed: (isConfirmed) {
                        if (isConfirmed) {
                          _postParty(context, selectedFriends, index);
                        }
                      }),
                )

              //############投稿更新#############
              : IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () => showConfirmDialog(
                      context: context,
                      title: S.of(context).update,
                      content: S.of(context).editPostConfirm,
                      onConfirmed: (isConfirmed) {
                        if (isConfirmed) {
                          _updateHostParty(context);
                        }
                      }),
                )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text(
                    S.of(context).hostLocation,
                    style: coloredHostPartyCaptionPartTextStyle,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    hostPartyViewModel.selectedPrefecture,
                    style: hostPartyCaptionPartTextStyle,
                  ),
                ],
              ),
              Divider(
                thickness: 1.0,
              ),
              Text(
                S.of(context).selfIntroductionToHostParty,
                style: coloredHostPartyCaptionPartTextStyle,
              ),
              Divider(
                thickness: 1.0,
              ),
              Text(
                hostPartyViewModel.caption.toString(),
                style: hostPartyCaptionPartTextStyle,
              ),
              Divider(
                thickness: 1.0,
              ),
              Center(
                  child: InvitedFriendsPart(selectedFriends: selectedFriends)),
            ],
          ),
        ),
      ),
    );
  }

  //新規投稿
  void _postParty(
      BuildContext context, List<User> selectedFriends, int index) async {
    final hostPartyViewModel =
    Provider.of<HostPartyViewModel>(context, listen: false);



    //""""""""招待者１名"""""""""""""
    if(selectedFriends.length == 1){
      String member2Id = selectedFriends[0].uId;
      String member3Id = "";
      String member4Id = "";
      String member5Id = "";
      String member6Id = "";
      String member7Id = "";
      String member8Id = "";
      String member9Id = "";
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("１名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待者２名"""""""""""""
    if(selectedFriends.length == 2){
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = "";
      String member5Id = "";
      String member6Id = "";
      String member7Id = "";
      String member8Id = "";
      String member9Id = "";
      String member10Id = "";

      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("２名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待者３名"""""""""""""
    if(selectedFriends.length == 3){
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = "";
      String member6Id = "";
      String member7Id = "";
      String member8Id = "";
      String member9Id = "";
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("３名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待4名"""""""""""""
    if(selectedFriends.length == 4){
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = selectedFriends[3].uId;
      String member6Id = "";
      String member7Id = "";
      String member8Id = "";
      String member9Id = "";
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("4名");
      _openHomeScreen(context);
      return;
    }


    //""""""""招待5名"""""""""""""
    if(selectedFriends.length == 5){
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = selectedFriends[3].uId;
      String member6Id = selectedFriends[4].uId;
      String member7Id = "";
      String member8Id = "";
      String member9Id = "";
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("5名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待6名"""""""""""""
    if(selectedFriends.length == 6) {
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = selectedFriends[3].uId;
      String member6Id = selectedFriends[4].uId;
      String member7Id = selectedFriends[5].uId;
      String member8Id = "";
      String member9Id = "";
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("6名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待7名"""""""""""""
    if(selectedFriends.length == 7) {
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = selectedFriends[3].uId;
      String member6Id = selectedFriends[4].uId;
      String member7Id = selectedFriends[5].uId;
      String member8Id = selectedFriends[6].uId;
      String member9Id = "";
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("7名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待8名"""""""""""""
    if(selectedFriends.length == 8) {
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = selectedFriends[3].uId;
      String member6Id = selectedFriends[4].uId;
      String member7Id = selectedFriends[5].uId;
      String member8Id = selectedFriends[6].uId;
      String member9Id = selectedFriends[7].uId;
      String member10Id = "";
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("8名");
      _openHomeScreen(context);
      return;
    }

    //""""""""招待9名"""""""""""""
    if(selectedFriends.length == 9) {
      String member2Id = selectedFriends[0].uId;
      String member3Id = selectedFriends[1].uId;
      String member4Id = selectedFriends[2].uId;
      String member5Id = selectedFriends[3].uId;
      String member6Id = selectedFriends[4].uId;
      String member7Id = selectedFriends[5].uId;
      String member8Id = selectedFriends[6].uId;
      String member9Id = selectedFriends[7].uId;
      String member10Id = selectedFriends[8].uId;
      await hostPartyViewModel.postParty(
          member2Id,
          member3Id,
          member4Id,
          member5Id,
          member6Id,
          member7Id,
          member8Id,
          member9Id,
          member10Id,
          selectedFriends
      );
      print("9名");
      _openHomeScreen(context);
      return;
    }



  }

//投稿を更新
  void _updateHostParty(BuildContext context) async {
    final hostPartyViewModel =
        Provider.of<HostPartyViewModel>(context, listen: false);
    await hostPartyViewModel.updateHostParty(hostParty, feedMode);

    print(
        "HostPartyConfirmationScreen# hostPartyViewModel.updateHostParty invoked");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void _openHomeScreen(BuildContext context) {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );

  }


}
