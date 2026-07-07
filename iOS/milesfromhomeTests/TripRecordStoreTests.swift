import XCTest
@testable import milesfromhome

@MainActor
final class TripRecordStoreTests: XCTestCase {
    var store: Store!

    override func setUp() async throws {
        store = Store()
    }

    func testSeedDataLoadsBelowFreeLimit() {
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testCanAddMoreWhenUnderLimit() {
        XCTAssertTrue(store.canAddMore)
    }

    func testAddIncreasesCount() {
        let before = store.items.count
        store.add(TripRecord(tripName: "Sample Tripname 10", distanceFromHome: 125.00, date: Date().addingTimeInterval(-2592000), notes: "Sample Notes 10"))
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testAddBeyondFreeLimitIsBlocked() {
        while store.canAddMore {
            store.add(TripRecord(tripName: "Sample Tripname 2", distanceFromHome: 25.00, date: Date().addingTimeInterval(-518400), notes: "Sample Notes 2"))
        }
        let countAtLimit = store.items.count
        store.add(TripRecord(tripName: "Sample Tripname 3", distanceFromHome: 37.50, date: Date().addingTimeInterval(-777600), notes: "Sample Notes 3"))
        XCTAssertEqual(store.items.count, countAtLimit)
    }

    func testProUnlockBypassesLimit() {
        while store.canAddMore {
            store.add(TripRecord(tripName: "Sample Tripname 2", distanceFromHome: 25.00, date: Date().addingTimeInterval(-518400), notes: "Sample Notes 2"))
        }
        store.isProUnlocked = true
        XCTAssertTrue(store.canAddMore)
    }

    func testDeleteRemovesItem() {
        let item = store.items[0]
        store.delete(item)
        XCTAssertFalse(store.items.contains(item))
    }

    func testUpdateModifiesItem() {
        var item = store.items[0]
        item.tripName = "Sample Tripname 6"
        store.update(item)
        XCTAssertEqual(store.items.first(where: { $0.id == item.id })?.tripName, item.tripName)
    }

    func testDeleteAtOffsetsRemovesCorrectItem() {
        let target = store.items[0]
        store.delete(at: IndexSet(integer: 0))
        XCTAssertFalse(store.items.contains(target))
    }
}
