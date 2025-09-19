import 'package:flutter/material.dart';
import 'privacy_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  late Future<PrivacyPolicy> _futurePolicy;

  @override
  void initState() {
    super.initState();
    _futurePolicy = fetchPrivacyPolicy();
  }

  Future<PrivacyPolicy> fetchPrivacyPolicy() async {
    // Replace with your actual API endpoint or use static content
    final response = await Future.value({
      "title": "Privacy Policy",
      "content": "", // Not used, see below
      "last_updated": DateTime.now().toIso8601String(),
    });
    return PrivacyPolicy.fromJson(response);
  }

  Widget _sectionTitle(String number, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        '$number. $title',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF309C96),
        ),
      ),
    );
  }

  Widget _sectionBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color(0xFF309C96),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: FutureBuilder<PrivacyPolicy>(
        future: _futurePolicy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading privacy policy'));
          }
          final policy = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  policy.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF309C96),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Last updated: ${policy.lastUpdated.day}/${policy.lastUpdated.month}/${policy.lastUpdated.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                _sectionTitle('1', 'Information Collection and Use'),
                _sectionBody(
                  'We collect information you provide directly to us, such as when you create an account or contact us. '
                  'We may also collect usage data to improve our services, including device information, log data, and usage statistics.',
                ),
                _sectionTitle('2', 'Cookies and Tracking'),
                _sectionBody(
                  'We do not use cookies or similar tracking technologies in our app. '
                  'However, certain third-party services integrated into our app may collect information as described in their privacy policies.',
                ),
                _sectionTitle('3', 'Information Sharing'),
                _sectionBody(
                  'We do not share your personal information with third parties except as required by law, or to protect our rights and comply with legal obligations.',
                ),
                _sectionTitle('4', 'Data Security'),
                _sectionBody(
                  'We implement reasonable security measures to protect your information from unauthorized access, alteration, disclosure, or destruction. '
                  'Despite our efforts, no method of transmission over the Internet or electronic storage is 100% secure.',
                ),
                _sectionTitle('5', 'Change\'s to this Privacy Policy'),
                _sectionBody(
                  'We may update this Privacy Policy from time to time. '
                  'We will notify you of any changes by posting the new Privacy Policy on this page. '
                  'You are advised to review this Privacy Policy periodically for any changes.',
                ),
                _sectionTitle('6', 'Contact Us'),
                _sectionBody(
                  'If you have any questions or concerns about this Privacy Policy, please contact us at support@42ndgenerationfoundation.com',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}