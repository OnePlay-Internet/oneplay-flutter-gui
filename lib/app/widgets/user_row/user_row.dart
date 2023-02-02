import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oneplay_flutter_gui/app/common/common.dart';
import 'package:oneplay_flutter_gui/app/models/friend_model.dart';
import 'package:oneplay_flutter_gui/app/models/user_model.dart';
import 'package:oneplay_flutter_gui/app/services/friend_service.dart';
import 'package:oneplay_flutter_gui/app/services/rest_service.dart';

class UserRow extends StatefulWidget {
  final ShortUserModel user;

  const UserRow({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserRow> createState() => _UserRowState();
}

class _UserRowState extends State<UserRow> {
  final FriendService friendService = Modular.get<FriendService>();
  final RestService restService = Modular.get<RestService>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Image.asset(malePng, height: 48, width: 48),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              '${widget.user.firstName} ${widget.user.lastName}',
              style: const TextStyle(
                color: textPrimaryColor,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Observer(
            builder: (context) {
              IconData icon;
              if (getFriend() != null) {
                icon = Icons.how_to_reg;
              } else if (getPending() != null) {
                icon = Icons.pending;
              } else {
                icon = Icons.person_add;
              }
              return IconButton(
                onPressed: () => loading ? null : _onTap(),
                icon: Icon(icon, color: whiteColor1),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTap() async {
    setState(() => loading = true);

    final acceptedFriend = getFriend();
    final pendingFriend = getPending();

    try {
      if (acceptedFriend != null) {
        await restService.deleteFriend(acceptedFriend.id);
        friendService.deleteFriend(acceptedFriend);
      } else if (pendingFriend != null) {
        await restService.deleteFriend(pendingFriend.id);
        friendService.cancelRequest(pendingFriend);
      } else {
        final id = await restService.addFriend(widget.user.id);
        friendService.addFriend(widget.user, id);
      }
    } finally {
      setState(() => loading = false);
    }
  }

  FriendModel? getFriend() {
    return friendService.friends.cast<FriendModel?>().firstWhere(
          (element) => element?.userId == widget.user.id,
          orElse: () => null,
        );
  }

  FriendModel? getPending() {
    return friendService.pendings.cast<FriendModel?>().firstWhere(
          (element) => element?.userId == widget.user.id,
          orElse: () => null,
        );
  }
}
