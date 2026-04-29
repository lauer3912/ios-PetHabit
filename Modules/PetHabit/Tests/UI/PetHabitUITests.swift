import XCTest

final class PetHabitUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["--uitesting"]
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // MARK: - Tab Navigation Tests
    func testTabNavigation() {
        XCTAssertTrue(app.tabBars.buttons["Home"].waitForExistence(timeout: 5))
        app.tabBars.buttons["Activities"].tap()
        XCTAssertTrue(app.cells["activity_type_walk"].waitForExistence(timeout: 3))

        app.tabBars.buttons["AI"].tap()
        XCTAssertTrue(app.staticTexts["AI Insights"].waitForExistence(timeout: 3))

        app.tabBars.buttons["Social"].tap()
        XCTAssertTrue(app.staticTexts["Social"].waitForExistence(timeout: 3))

        app.tabBars.buttons["Settings"].tap()
        XCTAssertTrue(app.staticTexts["Settings"].waitForExistence(timeout: 3))
    }

    // MARK: - Home Tab Tests
    func testHomeTabDisplaysEmptyState() {
        app.tabBars.buttons["Home"].tap()

        // Should show empty pet card when no pets
        XCTAssertTrue(app.buttons["add_first_pet_button"].waitForExistence(timeout: 3))
    }

    func testHomeTabHasHealthScore() {
        app.tabBars.buttons["Home"].tap()

        XCTAssertTrue(app.scrollViews["HomeView"].waitForExistence(timeout: 3))
    }

    // MARK: - Activities Tab Tests
    func testActivitiesTabShowsActivityTypes() {
        app.tabBars.buttons["Activities"].tap()

        XCTAssertTrue(app.cells["activity_type_walk"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.cells["activity_type_meal"].waitForExistence(timeout: 3))
    }

    // MARK: - AI Insights Tab Tests
    func testAIInsightsTabShowsContent() {
        app.tabBars.buttons["AI"].tap()

        XCTAssertTrue(app.staticTexts["AI Insights"].waitForExistence(timeout: 3))
    }

    // MARK: - Social Tab Tests
    func testSocialTabShowsCommunity() {
        app.tabBars.buttons["Social"].tap()

        XCTAssertTrue(app.staticTexts["Community Challenges"].waitForExistence(timeout: 3))
    }

    // MARK: - Settings Tab Tests
    func testSettingsTabShowsOptions() {
        app.tabBars.buttons["Settings"].tap()

        XCTAssertTrue(app.switches["dark_mode_toggle"].waitForExistence(timeout: 3))
    }

    // MARK: - Screenshot Tests
    func testScreenshot_HomeTab() throws {
        app.tabBars.buttons["Home"].tap()
        sleep(1)
    }

    func testScreenshot_ActivitiesTab() throws {
        app.tabBars.buttons["Activities"].tap()
        sleep(1)
    }

    func testScreenshot_AITab() throws {
        app.tabBars.buttons["AI"].tap()
        sleep(1)
    }

    func testScreenshot_SocialTab() throws {
        app.tabBars.buttons["Social"].tap()
        sleep(1)
    }

    func testScreenshot_SettingsTab() throws {
        app.tabBars.buttons["Settings"].tap()
        sleep(1)
    }

    // MARK: - Launch Performance
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
