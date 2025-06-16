import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worktracker/core/utils/constants/vectors.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height,
          minWidth: MediaQuery.sizeOf(context).width,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppVectors.maintenance,
              width: MediaQuery.sizeOf(context).width * 0.8,
            ),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Saat ini kami sedang melakukan maintenance untuk memberikan pengalaman yang lebih baik. Mohon bersabar ya — tim kami sedang bekerja keras agar semuanya kembali normal secepat mungkin!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
