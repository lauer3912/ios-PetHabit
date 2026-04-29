import SwiftUI

struct AIInsightsView: View {
    @EnvironmentObject var petStore: PetStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Health Score Overview
                    if let score = petStore.dailyHealthScore {
                        HealthScoreOverviewCard(score: score)
                    }

                    // Weekly Trends
                    WeeklyTrendsCard()

                    // Behavior Analysis
                    BehaviorAnalysisCard()

                    // Health Alerts
                    HealthAlertsCard()

                    // Breed Insights
                    BreedInsightsCard()
                }
                .padding()
            }
            .background(Color(hex: "FFF8F0"))
            .navigationTitle("AI Insights")
        }
    }
}

struct HealthScoreOverviewCard: View {
    let score: HealthScore

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Weekly Overview")
                    .font(.headline)
                Spacer()
                Text(weekRange)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            HStack(spacing: 20) {
                // Score Ring
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.15), lineWidth: 12)
                        .frame(width: 100, height: 100)

                    Circle()
                        .trim(from: 0, to: CGFloat(score.score) / 100)
                        .stroke(
                            LinearGradient(
                                colors: [Color(hex: "FF8C00"), Color(hex: "FF6B6B")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(-90))

                    VStack {
                        Text("\(score.score)")
                            .font(.title.bold())
                        Text("Score")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                // Stats
                VStack(alignment: .leading, spacing: 12) {
                    StatRow(icon: "figure.walk", label: "Walks", value: "5/7", color: .green)
                    StatRow(icon: "fork.knife", label: "Meals", value: "21", color: .brown)
                    StatRow(icon: "cup.and.saucer.fill", label: "Water", value: "4/7", color: .cyan)
                    StatRow(icon: "heart.fill", label: "Health", value: score.trend.rawValue, color: .red)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("health_score_overview_card")
    }

    var weekRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let end = Date()
        let start = Calendar.current.date(byAdding: .day, value: -6, to: end) ?? end
        return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
    }
}

struct StatRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.caption.bold())
        }
    }
}

struct WeeklyTrendsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Activity Trends")
                .font(.headline)

            // Simple bar chart representation
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(["M", "T", "W", "T", "F", "S", "S"], id: \.self) { day in
                    VStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "FF8C00"), Color(hex: "FF6B6B")],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .frame(width: 36, height: CGFloat.random(in: 40...100))

                        Text(day)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("weekly_trends_card")
    }
}

struct BehaviorAnalysisCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Behavior Patterns")
                    .font(.headline)
                Spacer()
                Image(systemName: "brain.head.profile")
                    .foregroundColor(Color(hex: "FF8C00"))
            }

            VStack(alignment: .leading, spacing: 12) {
                BehaviorRow(
                    title: "Most Active Time",
                    value: "Morning (8-10 AM)",
                    icon: "sun.max.fill",
                    color: .orange
                )
                BehaviorRow(
                    title: "Favorite Activity",
                    value: "Outdoor Walks",
                    icon: "figure.walk",
                    color: .green
                )
                BehaviorRow(
                    title: "Sleep Quality",
                    value: "Good (85%)",
                    icon: "moon.fill",
                    color: .indigo
                )
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("behavior_analysis_card")
    }
}

struct BehaviorRow: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.subheadline.bold())
            }

            Spacer()
        }
    }
}

struct HealthAlertsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Health Alerts")
                    .font(.headline)
                Spacer()
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("All Clear")
                    .font(.caption)
                    .foregroundColor(.green)
            }

            Text("No concerns detected. Keep up the great work with your current routine!")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.green.opacity(0.05))
        .cornerRadius(16)
        .accessibilityIdentifier("health_alerts_card")
    }
}

struct BreedInsightsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Breed Insights")
                    .font(.headline)
                Spacer()
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
            }

            VStack(alignment: .leading, spacing: 8) {
                InsightRow(text: "Golden Retrievers need 2+ hours of exercise daily")
                InsightRow(text: "Regular ear cleaning helps prevent infections")
                InsightRow(text: "Joint health monitoring recommended after age 7")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("breed_insights_card")
    }
}

struct InsightRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Color(hex: "FF8C00"))
                .font(.caption)

            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    AIInsightsView()
        .environmentObject(PetStore())
}
