import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatDetailPage extends StatefulWidget {
  final String chefName;
  final String imagePath;

  const ChatDetailPage({
    Key? key,
    required this.chefName,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<Map<String, dynamic>> _messages = [];

  bool _isTyping = false;
  bool _isEmojiVisible = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.trim().isNotEmpty;
      });
    });

    _messages.addAll([
      {
        'isMe': false,
        'message': "Hail.. ada yang bisa dibantu??",
        'time': "10:00 AM",
        'isImage': false,
      },
      {
        'isMe': true,
        'message': "Saya mau buat nasi goreng, tapi pakai mie bisa ga chef??",
        'time': "10:02 AM",
        'isImage': false,
      },
      {
        'isMe': false,
        'message': "Buat mie goreng aja bang ♦♠",
        'time': "10:03 AM",
        'isImage': false,
      },
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'isMe': true,
        'message': text,
        'time': _getCurrentTime(),
        'isImage': false,
      });
      _controller.clear();
    });

    _scrollToBottom();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 70);

    if (picked != null) {
      setState(() {
        _messages.add({
          'isMe': true,
          'message': picked.path,
          'time': _getCurrentTime(),
          'isImage': true,
        });
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return "$hour:${now.minute.toString().padLeft(2, '0')} $period";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.imagePath),
              radius: screenWidth * 0.05,
            ),
            const SizedBox(width: 10),
            Text(widget.chefName),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Cari':
                  // TODO: Implementasi fitur cari
                  break;
                case 'Hapus pesan':
                  // TODO: Hapus semua pesan
                  setState(() => _messages.clear());
                  break;
                case 'Tema chat':
                  // TODO: Ganti tema
                  break;
                case 'Laporkan':
                  // TODO: Laporkan pengguna
                  break;
                case 'Media, Tautan, dan Dokumen':
                  // TODO: Tampilkan media
                  break;
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'Cari', child: Text('Cari')),
                  const PopupMenuItem(
                    value: 'Hapus pesan',
                    child: Text('Hapus pesan'),
                  ),
                  const PopupMenuItem(
                    value: 'Tema chat',
                    child: Text('Tema chat'),
                  ),
                  const PopupMenuItem(
                    value: 'Laporkan',
                    child: Text('Laporkan'),
                  ),
                  const PopupMenuItem(
                    value: 'Media, Tautan, dan Dokumen',
                    child: Text('Media, Tautan, dan Dokumen'),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(
                  isMe: msg['isMe'],
                  message: msg['message'],
                  time: msg['time'],
                  isImage: msg['isImage'],
                );
              },
            ),
          ),
          _buildInputArea(),
          if (_isEmojiVisible)
            SizedBox(
              height: 250,
              child: SimpleEmojiPicker(
                onEmojiSelected: (emoji) {
                  setState(() {
                    _controller.text += emoji;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controller.text.length),
                    );
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.emoji_emotions, color: Colors.orange),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  setState(() => _isEmojiVisible = !_isEmojiVisible);
                },
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onTap: () {
                    if (_isEmojiVisible) {
                      setState(() => _isEmojiVisible = false);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Tulis pesan...",
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _isTyping
                  ? IconButton(
                    icon: const Icon(Icons.send, color: Colors.orange),
                    onPressed: _sendMessage,
                  )
                  : Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.orange,
                        ),
                        onPressed: () => _pickImage(ImageSource.camera),
                        tooltip: 'Kamera',
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.orange,
                        ),
                        onPressed: () => _pickImage(ImageSource.gallery),
                        tooltip: 'Galeri',
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble({
    required bool isMe,
    required String message,
    required String time,
    required bool isImage,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isMe ? Colors.orange[100] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft:
                isMe ? const Radius.circular(16) : const Radius.circular(0),
            bottomRight:
                isMe ? const Radius.circular(0) : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            isImage
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(message), width: 200),
                )
                : Text(message, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class SimpleEmojiPicker extends StatelessWidget {
  final void Function(String emoji) onEmojiSelected;

  const SimpleEmojiPicker({super.key, required this.onEmojiSelected});

  final List<String> emojis = const [
    '😀',
    '😁',
    '😂',
    '🤣',
    '😍',
    '😎',
    '😢',
    '😡',
    '👍',
    '🙏',
    '🍕',
    '🍔',
    '❤️',
    '🔥',
    '😴',
    '👏',
    '🎉',
    '🤔',
    '😇',
    '💡',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      padding: const EdgeInsets.all(8),
      children:
          emojis.map((emoji) {
            return GestureDetector(
              onTap: () => onEmojiSelected(emoji),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
            );
          }).toList(),
    );
  }
}
