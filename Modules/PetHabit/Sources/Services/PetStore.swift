import Foundation
import Combine

class PetStore: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var activities: [PetActivity] = []
    @Published var ownerHabits: [OwnerHabit] = []
    @Published var achievements: [Achievement] = []
    @Published var dailyHealthScore: HealthScore?

    private let userDefaults = UserDefaults.standard
    private let petsKey = "pets"
    private let activitiesKey = "activities"
    private let ownerHabitsKey = "ownerHabits"

    init() {
        loadData()
        setupAchievements()
        calculateDailyHealthScore()
    }

    // MARK: - Pet Management
    func addPet(_ pet: Pet) {
        pets.append(pet)
        savePets()
    }

    func updatePet(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
            savePets()
        }
    }

    func deletePet(_ pet: Pet) {
        pets.removeAll { $0.id == pet.id }
        activities.removeAll { $0.petId == pet.id }
        savePets()
        saveActivities()
    }

    // MARK: - Activity Management
    func logActivity(_ activity: PetActivity) {
        activities.append(activity)
        saveActivities()
        updateOwnerHabitProgress()
        calculateDailyHealthScore()
    }

    func getActivities(for petId: UUID, in days: Int = 7) -> [PetActivity] {
        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        return activities.filter { $0.petId == petId && $0.date >= cutoff }
    }

    // MARK: - Owner Habit
    func updateOwnerHabitProgress() {
        for i in ownerHabits.indices {
            if ownerHabits[i].completedToday {
                continue
            }
            let petId = pets.first?.id
            let todayActivities = activities.filter {
                $0.petId == petId && Calendar.current.isDateInToday($0.date)
            }
            if !todayActivities.isEmpty {
                ownerHabits[i].completedToday = true
                ownerHabits[i].streak += 1
                ownerHabits[i].xp += 10
                if ownerHabits[i].xp >= ownerHabits[i].level * 100 {
                    ownerHabits[i].level += 1
                }
            }
        }
        saveOwnerHabits()
    }

    func createOwnerHabit(name: String) {
        let habit = OwnerHabit(id: UUID(), name: name, streak: 0, level: 1, xp: 0, completedToday: false)
        ownerHabits.append(habit)
        saveOwnerHabits()
    }

    // MARK: - Health Score
    func calculateDailyHealthScore() {
        guard let pet = pets.first else {
            dailyHealthScore = nil
            return
        }

        let recentActivities = getActivities(for: pet.id, in: 7)
        var score = 70 // Base score

        let activityTypes = Set(recentActivities.map { $0.type })
        if activityTypes.contains(.walk) { score += 5 }
        if activityTypes.contains(.meal) { score += 5 }
        if activityTypes.contains(.water) { score += 5 }
        if activityTypes.contains(.medication) { score += 5 }
        if activityTypes.contains(.sleep) { score += 5 }

        let daysActive = Set(recentActivities.map {
            Calendar.current.startOfDay(for: $0.date)
        }).count
        if daysActive >= 5 { score += 5 }

        score = min(score, 100)

        let trend: HealthScore.ScoreTrend = score > 75 ? .up : (score < 60 ? .down : .stable)
        let summary = generateHealthSummary(for: pet, activities: recentActivities, score: score)

        dailyHealthScore = HealthScore(score: score, trend: trend, summary: summary)
    }

    private func generateHealthSummary(for pet: Pet, activities: [PetActivity], score: Int) -> String {
        var summary = "\(pet.name) is doing "
        if score >= 80 {
            summary += "excellently! "
        } else if score >= 70 {
            summary += "well. "
        } else {
            summary += "okay but could use more activities. "
        }

        let walks = activities.filter { $0.type == .walk }.count
        if walks < 2 {
            summary += "Try adding more walks today!"
        } else {
            summary += "Keep up the great work!"
        }

        return summary
    }

    // MARK: - Achievements
    private func setupAchievements() {
        achievements = [
            Achievement(id: UUID(), name: "First Steps", description: "Complete your first walk", icon: "figure.walk", xpReward: 50, isUnlocked: false, unlockedDate: nil),
            Achievement(id: UUID(), name: "7 Day Streak", description: "Maintain a 7 day activity streak", icon: "flame.fill", xpReward: 100, isUnlocked: false, unlockedDate: nil),
            Achievement(id: UUID(), name: "Health Hero", description: "Reach 90 health score", icon: "heart.fill", xpReward: 150, isUnlocked: false, unlockedDate: nil),
            Achievement(id: UUID(), name: "Perfect Week", description: "Log activities 7 days in a row", icon: "star.fill", xpReward: 200, isUnlocked: false, unlockedDate: nil),
            Achievement(id: UUID(), name: "Pet Parent", description: "Add your first pet", icon: "pawprint.fill", xpReward: 50, isUnlocked: false, unlockedDate: nil),
            Achievement(id: UUID(), name: "Consistent Carer", description: "Feed your pet on time for 30 days", icon: "clock.fill", xpReward: 300, isUnlocked: false, unlockedDate: nil),
        ]
    }

    func checkAndUnlockAchievements() {
        for i in achievements.indices where !achievements[i].isUnlocked {
            var shouldUnlock = false

            switch achievements[i].name {
            case "Pet Parent":
                shouldUnlock = !pets.isEmpty
            case "First Steps":
                shouldUnlock = activities.contains { $0.type == .walk }
            case "Health Hero":
                shouldUnlock = (dailyHealthScore?.score ?? 0) >= 90
            default:
                break
            }

            if shouldUnlock {
                achievements[i].isUnlocked = true
                achievements[i].unlockedDate = Date()
            }
        }
    }

    // MARK: - Persistence
    private func loadData() {
        if let data = userDefaults.data(forKey: petsKey),
           let pets = try? JSONDecoder().decode([Pet].self, from: data) {
            self.pets = pets
        }
        if let data = userDefaults.data(forKey: activitiesKey),
           let activities = try? JSONDecoder().decode([PetActivity].self, from: data) {
            self.activities = activities
        }
        if let data = userDefaults.data(forKey: ownerHabitsKey),
           let habits = try? JSONDecoder().decode([OwnerHabit].self, from: data) {
            self.ownerHabits = habits
        }
    }

    private func savePets() {
        if let data = try? JSONEncoder().encode(pets) {
            userDefaults.set(data, forKey: petsKey)
        }
    }

    private func saveActivities() {
        if let data = try? JSONEncoder().encode(activities) {
            userDefaults.set(data, forKey: activitiesKey)
        }
    }

    private func saveOwnerHabits() {
        if let data = try? JSONEncoder().encode(ownerHabits) {
            userDefaults.set(data, forKey: ownerHabitsKey)
        }
    }
}
