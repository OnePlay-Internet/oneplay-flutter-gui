import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';
import 'package:oneplay_flutter_gui/app/widgets/user_row/user_row.dart';

class UsersList extends StatefulWidget {
  final String query;

  const UsersList({
    super.key,
    required this.query,
  });

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final RestService _restService = Modular.get<RestService>();
  List<ShortUserModel> users = [];
  int page = 0;
  bool loading = false;
  bool hasMore = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.query.trim() == ''
                ? 'All users'
                : 'You searched for "${widget.query}"',
            style: const TextStyle(
              color: greyColor1,
              fontSize: 20,
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: hasMore ? users.length + 1 : users.length,
            itemBuilder: ((context, index) {
              if (index < users.length) {
                return UserRow(user: users[index]);
              } else {
                _onLoad();
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ),
      ],
    );
  }

  @override
  initState() {
    _onLoad();
    super.initState();
  }

  _onLoad() async {
    if (loading || !hasMore) {
      return;
    }

    loading = true;

    try {
      final res = await _restService.searchUsers(
        query: widget.query,
        page: page,
        limit: 10,
      );
      setState(() {
        users = [...users, ...res];
        if (res.length < 10) hasMore = false;
      });
      page++;
    } finally {
      loading = false;
    }
  }
}
