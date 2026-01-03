# Continuous Integration (CI/CD)

## GitHub Actions

This repository uses GitHub Actions to automatically run tests on every push to the `main` branch.

## What Runs Automatically

### On Every Push to Backend
When you push changes to the `backend/` directory, GitHub Actions will:

1. **Test Event Creation** (`test_event_creation.py`)
   - Tests all event creation scenarios
   - Runs against deployed environment
   - 10 test cases covering edge cases

2. **Test Follow System** (`test_follow_system.py`)
   - Tests follow/unfollow functionality
   - Tests bidirectional relationships
   - Validates follower/following counts

## Workflow File

Location: `.github/workflows/test.yml`

### Triggers
Tests run when:
- ✅ You push to `main` branch
- ✅ You create a Pull Request to `main`
- ✅ Changes are made to `backend/**` files
- ✅ Changes are made to the workflow file itself

### Jobs
- **test-event-creation**: Runs event creation tests against deployed backend
- **test-follow-system**: Runs follow system tests

## Viewing Test Results

### In GitHub:
1. Go to your repository: https://github.com/Gyxius/Props
2. Click the "Actions" tab
3. See all workflow runs and their results

### Status Badge (Optional)
Add this to your README.md to show test status:
```markdown
![Tests](https://github.com/Gyxius/Props/actions/workflows/test.yml/badge.svg)
```

## Local Testing

Before pushing, you can run tests locally:

```bash
# Test event creation
cd backend
python3 test_event_creation.py --deployed

# Test follow system
python3 test_follow_system.py
```

## What Happens on Failure

If tests fail:
- ❌ GitHub will show a red ❌ next to the commit
- 📧 You'll receive an email notification (if enabled)
- 🚫 The commit will be marked as failed (but still pushed)
- 📊 You can view detailed logs in the Actions tab

## What Happens on Success

If tests pass:
- ✅ GitHub will show a green ✓ next to the commit
- 👍 You know your code works correctly
- 🚀 Safe to deploy!

## Adding More Tests

To add new tests to the workflow:

1. Create a new test file in `backend/` (e.g., `test_new_feature.py`)
2. Edit `.github/workflows/test.yml`
3. Add a new job:

```yaml
  test-new-feature:
    name: Test New Feature
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          submodules: recursive
      
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          cd backend
          pip install -r requirements.txt
      
      - name: Run New Feature Tests
        run: |
          cd backend
          python3 test_new_feature.py --deployed
```

## Environment Variables (If Needed)

If tests need API keys or secrets:

1. Go to GitHub → Settings → Secrets and variables → Actions
2. Add secrets (e.g., `API_KEY`, `DATABASE_URL`)
3. Use in workflow:

```yaml
      - name: Run Tests
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: |
          python3 test_something.py
```

## Cost

GitHub Actions is FREE for public repositories with:
- ✅ Unlimited minutes
- ✅ Unlimited builds
- ✅ Concurrent jobs

For private repos: 2,000 free minutes/month

## Disabling Tests

To temporarily disable automatic tests:

1. Go to `.github/workflows/test.yml`
2. Comment out the `on:` triggers:

```yaml
# on:
#   push:
#     branches: [ main ]
```

Or delete the workflow file entirely.

## Best Practices

1. ✅ Keep tests fast (< 5 minutes ideal)
2. ✅ Test against deployed environment for integration tests
3. ✅ Use local tests for unit tests
4. ✅ Clean up test data after tests
5. ✅ Use descriptive job names
6. ✅ Add comments to workflow file

## Troubleshooting

### Tests fail in CI but pass locally
- Check Python version (CI uses 3.11)
- Check dependencies in requirements.txt
- Check environment differences

### Workflow doesn't trigger
- Verify file is in `.github/workflows/`
- Check file extension is `.yml` or `.yaml`
- Verify indentation is correct (YAML is whitespace-sensitive)
- Check if changes were pushed to `backend/` directory

### Need more info?
Check GitHub Actions logs in the Actions tab for detailed error messages.
