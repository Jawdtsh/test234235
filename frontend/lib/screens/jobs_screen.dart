import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/job_service.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final JobService _jobService = JobService();
  List<Job> _jobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    try {
      final jobs = await _jobService.getJobs();
      setState(() {
        _jobs = jobs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Jobs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filters
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadJobs,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _jobs.length,
                itemBuilder: (context, index) {
                  final job = _jobs[index];
                  return JobCard(job: job);
                },
              ),
            ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/job-details', arguments: job);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                job.company,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(job.location),
                  const SizedBox(width: 16),
                  const Icon(Icons.work_outline, size: 16),
                  const SizedBox(width: 4),
                  Text(job.type),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: job.skills.map((skill) {
                  return Chip(
                    label: Text(
                      skill,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
