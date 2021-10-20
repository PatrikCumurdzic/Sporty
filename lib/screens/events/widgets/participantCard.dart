import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/profile/widgets/playerProfile.dart';

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({Key key, this.participant}) : super(key: key);
  final User participant;
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Row Widget...
        Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: participant.imagePath != null
                ? Image.network(
                    participant.imagePath ??
                        'https://picsum.photos/seed/795/600',
                    fit: BoxFit.fill,
                  )
                : Image.asset('assets/images/no_image.png'),
          ),
          Text(
            participant.name,
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => PlayerProfile(
                    playerData: participant,
                  )),
              child: Text("View"))
        ],
      ),
    );
  }
}
