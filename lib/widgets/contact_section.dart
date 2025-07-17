import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';
  bool messageSent = false;
  bool error = false;

  Future<void> _submitForm() async {
    final url = Uri.parse('https://formspree.io/f/mvgzjelp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: '{"name": "$name", "email": "$email", "message": "$message"}',
      );

      if (response.statusCode == 200) {
        setState(() {
          messageSent = true;
          error = false;
          name = '';
          email = '';
          message = '';
        });

        Future.delayed(const Duration(seconds: 3), () {
          setState(() => messageSent = false);
        });
      } else {
        setState(() => error = true);
      }
    } catch (e) {
      setState(() => error = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.black,
      child: Column(
        children: [
          Text("Get in Touch",
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

          const SizedBox(height: 30),

          if (messageSent)
            Text("✨ Message Sent Successfully!",
              style: _glowTextStyle(),
            ).animate().fadeOut(duration: 2.seconds, delay: 1.seconds),

          if (error)
            Text("❌ Failed to send message. Try again later!",
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ).animate().fadeOut(duration: 2.seconds, delay: 1.seconds),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left: Contact Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Contact Info",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                      ),
                    ).animate().fadeIn().slideX(begin: -0.2),

                    const SizedBox(height: 16),
                    contactRow(Icons.email, "affan.work05@gmail.com"),
                    contactRow(Icons.phone, "+92 312 8538773"),
                    contactRow(Icons.location_pin, "Karachi, Pakistan"),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              /// Right: Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(
                        label: "Name",
                        onChanged: (val) => setState(() => name = val),
                        value: name,
                      ),
                      buildTextField(
                        label: "Email",
                        onChanged: (val) => setState(() => email = val),
                        value: email,
                      ),
                      buildTextField(
                        label: "Message",
                        maxLines: 4,
                        onChanged: (val) => setState(() => message = val),
                        value: message,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 12,
                        ),
                        icon: const Icon(Icons.send),
                        label: const Text("Send Message"),
                      ).animate().scale(duration: 300.ms).fadeIn(),
                    ],
                  ),
                ).animate().slideX(begin: 0.2).fadeIn(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required Function(String) onChanged,
    required String value,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.cyan),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.cyanAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.cyan),
          ),
          filled: true,
          fillColor: Colors.grey[900],
        ),
        onChanged: onChanged,
        maxLines: maxLines,
        initialValue: value,
        validator: (val) =>
            val == null || val.isEmpty ? 'This field is required' : null,
      ),
    );
  }

  TextStyle _glowTextStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [
        Shadow(blurRadius: 4, color: Colors.cyanAccent, offset: Offset(0, 0)),
        Shadow(blurRadius: 8, color: Colors.cyanAccent, offset: Offset(0, 0)),
      ],
    );
  }
}
