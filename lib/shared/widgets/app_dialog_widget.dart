import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worktracker/core/utils/constants/colors.dart';

class AppDialogWidget {
  AppDialogWidget._();

  static Future<void> show({
    required bool isDismissible,
    required BuildContext context,
    required String vectorImagePath,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Future<void> Function()? onConfirm,
    VoidCallback? onCancel,
  }) async {
    await showDialog<void>(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.bottomCenter,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(vectorImagePath, width: 150),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  if (onConfirm != null && confirmText != null) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: onConfirm,
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  if (onCancel != null && cancelText != null) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: onCancel,
                        child: Text(cancelText),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
