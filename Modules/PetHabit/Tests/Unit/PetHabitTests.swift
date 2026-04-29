import XCTest
@testable import PetHabit

final class PetHabitTests: XCTestCase {
    var petStore: PetStore!

    override func setUp() {
        super.setUp()
        petStore = PetStore()
    }

    override func tearDown() {
        petStore = nil
        super.tearDown()
    }

    // MARK: - Pet Model Tests
    func testPetCreation() {
        let pet = Pet(
            id: UUID(),
            name: "Buddy",
            breed: "Golden Retriever",
            birthDate: Calendar.current.date(byAdding: .year, value: -3, to: Date()) ?? Date(),
            weight: 30.0,
            photoData: nil,
            gender: .male,
            notes: "Friendly and playful"
        )

        XCTAssertEqual(pet.name, "Buddy")
        XCTAssertEqual(pet.breed, "Golden Retriever")
        XCTAssertEqual(pet.gender, .male)
        XCTAssertEqual(pet.weight, 30.0)
    }

    func testPetAgeCalculation() {
        let birthDate = Calendar.current.date(byAdding: .year, value: -3, to: Date()) ?? Date()
        let pet = Pet(
            id: UUID(),
            name: "Buddy",
            breed: "Golden Retriever",
            birthDate: birthDate,
            weight: 30.0,
            photoData: nil,
            gender: .male,
            notes: ""
        )

        XCTAssertEqual(pet.age, 3)
    }

    // MARK: - Activity Model Tests
    func testActivityCreation() {
        let activity = PetActivity(
            id: UUID(),
            petId: UUID(),
            type: .walk,
            date: Date(),
            duration: 1800,
            notes: "Morning walk",
            distance: 2.5,
            locationData: nil
        )

        XCTAssertEqual(activity.type, .walk)
        XCTAssertEqual(activity.duration, 1800)
        XCTAssertEqual(activity.distance, 2.5)
    }

    func testActivityTypeIcons() {
        XCTAssertEqual(PetActivity.ActivityType.walk.icon, "figure.walk")
        XCTAssertEqual(PetActivity.ActivityType.meal.icon, "fork.knife")
        XCTAssertEqual(PetActivity.ActivityType.medication.icon, "pills.fill")
    }

    // MARK: - PetStore Tests
    func testAddPet() {
        let pet = Pet.empty
        petStore.addPet(pet)

        XCTAssertEqual(petStore.pets.count, 1)
    }

    func testDeletePet() {
        let pet = Pet.empty
        petStore.addPet(pet)
        petStore.deletePet(pet)

        XCTAssertEqual(petStore.pets.count, 0)
    }

    func testHealthScoreCalculation() {
        let pet = Pet.empty
        petStore.addPet(pet)

        let initialScore = petStore.dailyHealthScore?.score ?? 0
        XCTAssertGreaterThanOrEqual(initialScore, 0)
        XCTAssertLessThanOrEqual(initialScore, 100)
    }

    func testOwnerHabitCreation() {
        petStore.createOwnerHabit(name: "Exercise Daily")
        XCTAssertEqual(petStore.ownerHabits.count, 1)
        XCTAssertEqual(petStore.ownerHabits.first?.name, "Exercise Daily")
        XCTAssertEqual(petStore.ownerHabits.first?.streak, 0)
        XCTAssertEqual(petStore.ownerHabits.first?.level, 1)
    }
}
