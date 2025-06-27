import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String skill;

  const ProfileCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(16),
      child: Text(
        '$name\nSkill: $skill',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ],
        ),
      ),
    );
  }
}
