import 'package:flutter/material.dart';

import '../network/api_response.dart';

class ApiActionButton<T> extends StatefulWidget {
  final String title;

  /// Actual API/Repository call
  final Future<ApiResponse<T>> Function() onCall;

  /// API success hone ke baad
  final void Function(T? data)? onSuccess;

  /// API fail hone ke baad
  final void Function(String message)? onError;

  final String successMessage;

  const ApiActionButton({
    super.key,
    required this.title,
    required this.onCall,
    this.onSuccess,
    this.onError,
    this.successMessage = 'Success',
  });

  @override
  State<ApiActionButton<T>> createState() =>
      _ApiActionButtonState<T>();
}

class _ApiActionButtonState<T>
    extends State<ApiActionButton<T>> {
  bool _isLoading = false;

  Future<void> _handleClick() async {
    // Prevent double click
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await widget.onCall();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // SUCCESS
    if (response.success) {
      _showResultDialog(
        success: true,
        message:
        response.message ?? widget.successMessage,
        onContinue: () {
          widget.onSuccess?.call(response.data);
        },
      );

      return;
    }

    // ERROR
    final message =
        response.message ?? 'Something went wrong';

    _showResultDialog(
      success: false,
      message: message,
      onContinue: () {
        widget.onError?.call(message);
      },
    );
  }

  void _showResultDialog({
    required bool success,
    required String message,
    required VoidCallback onContinue,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                success
                    ? Icons.check_circle
                    : Icons.error,
                size: 60,
                color: success
                    ? Colors.green
                    : Colors.red,
              ),

              const SizedBox(height: 16),

              Text(
                success ? 'Success' : 'Error',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                onContinue();
              },
              child: Text(
                success ? 'Continue' : 'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // Disable button while API is running
        onPressed: _isLoading ? null : _handleClick,

        child: _isLoading
            ? const Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),

            SizedBox(width: 12),

            Text('Please wait...'),
          ],
        )
            : Text(widget.title),
      ),
    );
  }
}