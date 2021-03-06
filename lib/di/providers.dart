
import 'package:cheers_app/models/db/database_manager.dart';
import 'package:cheers_app/models/repositories/chat_repository.dart';
import 'package:cheers_app/models/repositories/party_repository.dart';
import 'package:cheers_app/models/repositories/user_repository.dart';
import 'package:cheers_app/view_models/chat_view_model.dart';
import 'package:cheers_app/view_models/feed_view_model.dart';
import 'package:cheers_app/view_models/host_party_view_model.dart';
import 'package:cheers_app/view_models/login_view_model.dart';
import 'package:cheers_app/view_models/profile_view_model.dart';
import 'package:cheers_app/view_models/search_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

//1.独立したモデル
List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (context) => DatabaseManager(),
  ),
  // Provider<ThemeChangeRepository>(
  //   create: (context) => ThemeChangeRepository(),
  // ),


];

//2.依存しているモデル
// UserRepository => DatabaseManager
List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (context, dbManager, repo) => UserRepository(dbManager: dbManager ),
  ),

  // PartyRepository => DatabaseManager
  ProxyProvider<DatabaseManager, PartyRepository>(
    update: (context, dbManager, repo) => PartyRepository(dbManager: dbManager),
  ),

  // ChatRepository => DatabaseManager
  ProxyProvider<DatabaseManager, ChatRepository>(
    update: (context, dbManager, repo) => ChatRepository(dbManager: dbManager),
  ),



];

//３．ViewModelで依存しているもの
// LoginViewModel => UserRepository
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  ),

  // PartyViewModel => PartyRepository/UserRepository
  ChangeNotifierProvider<HostPartyViewModel>(
    create: (context) => HostPartyViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      partyRepository: Provider.of<PartyRepository>(context, listen: false),
    ),
  ),

  // FeedViewModel => PartyRepository/UserRepository
  ChangeNotifierProvider<FeedViewModel>(
    create: (context) => FeedViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      partyRepository: Provider.of<PartyRepository>(context, listen: false),
    ),
  ),

  // ProfileViewModel => PartyRepository/UserRepository
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) => ProfileViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      partyRepository: Provider.of<PartyRepository>(context, listen: false),
    ),
  ),

  // SearchViewModel => UserRepository
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  ),

  // ChatViewModel => ChatRepository
  ChangeNotifierProvider<ChatViewModel>(
    create: (context) => ChatViewModel(
      chatRepository: Provider.of<ChatRepository>(context, listen: false),
    ),
  ),


];
