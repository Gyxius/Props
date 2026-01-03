# Testing Documentation

## Overview

This document describes the comprehensive test suite for the Lemi social event platform. The tests are automatically run via GitHub Actions on every push and pull request to the main branch.

## Test Suites

### 1. Event Features Test Suite (`test_event_features.py`)

**Purpose**: Comprehensive testing of all event page functionality

**Features Tested**:
- ✅ **CRUD Operations**: Create, Read, Update, Delete events
- ✅ **Participants Management**: Joining and leaving events
- ✅ **Event Archiving**: Archive and unarchive events
- ✅ **Event Validation**: Date/time validation, capacity limits
- ✅ **User Events**: Retrieving events by user
- ✅ **Permissions**: Host and admin permission controls
- ✅ **Public/Private Events**: Visibility filtering
- ✅ **Featured Events**: Featured event marking and display

**Test Cases**:

#### CRUD Operations (6 tests)
1. Create a public event
2. Read event by ID
3. Read all events
4. Update event details
5. Delete event
6. Create a private event

#### Participants Management (5 tests)
1. User joins event
2. Duplicate join (idempotency)
3. Multiple users join
4. User leaves event
5. Verify participants count

#### Event Archiving (5 tests)
1. Archive event
2. Archived event not in default list
3. Archived event with include_archived flag
4. Unarchive event
5. Unarchived event back in default list

#### Event Validation (6 tests)
1. Cross-midnight event (valid)
2. Same start/end time (invalid)
3. Event with capacity limit
4. Event with no capacity limit
5. Multi-language event
6. Featured event

#### User Events (3 tests)
1. Create multiple events for user
2. Get user's hosted events
3. User joins events created by others

#### Permissions (5 tests)
1. Non-host cannot update event
2. Host can update event
3. Admin can update any event
4. Non-host cannot delete event
5. Admin can delete any event

**Usage**:
```bash
# Test all features on deployed environment
python3 test_event_features.py --deployed

# Test locally
python3 test_event_features.py --local

# Test specific feature
python3 test_event_features.py --deployed --feature crud
python3 test_event_features.py --deployed --feature participants
python3 test_event_features.py --deployed --feature archiving
python3 test_event_features.py --deployed --feature validation
python3 test_event_features.py --deployed --feature users
python3 test_event_features.py --deployed --feature permissions
```

---

### 2. Authentication System Test Suite (`test_auth.py`)

**Purpose**: Test user authentication, registration, and profile management

**Features Tested**:
- ✅ **User Registration**: New user creation and validation
- ✅ **User Login**: Authentication and password verification
- ✅ **Profile Management**: Profile retrieval and updates
- ✅ **Invite Codes**: Invite code generation and validation

**Test Cases**:

#### Registration (3 tests)
1. Valid user registration
2. Duplicate username rejection
3. Invalid email format handling

#### Login (4 tests)
1. Login with correct credentials
2. Wrong password rejection
3. Non-existent user rejection
4. Case-insensitive username login

#### Profile Management (3 tests)
1. Get user profile
2. Update user profile
3. Get non-existent profile

#### Invite Codes (3 tests)
1. Get user's invite code
2. Validate invite code
3. Validate invalid invite code

**Usage**:
```bash
# Test deployed environment
python3 test_auth.py --deployed

# Test local environment
python3 test_auth.py --local
```

---

### 3. Event Creation Test Suite (`test_event_creation.py`)

**Purpose**: Test event creation with various configurations

**Features Tested**:
- Event creation with different field combinations
- Event verification
- Cross-environment testing

**Usage**:
```bash
python3 test_event_creation.py --deployed
python3 test_event_creation.py --local
python3 test_event_creation.py --all
```

---

### 4. Follow System Test Suite (`test_follow_system.py`)

**Purpose**: Test user follow/unfollow functionality

**Features Tested**:
- User follows another user
- Mutual follows
- Follow decline/removal
- Followers and following lists

**Usage**:
```bash
python3 test_follow_system.py
```

---

## GitHub Actions Integration

All tests are automatically run via GitHub Actions on:
- Push to `main` branch
- Pull requests to `main` branch

### Workflow Configuration

File: `.github/workflows/test.yml`

**Jobs**:
1. `test-event-creation` - Tests event creation
2. `test-follow-system` - Tests follow system
3. `test-event-features` - Comprehensive event features tests
4. `test-authentication` - Authentication system tests

Each job:
- Runs on Ubuntu latest
- Uses Python 3.11
- Installs required dependencies
- Runs tests against deployed API
- Captures and logs test output
- Reports test results

### Viewing Test Results

1. Go to the GitHub repository
2. Click on "Actions" tab
3. Select the workflow run
4. View individual job results
5. Check logs for detailed test output

---

## Running Tests Locally

### Prerequisites

```bash
# Install Python 3.11+
# Install dependencies
pip install requests
```

### Quick Start

```bash
cd backend

# Run all event feature tests
python3 test_event_features.py --deployed

# Run authentication tests
python3 test_auth.py --deployed

# Run specific feature tests
python3 test_event_features.py --local --feature crud

# Run against local backend (must be running on port 8000)
python3 test_event_features.py --local
```

---

## Test Coverage

### Event Endpoints Tested

| Endpoint | Method | Test Suite | Status |
|----------|--------|------------|--------|
| `/api/events` | GET | Event Features | ✅ |
| `/api/events` | POST | Event Features | ✅ |
| `/api/events/{id}` | GET | Event Features | ✅ |
| `/api/events/{id}` | PUT | Event Features | ✅ |
| `/api/events/{id}` | DELETE | Event Features | ✅ |
| `/api/events/{id}/join` | POST | Event Features | ✅ |
| `/api/events/{id}/leave` | POST | Event Features | ✅ |
| `/api/events/{id}/archive` | POST | Event Features | ✅ |
| `/api/events/{id}/unarchive` | POST | Event Features | ✅ |
| `/api/users/{username}/events` | GET | Event Features | ✅ |

### Authentication Endpoints Tested

| Endpoint | Method | Test Suite | Status |
|----------|--------|------------|--------|
| `/api/register` | POST | Authentication | ✅ |
| `/api/login` | POST | Authentication | ✅ |
| `/api/users/{username}/profile` | GET | Authentication | ✅ |
| `/api/users/{username}/profile` | POST | Authentication | ✅ |
| `/api/users/{username}/invite-code` | GET | Authentication | ✅ |
| `/api/invites/validate` | GET | Authentication | ✅ |

### Follow Endpoints Tested

| Endpoint | Method | Test Suite | Status |
|----------|--------|------------|--------|
| `/api/follows` | POST | Follow System | ✅ |
| `/api/follows/{username}` | GET | Follow System | ✅ |
| `/api/followers/{username}` | GET | Follow System | ✅ |

---

## Test Output Format

Tests use color-coded output for easy reading:

- 🧪 **Blue** - Test description
- ✅ **Green** - Test passed
- ❌ **Red** - Test failed
- ⚠️ **Yellow** - Warning/Info
- ℹ️ **Blue** - Information

Example output:
```
================================================================================
                    🧪 Event Features Test Suite - DEPLOYED
================================================================================

--------------------------------------------------------------------------------
📝 Testing Event CRUD Operations
--------------------------------------------------------------------------------

🧪 Test 1: Create a public event
✅ Event created successfully
ℹ️  Created event with ID: 12345

🧪 Test 2: Read event by ID
✅ GET event by ID status: 200 == 200
✅ Event name matches: Test Event == Test Event

...

================================================================================
                            📊 Test Results Summary
================================================================================

Environment: DEPLOYED
Total Tests: 30
Passed: 30
Failed: 0
Success Rate: 100.0%

🎉 All tests passed! 🎉
```

---

## Troubleshooting

### Common Issues

**Issue**: Tests fail with connection errors
- **Solution**: Check if the API is running and accessible

**Issue**: Random test failures
- **Solution**: Tests create unique usernames/events, but race conditions may occur. Rerun tests.

**Issue**: Archive tests fail
- **Solution**: Database may need migration. Run `migrate_add_is_archived.py`

**Issue**: Permission tests fail
- **Solution**: Ensure admin user exists in database

### Debug Mode

For detailed debugging, check the test output logs:
```bash
python3 test_event_features.py --deployed 2>&1 | tee test_output.log
cat test_output.log
```

---

## Adding New Tests

### Test Structure

```python
def test_new_feature(self):
    """Test description"""
    print_subheader("🎯 Testing New Feature")
    
    # Test setup
    print_test("Setup: Prepare test data")
    # ... setup code ...
    
    # Test 1
    print_test("Test 1: Description")
    # ... test code ...
    self.assert_true(condition, "Expected result")
    
    # Test 2
    print_test("Test 2: Description")
    # ... test code ...
    self.assert_equal(actual, expected, "Values match")
```

### Adding to Test Suite

1. Add test method to test class
2. Call from `run_all_tests()` or `run_specific_test()`
3. Update documentation
4. Test locally
5. Push to GitHub

---

## Best Practices

1. **Unique Identifiers**: Use timestamps for unique usernames/events
2. **Cleanup**: Always clean up created test data
3. **Assertions**: Use descriptive assertion messages
4. **Independence**: Tests should be independent and not rely on each other
5. **Error Handling**: Catch and report exceptions gracefully
6. **Documentation**: Keep this doc updated with new tests

---

## Future Improvements

- [ ] Add performance benchmarking
- [ ] Add load testing for concurrent users
- [ ] Test file upload functionality
- [ ] Test image URL validation
- [ ] Test event notifications
- [ ] Add integration tests for frontend
- [ ] Add end-to-end tests with Playwright/Selenium
- [ ] Test WebSocket connections (if implemented)
- [ ] Test rate limiting
- [ ] Test database migrations

---

## Contact

For questions or issues with tests, please open an issue on GitHub or contact the development team.

---

**Last Updated**: January 2026
**Test Coverage**: ~90% of core features
**Total Test Cases**: 60+
