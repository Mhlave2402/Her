import 'package:flutter/material.dart';
import 'package:her_user_app/features/ride/models/premium_feature_model.dart';

class FeatureCardWidget extends StatelessWidget {
  final PremiumFeature feature;
  final bool isSelected;
  final VoidCallback onTap;

  const FeatureCardWidget({
    Key? key,
    required this.feature,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                feature.iconUrl,
                width: 40,
                height: 40,
              ),
              const SizedBox(height: 5),
              Text(
                feature.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
