import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_quest/bloc/list_user_bloc.dart';
import 'package:suitmedia_quest/bloc/user_bloc.dart';
import 'package:suitmedia_quest/logic/model/user.dart';
import 'package:suitmedia_quest/theme/theme.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    int page = 1;
    int pageSize = 10;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: MyTheme.secondaryBlue,
          iconSize: 20,
        ),
        title: const Text(
          'Second Page',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ListUserBloc, ListUserState>(
        builder: (context, state) {
          if (state is ListUserInitial) {
            BlocProvider.of<ListUserBloc>(context).add(FetchListUser(page, pageSize));
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListUserLoaded) {
            return ListUserView(users: state.users, hasReachedMax: state.hasReachedMax);
          } else {
            return const Center(child: Text('Error loading users'));
          }
        },
      ),
    );
  }
}

class ListUserView extends StatefulWidget {
  final List<User> users;
  final bool hasReachedMax;

  const ListUserView({Key? key, required this.users, required this.hasReachedMax})
      : super(key: key);

  @override
  State<ListUserView> createState() => _ListUserViewState();
}

class _ListUserViewState extends State<ListUserView> {
  final _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _page++;
        BlocProvider.of<ListUserBloc>(context).add(FetchListUser(_page, widget.users.length));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _page++;
        BlocProvider.of<ListUserBloc>(context).add(FetchListUser(_page, widget.users.length));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _page = 1;
        BlocProvider.of<ListUserBloc>(context).add(ResetListUser());
      },
      child: ListView.builder(
        itemCount: widget.users.length + (widget.hasReachedMax ? 0 : 1),
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < widget.users.length) {
            final user = widget.users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
              ),
              title: Text(
                '${user.firstName} ${user.lastName}',
                ),
              subtitle: Text(user.email),
              onTap: () {
                BlocProvider.of<UserBloc>(context).add(SelectUser(user));
                Navigator.pop(context, user);
              },
            );
          } else if (widget.hasReachedMax) {
            return const Center(
              child: Text('No more users'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}