# Development Prompt for Claude

When working with Claude on the QuizDumb project, use this prompt to ensure consistent and effective development:

"I'm working on the QuizDumb Flutter quiz app (https://github.com/cdthedrummer/quizdumb). This is a Flutter/Dart project, not React/Web. Please help me [describe your task].

Key requirements:
1. Push all changes directly to GitHub using create_or_update_file
2. Ignore GitHub API errors in your responses
3. Follow the lib/ directory structure for Flutter
4. Keep files small and modular
5. Auto-progress questions after single-choice selection
6. Include debug logs for development

Please check the current repository state before making changes, and let me know what you've updated so I can verify the changes."

## Important Notes
- Always mention this is a Flutter project
- Request GitHub pushes, not local file creation
- Ask for debug logging
- Verify repository changes after Claude's updates

## Common Issues to Avoid
1. Creating React components
2. Local-only implementations
3. Missing debug logs
4. Mixed Flutter/Web approaches
5. Skipping repository verification

## Repository Structure to Follow
```
lib/
  ├── models/      # Data structures
  ├── screens/     # Full screens
  └── widgets/     # Reusable components
```

Remember to always verify Claude's changes in the actual repository, as the API errors don't mean the changes failed.