#!/bin/bash
# Quick Test Runner Script
# This script runs all the main test suites

echo "=========================================="
echo "  Lemi Backend Test Suite Runner"
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Change to backend directory
cd backend || exit 1

# Function to run a test
run_test() {
    TEST_NAME=$1
    TEST_FILE=$2
    TEST_ARGS=$3
    
    echo ""
    echo -e "${BLUE}=========================================="
    echo "Running: $TEST_NAME"
    echo -e "==========================================${NC}"
    echo ""
    
    if [ -f "$TEST_FILE" ]; then
        if python3 "$TEST_FILE" $TEST_ARGS; then
            echo -e "${GREEN}✅ $TEST_NAME PASSED${NC}"
            return 0
        else
            echo -e "${RED}❌ $TEST_NAME FAILED${NC}"
            return 1
        fi
    else
        echo -e "${RED}❌ Test file not found: $TEST_FILE${NC}"
        return 1
    fi
}

# Parse arguments
ENV="--deployed"
FEATURE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --local)
            ENV="--local"
            shift
            ;;
        --deployed)
            ENV="--deployed"
            shift
            ;;
        --feature)
            FEATURE="--feature $2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: ./run_tests.sh [--local|--deployed] [--feature <feature_name>]"
            exit 1
            ;;
    esac
done

echo "Environment: $ENV"
if [ -n "$FEATURE" ]; then
    echo "Feature: $FEATURE"
fi
echo ""

# Track results
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Run Event Features Tests
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if run_test "Event Features" "test_event_features.py" "$ENV $FEATURE"; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi

# Run Authentication Tests (only if no specific feature requested)
if [ -z "$FEATURE" ]; then
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if run_test "Authentication" "test_auth.py" "$ENV"; then
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    
    # Run Event Creation Tests
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    if run_test "Event Creation" "test_event_creation.py" "$ENV"; then
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
fi

# Print Summary
echo ""
echo "=========================================="
echo "  Test Suite Summary"
echo "=========================================="
echo "Total Test Suites: $TOTAL_TESTS"
echo -e "${GREEN}Passed: $PASSED_TESTS${NC}"
echo -e "${RED}Failed: $FAILED_TESTS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}🎉 All test suites passed! 🎉${NC}"
    exit 0
else
    echo -e "${RED}⚠️  Some test suites failed${NC}"
    exit 1
fi
