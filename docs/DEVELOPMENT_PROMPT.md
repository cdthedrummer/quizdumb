# QuizDumb Development Prompt

Repository: https://github.com/cdthedrummer/quizdumb

## Guidelines for Development

### Response Length Management
- Keep individual file updates under 200 lines when possible
- Break larger changes into multiple commits
- Focus on one component or feature at a time
- Use separate messages for different types of changes

### Component Development
1. Review existing components first
2. Reuse patterns and styles
3. Keep new components focused and minimal
4. Test in isolation before integration

### Repository Structure
```
lib/
  ├── data/           # Question and content data
  ├── models/         # Core data models
  ├── screens/        # Main screen widgets
  │   ├── quiz/       # Quiz flow screens
  │   └── results/    # Results screens
  ├── widgets/        # Shared widgets
  └── main.dart       # App entry point
```

### Recent Changes
1. Question Model:
   - Added scale labels
   - Support for rich answers
   - Flexible question types

2. State Management:
   - Improved type safety
   - Better null handling
   - Cleaner state updates

3. UI Components:
   - Consistent styling
   - Better animations
   - Modular structure

### Focus Areas
1. Question Updates:
   - Implement 16 Personalities style scales
   - Add rich answer formats
   - Update question content

2. Results Enhancement:
   - Add image placeholders
   - Improve results display
   - Consider achievements

3. Quiz Flow:
   - Add encouragement messages
   - Implement progress insights
   - Polish transitions

### Development Process
1. Always check existing implementations
2. Keep changes minimal and focused
3. Test components in isolation
4. Update documentation
5. Verify changes in repository

Remember:
- Ignore GitHub API errors in responses
- Keep implementations Flutter/Dart focused
- Test all changes locally first
- Document significant updates