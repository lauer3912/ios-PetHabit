import Foundation
import SwiftUI

// MARK: - Pet Model
struct Pet: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var breed: String
    var birthDate: Date
    var weight: Double // in kg
    var photoData: Data?
    var gender: PetGender
    var notes: String

    var age: Int {
        Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
    }

    var ageInMonths: Int {
        Calendar.current.dateComponents([.month], from: birthDate, to: Date()).month ?? 0
    }

    static let empty = Pet(
        id: UUID(),
        name: "",
        breed: "",
        birthDate: Date(),
        weight: 0,
        photoData: nil,
        gender: .unknown,
        notes: ""
    )
}

enum PetGender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"
}

// MARK: - Activity Model
struct PetActivity: Identifiable, Codable {
    let id: UUID
    let petId: UUID
    var type: ActivityType
    var date: Date
    var duration: TimeInterval // in seconds
    var notes: String
    var distance: Double? // in km for walks
    var locationData: [CLLocationCoordinate2D]?

    enum ActivityType: String, Codable, CaseIterable {
        case walk = "Walk"
        case run = "Run"
        case play = "Play"
        case swim = "Swim"
        case meal = "Meal"
        case water = "Water"
        case medication = "Medication"
        case supplement = "Supplement"
        case bath = "Bath"
        case grooming = "Grooming"
        case nailTrim = "Nail Trim"
        case vetVisit = "Vet Visit"
        case sleep = "Sleep"
        case weight = "Weight"

        var icon: String {
            switch self {
            case .walk: return "figure.walk"
            case .run: return "figure.run"
            case .play: return "tennisball.fill"
            case .swim: return "drop.fill"
            case .meal: return "fork.knife"
            case .water: return "cup.and.saucer.fill"
            case .medication: return "pills.fill"
            case .supplement: return "capsule.fill"
            case .bath: return "bathtub.fill"
            case .grooming: return "scissors"
            case .nailTrim: return "hand.raised.fill"
            case .vetVisit: return "cross.case.fill"
            case .sleep: return "moon.fill"
            case .weight: return "scalemass.fill"
            }
        }

        var color: Color {
            switch self {
            case .walk, .run: return .green
            case .play: return .orange
            case .swim: return .blue
            case .meal: return .brown
            case .water: return .cyan
            case .medication, .supplement: return .red
            case .bath, .grooming: return .purple
            case .nailTrim: return .pink
            case .vetVisit: return .indigo
            case .sleep: return .gray
            case .weight: return .teal
            }
        }
    }
}

// MARK: - Health Score
struct HealthScore {
    let score: Int // 0-100
    let trend: ScoreTrend
    let summary: String

    enum ScoreTrend: String {
        case up = "Up"
        case down = "Down"
        case stable = "Stable"
    }
}

// MARK: - Owner Habit
struct OwnerHabit: Identifiable, Codable {
    let id: UUID
    var name: String
    var streak: Int
    var level: Int
    var xp: Int
    var completedToday: Bool

    static let new = OwnerHabit(
        id: UUID(),
        name: "",
        streak: 0,
        level: 1,
        xp: 0,
        completedToday: false
    )
}

// MARK: - Achievement
struct Achievement: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let icon: String
    let xpReward: Int
    var isUnlocked: Bool
    let unlockedDate: Date?
}

// MARK: - CLLocationCoordinate2D Extension
import CoreLocation
extension CLLocationCoordinate2D: Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let latitude = try container.decode(Double.self)
        let longitude = try container.decode(Double.self)
        self.init(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(latitude)
        try container.encode(longitude)
    }
}
