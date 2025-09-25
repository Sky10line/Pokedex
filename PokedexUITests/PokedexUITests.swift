import XCTest

final class PokedexUITests: XCTestCase {
    @MainActor
    func test_detailsFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        let list = app.collectionViews[AccessibilityID.Home.pokemonList]
        XCTAssertTrue(list.cells.count > 0)

        let firstCell = list.cells.element(boundBy: 0)
        firstCell.tap()
        
        XCTAssertTrue(app.images[AccessibilityID.Details.pokemonImage].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityID.Details.nameLabel].exists)

        XCTAssertTrue(app.staticTexts[AccessibilityID.Details.informationLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityID.Details.physicalInfos].exists)

        XCTAssertTrue(app.staticTexts[AccessibilityID.Details.typesLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityID.Details.typesInfo].exists)
    }
}
