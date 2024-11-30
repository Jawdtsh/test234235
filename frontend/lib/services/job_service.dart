import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job.dart';
import 'auth_service.dart';

class JobService {
  final String baseUrl = 'http://localhost:5000/api';
  final AuthService _authService = AuthService();

  Future<List<Job>> getJobs() async {
    try {
      final token = await _authService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/jobs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((job) => Job.fromJson(job)).toList();
      }
      throw Exception('Failed to load jobs');
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }

  Future<Job> getJobDetails(String jobId) async {
    try {
      final token = await _authService.getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/jobs/$jobId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Job.fromJson(data);
      }
      throw Exception('Failed to load job details');
    } catch (e) {
      throw Exception('Failed to load job details: $e');
    }
  }
}
