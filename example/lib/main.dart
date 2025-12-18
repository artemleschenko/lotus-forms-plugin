import 'package:flutter/material.dart';
import 'package:lotus_forms_package/lotus_forms_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DynamicForms(
          formId: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
          jwtToken:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzaWQiOiIzY2I4YmU0Yi1kNzE0LTQzNjUtYjRlNi0xNDVmOTAzOTBiYWYiLCJzdWIiOiJsb3R1cy10ZXN0K2Zmd0Bpbm5vd2lzZS5jb20iLCJqdGkiOiI2YTg2YzUxYS1lY2Q4LTRmODUtYWQ0Yy0xZDlmNTUzNTg4ZGYiLCJnaXZlbl9uYW1lIjoiRmllbGQiLCJmYW1pbHlfbmFtZSI6IldvcmtlciIsImlzRmllbGRXb3JrZXIiOiJUcnVlIiwidmVuZG9ySWQiOiJhMTMwY2M0Zi1jODVkLTRiNTgtOTMzMC1mNjk4MGUzY2ViMzMiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJGVyIsInBlcm1pc3Npb25zIjpbIkNhc2UuV3JpdGVDYXNlc05vdGVzIiwiQXZhaWxhYmlsaXR5LlZpZXdEZXRhaWxzIiwiQ2FzZS5SZWFkQ2FzZXNOb3RlcyIsIkNhc2UuV3JpdGVNZWRpY2FpZElkIiwiQXR0ZW1wdC5WaWV3UmVtaW5kZXJzIiwiQXZhaWxhYmlsaXR5Lkxpc3QiLCJNZW1iZXIuTWFpbkluZm9ybWF0aW9uIiwiQ2FzZS5SZWFkTm90ZXMiLCJDYXNlLkxpc3QiLCJDYXNlLlJlZnVzZVNlcnZpY2UiLCJDYWxlbmRhci5TZWVDYWxlbmRhciIsIkF0dGVtcHQuTGlzdCIsIkNhc2UuQWRkU2VydmljZSIsIk1lbWJlci5WaWV3RGV0YWlscyIsIkNhc2UuTWFpbkluZm9ybWF0aW9uIiwiQ2FsZW5kYXIuQ3JlYXRlQXZhaWxhYmlsaXR5IiwiQ2FzZS5WaWV3RGV0YWlscyIsIkNhc2UuU2VlRG9jdW1lbnRzIiwiQXR0ZW1wdC5DcmVhdGUiLCJDYXNlLkVkaXQiLCJNZW1iZXIuVmlld0NhcmREZXRhaWxzIiwiQ2FzZS5SZWFkTWVkaWNhaWRJZCJdLCJuYmYiOjE3NjU5NjM1MzYsImV4cCI6MTc2NTk2NDQzNiwiaXNzIjoiWW91clRlc3RJc3N1ZXIiLCJhdWQiOiJZb3VyVGVzdEF1ZGllbmNlIn0.M8ifKcCc_3g61yTdKDGQsFOxIZLXZgPqTRBDNUyhQzw',
        ),
      ),
    );
  }
}
