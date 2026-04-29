import SwiftUI

struct HomeView: View {
    @EnvironmentObject var petStore: PetStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Pet Profile Card
                    if let pet = petStore.pets.first {
                        PetProfileCard(pet: pet)
                    } else {
                        EmptyPetCard()
                    }

                    // Health Score Ring
                    if let score = petStore.dailyHealthScore {
                        HealthScoreCard(score: score)
                    }

                    // Today's Tasks
                    TodayTasksCard()

                    // Activity Streak
                    if let habit = petStore.ownerHabits.first {
                        StreakCard(habit: habit)
                    }

                    // AI Summary Banner
                    if let score = petStore.dailyHealthScore {
                        AIHealthBanner(summary: score.summary)
                    }

                    // Recent Activities
                    RecentActivitiesCard()
                }
                .padding()
            }
            .background(Color(hex: "FFF8F0"))
            .navigationTitle("PetHabit")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(hex: "FF8C00"))
                    }
                    .accessibilityIdentifier("add_pet_button")
                }
            }
        }
    }
}

// MARK: - Pet Profile Card
struct PetProfileCard: View {
    let pet: Pet

    var body: some View {
        VStack(spacing: 12) {
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
                        .frame(width: 80, height: 80)

                    if let photoData = pet.photoData,
                       let uiImage = UIImage(data: photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 76, height: 76)
                    } else {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(pet.name)
                        .font(.title2.bold())

                    Text("\(pet.breed) • \(pet.age) years old")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    HStack {
                        Image(systemName: pet.gender == .male ? "male.fill" : "female.fill")
                            .foregroundColor(pet.gender == .male ? .blue : .pink)
                        Text(pet.gender.rawValue)
                            .font(.caption)
                    }
                }

                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("pet_profile_card")
    }
}

// MARK: - Empty Pet Card
struct EmptyPetCard: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "pawprint.circle")
                .font(.system(size: 60))
                .foregroundColor(Color(hex: "FF8C00"))

            Text("No Pets Yet")
                .font(.title3.bold())

            Text("Add your first pet to start tracking!")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button(action: {}) {
                Text("Add Pet")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "FF8C00"), Color(hex: "FF6B6B")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
            .accessibilityIdentifier("add_first_pet_button")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("empty_pet_card")
    }
}

// MARK: - Health Score Card
struct HealthScoreCard: View {
    let score: HealthScore

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Health Score")
                    .font(.headline)

                HStack(alignment: .bottom, spacing: 4) {
                    Text("\(score.score)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(scoreColor)

                    Text("/100")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                }

                HStack {
                    Image(systemName: trendIcon)
                        .foregroundColor(trendColor)
                    Text(score.trend.rawValue)
                        .font(.caption)
                        .foregroundColor(trendColor)
                }
            }

            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                    .frame(width: 80, height: 80)

                Circle()
                    .trim(from: 0, to: CGFloat(score.score) / 100)
                    .stroke(scoreColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-90))

                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundColor(scoreColor)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("health_score_card")
    }

    var scoreColor: Color {
        score.score >= 80 ? .green : (score.score >= 60 ? .orange : .red)
    }

    var trendIcon: String {
        switch score.trend {
        case .up: return "arrow.up.right"
        case .down: return "arrow.down.right"
        case .stable: return "arrow.right"
        }
    }

    var trendColor: Color {
        switch score.trend {
        case .up: return .green
        case .down: return .red
        case .stable: return .orange
        }
    }
}

// MARK: - Today Tasks Card
struct TodayTasksCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Today's Tasks")
                    .font(.headline)
                Spacer()
                Text("0/6")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                TaskButton(icon: "figure.walk", label: "Walk", color: .green)
                TaskButton(icon: "fork.knife", label: "Feed", color: .brown)
                TaskButton(icon: "cup.and.saucer.fill", label: "Water", color: .cyan)
                TaskButton(icon: "pills.fill", label: "Medicine", color: .red)
                TaskButton(icon: "moon.fill", label: "Sleep", color: .gray)
                TaskButton(icon: "bathtub.fill", label: "Bath", color: .purple)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("today_tasks_card")
    }
}

struct TaskButton: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 48, height: 48)

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
            }

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .accessibilityIdentifier("task_\(label.lowercased())")
    }
}

// MARK: - Streak Card
struct StreakCard: View {
    let habit: OwnerHabit

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Activity Streak")
                    .font(.headline)

                HStack {
                    Text("\(habit.streak)")
                        .font(.title.bold())
                    Text("days")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text("Lv \(habit.level)")
                        .font(.headline)
                }

                Text("\(habit.xp) XP")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("streak_card")
    }
}

// MARK: - AI Health Banner
struct AIHealthBanner: View {
    let summary: String

    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
                .font(.title2)
                .foregroundColor(Color(hex: "FF8C00"))

            Text(summary)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color(hex: "FF8C00").opacity(0.1), Color(hex: "FF6B6B").opacity(0.1)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(12)
        .accessibilityIdentifier("ai_health_banner")
    }
}

// MARK: - Recent Activities Card
struct RecentActivitiesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Activities")
                    .font(.headline)
                Spacer()
                Button("See All") {}
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "FF8C00"))
                    .accessibilityIdentifier("see_all_activities_button")
            }

            VStack(spacing: 8) {
                ActivityRow(icon: "figure.walk", label: "Morning Walk", time: "30 min", color: .green)
                ActivityRow(icon: "fork.knife", label: "Breakfast", time: "08:00 AM", color: .brown)
                ActivityRow(icon: "pills.fill", label: "Heartworm Medicine", time: "09:00 AM", color: .red)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("recent_activities_card")
    }
}

struct ActivityRow: View {
    let icon: String
    let label: String
    let time: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 32)

            Text(label)
                .font(.subheadline)

            Spacer()

            Text(time)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
        .environmentObject(PetStore())
        .environmentObject(ThemeService())
}
