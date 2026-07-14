# Define the default action when running just 'make'
.PHONY: default help build test clean

default: help

help:
	@echo "================================================================"
	@echo "                     PUREHABITS WORKFLOW                       "
	@echo "================================================================"
	@echo "Available commands:"
	@echo "  make build      - Compiles the iOS project using xcodebuild"
	@echo "  make test       - Runs the Swift Testing / Unit Test suite"
	@echo "  make clean      - Cleans Xcode build artifacts & DerivedData"
	@echo "================================================================"

build:
	@echo "🛠️  Building PureHabits project..."
	xcodebuild -project PureHabits.xcodeproj \
		-scheme PureHabits \
		-destination 'platform=iOS Simulator,name=iPhone 15' \
		build

test:
	@echo "🧪 Running unit tests (Swift Testing)..."
	xcodebuild -project PureHabits.xcodeproj \
		-scheme PureHabits \
		-destination 'platform=iOS Simulator,name=iPhone 15' \
		test

clean:
	@echo "🧹 Cleaning Xcode build folder and temporary files..."
	xcodebuild -project PureHabits.xcodeproj -scheme PureHabits clean
	rm -rf build/ DerivedData/
	@echo "✨ Project cleaned!"
