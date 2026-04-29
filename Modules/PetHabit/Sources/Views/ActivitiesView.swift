import SwiftUI

struct ActivitiesView: View {
    @EnvironmentObject var petStore: PetStore
    @State private var selectedActivityType: PetActivity.ActivityType = .walk

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Activity Type Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(PetActivity.ActivityType.allCases, id: \.self) { type in
                            ActivityTypeChip(
                                type: type,
                                isSelected: selectedActivityType == type,
                                action: { selectedActivityType = type }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .background(Color.white)

                // Activities List
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredActivities) { activity in
                            ActivityCard(activity: activity)
                        }

                        if filteredActivities.isEmpty {
                            EmptyActivitiesView()
                        }
                    }
                    .padding()
                }
                .background(Color(hex: "FFF8F0"))
            }
            .navigationTitle("Activities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(hex: "FF8C00"))
                    }
                    .accessibilityIdentifier("log_activity_button")
                }
            }
        }
    }

    var filteredActivities: [PetActivity] {
        petStore.activities.filter { $0.type == selectedActivityType }
    }
}

struct ActivityTypeChip: View {
    let type: PetActivity.ActivityType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: type.icon)
                    .font(.caption)
                Text(type.rawValue)
                    .font(.caption.bold())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? type.color : type.color.opacity(0.1))
            .foregroundColor(isSelected ? .white : type.color)
            .cornerRadius(20)
        }
        .accessibilityIdentifier("activity_type_\(type.rawValue.lowercased().replacingOccurrences(of: " ", with: "_"))")
    }
}

struct ActivityCard: View {
    let activity: PetActivity

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(activity.type.color.opacity(0.1))
                    .frame(width: 44, height: 44)

                Image(systemName: activity.type.icon)
                    .foregroundColor(activity.type.color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(activity.type.rawValue)
                    .font(.headline)

                Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if activity.duration > 0 {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(formattedDuration)
                        .font(.subheadline.bold())
                    if let distance = activity.distance {
                        Text("\(String(format: "%.1f", distance)) km")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.03), radius: 4, x: 0, y: 2)
        .accessibilityIdentifier("activity_card_\(activity.id.uuidString.prefix(8))")
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: activity.date)
    }

    var formattedDuration: String {
        let minutes = Int(activity.duration / 60)
        return "\(minutes) min"
    }
}

struct EmptyActivitiesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No Activities Yet")
                .font(.headline)

            Text("Start logging activities to track your pet's daily routine")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
        .accessibilityIdentifier("empty_activities_view")
    }
}

#Preview {
    ActivitiesView()
        .environmentObject(PetStore())
}
