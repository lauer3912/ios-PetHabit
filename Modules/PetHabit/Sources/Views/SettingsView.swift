import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var petStore: PetStore
    @EnvironmentObject var themeService: ThemeService

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Section
                    ProfileSection()

                    // Pet Management
                    PetManagementSection()

                    // App Settings
                    AppSettingsSection()

                    // Notifications
                    NotificationsSection()

                    // Data & Privacy
                    DataPrivacySection()

                    // Support
                    SupportSection()

                    // App Info
                    AppInfoSection()
                }
                .padding()
            }
            .background(Color(hex: "FFF8F0"))
            .navigationTitle("Settings")
        }
    }
}

struct ProfileSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Profile")
                .font(.headline)
                .foregroundColor(.secondary)

            HStack {
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

                    Image(systemName: "person.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Pet Owner")
                        .font(.headline)
                    Text("Edit Profile")
                        .font(.caption)
                        .foregroundColor(Color(hex: "FF8C00"))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("profile_section")
    }
}

struct PetManagementSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("My Pets")
                .font(.headline)
                .foregroundColor(.secondary)

            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Add New Pet")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .accessibilityIdentifier("add_new_pet_button")

            Divider()

            Button(action: {}) {
                HStack {
                    Image(systemName: "pawprint.fill")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Manage Pets")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .accessibilityIdentifier("manage_pets_button")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("pet_management_section")
    }
}

struct AppSettingsSection: View {
    @State private var isDarkMode = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("App Settings")
                .font(.headline)
                .foregroundColor(.secondary)

            Toggle(isOn: $isDarkMode) {
                HStack {
                    Image(systemName: "moon.fill")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Dark Mode")
                }
            }
            .accessibilityIdentifier("dark_mode_toggle")

            Divider()

            HStack {
                Image(systemName: "ruler")
                    .foregroundColor(Color(hex: "FF8C00"))
                Text("Units")
                    .foregroundColor(.primary)
                Spacer()
                Text("Metric (km, kg)")
                    .foregroundColor(.secondary)
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .accessibilityIdentifier("units_setting")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("app_settings_section")
    }
}

struct NotificationsSection: View {
    @State private var reminders = true
    @State private var achievements = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notifications")
                .font(.headline)
                .foregroundColor(.secondary)

            Toggle(isOn: $reminders) {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Daily Reminders")
                }
            }
            .accessibilityIdentifier("daily_reminders_toggle")

            Divider()

            Toggle(isOn: $achievements) {
                HStack {
                    Image(systemName: "trophy.fill")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Achievement Alerts")
                }
            }
            .accessibilityIdentifier("achievement_alerts_toggle")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("notifications_section")
    }
}

struct DataPrivacySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Data & Privacy")
                .font(.headline)
                .foregroundColor(.secondary)

            Button(action: {}) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Export Data")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .accessibilityIdentifier("export_data_button")

            Divider()

            Button(action: {}) {
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Privacy Policy")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                        .foregroundColor(.secondary)
                }
            }
            .accessibilityIdentifier("privacy_policy_button")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("data_privacy_section")
    }
}

struct SupportSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Support")
                .font(.headline)
                .foregroundColor(.secondary)

            Button(action: {}) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Contact Support")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("lauer3912@qq.com")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .accessibilityIdentifier("contact_support_button")

            Divider()

            Button(action: {}) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color(hex: "FF8C00"))
                    Text("Rate App")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .accessibilityIdentifier("rate_app_button")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("support_section")
    }
}

struct AppInfoSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Version")
                    .foregroundColor(.primary)
                Spacer()
                Text("1.0.0")
                    .foregroundColor(.secondary)
            }
            .accessibilityIdentifier("app_version")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .accessibilityIdentifier("app_info_section")
    }
}

#Preview {
    SettingsView()
        .environmentObject(PetStore())
        .environmentObject(ThemeService())
}
