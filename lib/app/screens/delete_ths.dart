import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class DeleteThis extends StatelessWidget {
  const DeleteThis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            context.read<AppBloc>().add(AppLogoutRequested());
          },
          child: Row(
            children: [
              SvgPicture.asset(AppIcon.logout),
              SizedBox(width: 5.w),
              const Text("Logout"),
            ],
          ),
        ),
      ),
    );
  }
}
