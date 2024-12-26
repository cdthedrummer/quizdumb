# Development Workflow Reference

## Repository Information
Repository: https://github.com/cdthedrummer/quizp

## Tools Used
- VS Code as primary IDE
- Flutter SDK (3.27.1+)
- Android Studio (optional, for emulator)

## Development Setup
1. Install Flutter SDK
2. Install VS Code with Flutter extension
3. Clone repository:
   ```bash
   git clone https://github.com/cdthedrummer/quizp.git
   cd quizp
   flutter pub get
   ```

## Daily Workflow
### Getting Latest Changes
```bash
# In VS Code terminal
cd quizp
git pull origin main
flutter pub get     # If dependencies changed
```

### Running the App
```bash
flutter devices     # List available devices
flutter run         # Run on default device
```

### Making Changes
1. Make code changes
2. Test using hot reload (press 'r' in terminal)
3. Commit changes in VS Code:
   - Open Source Control panel (Ctrl+Shift+G)
   - Stage changes (+)
   - Enter commit message
   - Click ✓ to commit
4. Push changes:
   - Click sync/push button in bottom bar
   OR
   - Use terminal: `git push origin main`

### Debugging Commands
```bash
r                   # Hot reload
R                   # Hot restart
Ctrl+C             # Stop app
flutter clean      # Clean build files
flutter pub get    # Update dependencies
```

## Best Practices
1. Pull before starting work
2. Test changes before pushing
3. Use meaningful commit messages
4. Keep dependencies minimal
5. Document significant changes

## Troubleshooting
- If build fails: `flutter clean && flutter pub get`
- If device not found: `flutter doctor`
- If VS Code isn't recognizing Flutter: Reload Window
