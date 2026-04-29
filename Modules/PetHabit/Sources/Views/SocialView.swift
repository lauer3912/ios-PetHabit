import SwiftUI

struct SocialView: View {
    @EnvironmentObject var petStore: PetStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Pet Profile Page Card
                    PetProfilePageCard()

                    // Community Challenges
                    CommunityChallengesCard()

                    // Pet Friends
                    PetFriendsCard()

                    // Achievements
                    AchievementsCard()
                }
                .padding()
            }
            .background(Color(hex: "FFF8F0"))
            .navigationTitle("Social")
        }
    }
}

struct PetProfilePageCard: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Pet Profile Page")
                    .font(.headline)
                Spacer()
                Button("Share") {
                    // Share action
                }
                .font(.subheadline.bold())
                .foregroundColor(Color(hex: "FF8C00"))
                .accessibilityIdentifier("share_profile_button")
            }

            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "FF8C00"), Color(hex: "FF6B6B")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)

                    Image(systemName: "pawprint.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("No Pet Added")
                        .font(.headline)
                    Text("Add a pet to create a public profile")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("pet_profile_page_card")
    }
}

struct CommunityChallengesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Community Challenges")
                    .font(.headline)
                Spacer()
                Button("See All") {}
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "FF8C00"))
                    .accessibilityIdentifier("see_all_challenges_button")
            }

            VStack(spacing: 12) {
                ChallengeRow(
                    title: "30-Day Walk Challenge",
                    participants: 1_234,
                    daysLeft: 12,
                    progress: 0.4
                )
                ChallengeRow(
                    title: "Hydration Tracker",
                    participants: 856,
                    daysLeft: 5,
                    progress: 0.7
                )
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("community_challenges_card")
    }
}

struct ChallengeRow: View {
    let title: String
    let participants: Int
    let daysLeft: Int
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline.bold())
                Spacer()
                Text("\(daysLeft) days left")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: progress)
                .tint(Color(hex: "FF8C00"))

            HStack {
                Image(systemName: "person.2.fill")
                    .font(.caption2)
                Text("\(participants.formatted()) participants")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(hex: "FFF8F0"))
        .cornerRadius(12)
    }
}

struct PetFriendsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Pet Friends")
                    .font(.headline)
                Spacer()
                Button("Find Friends") {}
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "FF8C00"))
                    .accessibilityIdentifier("find_friends_button")
            }

            VStack {
                Image(systemName: "person.2.fill")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)

                Text("No Pet Friends Yet")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Connect with other pet owners")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("pet_friends_card")
    }
}

struct AchievementsCard: View {
    @EnvironmentObject var petStore: PetStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Achievements")
                    .font(.headline)
                Spacer()
                Text("\(unlockedCount)/\(petStore.achievements.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(petStore.achievements.prefix(6)) { achievement in
                    AchievementBadge(achievement: achievement)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("achievements_card")
    }

    var unlockedCount: Int {
        petStore.achievements.filter { $0.isUnlocked }.count
    }
}

struct AchievementBadge: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(achievement.isUnlocked ?
                          LinearGradient(colors: [Color(hex: "FF8C00"), Color(hex: "FF6B6B")], startPoint: .topLeading, endPoint: .bottomTrailing) :
                          LinearGradient(colors: [Color.gray.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 48, height: 48)

                Image(systemName: achievement.icon)
                    .foregroundColor(achievement.isUnlocked ? .white : .gray)
            }

            Text(achievement.name)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundColor(achievement.isUnlocked ? .primary : .secondary)
        }
        .accessibilityIdentifier("achievement_\(achievement.name.lowercased().replacingOccurrences(of: " ", with: "_"))")
    }
}

#Preview {
    SocialView()
        .environmentObject(PetStore())
}
