import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'newsletter_model.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class NewsletterWidget extends StatefulWidget {
  const NewsletterWidget({Key? key}) : super(key: key);

  @override
  State<NewsletterWidget> createState() => _NewsletterWidgetState();
}

class _NewsletterWidgetState extends State<NewsletterWidget> {
  late Future<List<NewsletterArticle>> _futureArticles;
  int _currentIndex = 4; // 'More' tab is selected by default

  @override
  void initState() {
    super.initState();
    _futureArticles = fetchNewsletterArticles();
    // Show the subscribe modal after a short delay on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 600), () {
        _showSubscribeModal(context);
      });
    });
  }

  Future<List<NewsletterArticle>> fetchNewsletterArticles() async {
    // Replace with your actual API endpoint
    final response = await http.get(Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/newsletter'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => NewsletterArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load newsletters');
    }
  }

  Future<void> _showSubscribeModal(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _SubscribeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("God's Word For Today"),
        backgroundColor: const Color(0xFF309C96),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF7FAFA),
      body: FutureBuilder<List<NewsletterArticle>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final articles = snapshot.data ?? [];
          if (articles.isEmpty) {
            return const Center(child: Text('No newsletters available.'));
          }

          final latestArticles = articles.take(3).toList();
          final previousArticles = articles.skip(3).toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (latestArticles.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        latestArticles[0].image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: const Center(child: Icon(Icons.image, size: 60, color: Colors.grey)),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                    Text(
                    latestArticles.isNotEmpty &&
                        latestArticles.any((a) =>
                          a.date.year == DateTime.now().year &&
                          a.date.month == DateTime.now().month &&
                          a.date.day == DateTime.now().day)
                      ? "Today's Articles"
                      : "This Week's Articles",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF309C96),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 10),
                  ...latestArticles.map((article) => _ArticleCard(article: article)),
                  const SizedBox(height: 28),
                  if (previousArticles.isNotEmpty)
                    Text(
                      "Past Week's Articles",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ...previousArticles.map((article) => _ArticleListTile(article: article)),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF309C96),
        unselectedItemColor: const Color(0xFF616161),
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == _currentIndex) return;
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              context.goNamed('Home');
              break;
            case 1:
              context.goNamed('Magazines');
              break;
            case 2:
              context.goNamed('Books');
              break;
            case 3:
              context.goNamed('Events');
              break;
            case 4:
              context.goNamed('more');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Magazines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.podcasts_sharp),
            label: 'Events',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final NewsletterArticle article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              article.summary,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(article.date),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF309C96),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Read More'),
              onPressed: () async {
                await launchURL(article.link);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${_weekday(date.weekday)}, ${date.day}/${date.month}/${date.year}";
  }

  String _weekday(int weekday) {
    const days = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];
    return days[(weekday - 1) % 7];
  }
}

class _ArticleListTile extends StatelessWidget {
  final NewsletterArticle article;
  const _ArticleListTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          article.image,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(
            width: 56,
            height: 56,
            color: Colors.grey[200],
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        ),
      ),
      title: Text(
        article.title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        _formatDate(article.date),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF309C96),
          foregroundColor: Colors.white,
          minimumSize: const Size(80, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Read More', style: TextStyle(fontSize: 13)),
        onPressed: () async {
          await launchURL(article.link);
        },
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(article.title),
            content: SingleChildScrollView(child: Text(article.summary)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

class _SubscribeDialog extends StatefulWidget {
  @override
  State<_SubscribeDialog> createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<_SubscribeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _loading = false;
  String? _error;
  String? _success;

  Future<void> _subscribe() async {
    setState(() {
      _loading = true;
      _error = null;
      _success = null;
    });
    final firstName = _firstNameController.text.trim();
    final email = _emailController.text.trim();

    final apiKey = dotenv.env['API_KEY'];
    const apiUrl = 'https://api.brevo.com/v3/smtp/email';

    final body = {
      "sender": {
        "name": "New God's word for today subscriber",
        "email": "no-reply@42ndgenerationfoundation.com"
      },
      "to": [
        {
          "email": "favour.adeshina@42ndgenerationfoundation.com",
          "name": "Favour Adeshina"
        }
      ],
      "subject": "New Newsletter Subscription",
      "htmlContent":
          "<p>New user with <strong>First Name:</strong> $firstName<br><strong>and Email:</strong> $email just subscribed to the newsletter.</p>"
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
            'accept': 'application/json',
            'api-key': dotenv.env['API_KEY'] ?? '',
          'content-type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 201) {
        setState(() {
          _success = "Thank you for subscribing!";
        });
      } else {
        setState(() {
          _error = "Failed to subscribe. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _error = "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Subscribe to our Newsletter"),
      content: _success != null
          ? SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  _success!,
                  style: const TextStyle(color: Color(0xFF309C96), fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: "First Name"),
                    validator: (v) => v == null || v.trim().isEmpty ? "Enter your first name" : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email Address"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return "Enter your email";
                      final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                      if (!emailRegex.hasMatch(v.trim())) return "Enter a valid email";
                      return null;
                    },
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(_error!, style: const TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ),
      actions: [
        if (_success == null)
          TextButton(
            onPressed: _loading ? null : () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        if (_success == null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF309C96),
              foregroundColor: Colors.white,
            ),
            onPressed: _loading
          ? null
          : () {
              if (_formKey.currentState?.validate() ?? false) {
                _subscribe();
              }
            },
            child: _loading
          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
          : const Text("Subscribe"),
          ),
        if (_success != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
      ],
    );
  }
}
