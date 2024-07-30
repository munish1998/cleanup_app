import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cleanup_mobile/Models/detailtaskModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Replace with your actual API base URL
const String baseUrl = 'https://webpristine.com/cleanup/public/';

class DetailTaskScreen extends StatefulWidget {
  final int taskId;

  const DetailTaskScreen({super.key, required this.taskId});

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  Taskk? _task;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  Future<void> _fetchTaskDetails() async {
    var url = Uri.parse('${baseUrl}api/auth/task/view-task/${widget.taskId}');

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString('accessTokenKey');

    // Log the access token
    log('Access Token: $accessToken');

    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      log('Response body: ${response.body}');
      log('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success'] == true) {
          setState(() {
            _task = Taskk.fromJson(result['task']);
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          _showError(result['message'] ?? 'Failed to fetch task details');
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        _showError('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('An error occurred');
      log('Error: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _task != null
              ? _buildTaskDetails()
              : Center(child: Text('No task details available')),
    );
  }

  Widget _buildTaskDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title: ${_task!.title}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Location: ${_task!.location}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Description: ${_task!.description}',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Status: ${_task!.status}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          if (_task!.beforeImageUrl.isNotEmpty)
            Image.network(
                '${baseUrl}assets/images/tasks/${_task!.beforeImageUrl}'),
          SizedBox(height: 16),
          if (_task!.afterImageUrl.isNotEmpty)
            Image.network(
                '${baseUrl}assets/images/tasks/${_task!.afterImageUrl}'),
        ],
      ),
    );
  }
}
