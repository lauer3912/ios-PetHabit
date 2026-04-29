import XCTest

final class ScreenshotTests: XCTestCase {
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

    func takeScreenshot(named name: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)

        let fullPath = "/tmp/PetHabitScreenshots/\(name).png"
        try? FileManager.default.createDirectory(atPath: "/tmp/PetHabitScreenshots", withIntermediateDirectories: true)
        let data = screenshot.pngRepresentation
        try? data.write(to: URL(fileURLWithPath: fullPath))
    }

    func testScreenshot_Home() throws {
        XCTAssertTrue(app.tabBars.buttons["Home"].waitForExistence(timeout: 5))
        takeScreenshot(named: "Screen1_Home")
    }

    func testScreenshot_Activities() throws {
        app.tabBars.buttons["Activities"].tap()
        XCTAssertTrue(app.cells["activity_type_walk"].waitForExistence(timeout: 3))
        takeScreenshot(named: "Screen2_Activities")
    }

    func testScreenshot_AIInsights() throws {
        app.tabBars.buttons["AI"].tap()
        XCTAssertTrue(app.staticTexts["AI Insights"].waitForExistence(timeout: 3))
        takeScreenshot(named: "Screen3_AIInsights")
    }

    func testScreenshot_Social() throws {
        app.tabBars.buttons["Social"].tap()
        XCTAssertTrue(app.staticTexts["Social"].waitForExistence(timeout: 3))
        takeScreenshot(named: "Screen4_Social")
    }

    func testScreenshot_Settings() throws {
        app.tabBars.buttons["Settings"].tap()
        XCTAssertTrue(app.staticTexts["Settings"].waitForExistence(timeout: 3))
        takeScreenshot(named: "Screen5_Settings")
    }
}
