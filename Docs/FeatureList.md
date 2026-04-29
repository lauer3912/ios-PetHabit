# PetHabit - Feature List

## Overview
**App Name:** PetHabit  
**Bundle ID:** com.ggsheng.PetHabit  
**Concept:** AI-powered pet health habit tracker that monitors pet daily routines while gamifying owner habit formation - both owner and pet grow together.  
**Target Market:** Western market (North America, Europe) - pet owners who treat pets as family members  
**Monetization:** Freemium subscription ($2.99/month Premium)

---

## Capability Recommendations

| Capability | Required | Reason |
|------------|----------|--------|
| App Groups | Yes | For Widget data sharing |
| HealthKit | Yes | Pet health data integration |
| Background Modes | Yes | HealthKit background sync, reminders |
| User Notifications | Yes | Daily reminders for pet tasks |
| Siri Shortcuts | Recommended | Voice-activated pet task logging |

---

## Features (66 Total)

### 1. Dashboard (12 features)
1. Pet profile card (name/breed/age/photo/gender)
2. Daily health score ring (0-100 animated)
3. Today's pet task checklist with completion state
4. Activity streak counter (consecutive days)
5. Quick-add buttons (Feed/Walk/Medicine/Sleep/Bath)
6. AI health summary banner (2-3 sentences)
7. Weather widget + walk recommendation
8. Recent 7-day activity timeline
9. Weight trend mini-chart (last 30 days)
10. Next reminder countdown timer
11. Owner habit streak badge
12. Emergency vet hotline button

### 2. Pet Profile Management (10 features)
13. Add/edit pet profile (name, breed, age, weight, photo)
14. Multiple pet support (up to 5 in free, unlimited in Premium)
15. Breed-specific care tips database
16. Age-appropriate activity suggestions
17. Pet photo gallery
18. Vaccination record log
19. Microchip/registration info
20. Insurance info storage
21. Pet birthdate + age calculator
22. Pet notes (free text)

### 3. Activity & Habit Tracking (14 features)
23. Walk tracker with GPS route map
24. Walk duration and distance (km/miles)
25. Exercise type selector (Walk/Run/Play/Swim)
26. Meal logging (food brand, amount, time)
27. Water intake tracker (cups/day)
28. Medication schedule and logging
29. Supplement reminders
30. Bath/grooming log
31. Nail trim log with reminder
32. Vet visit scheduler
33. Sleep duration tracker
34. Sleep quality score (1-5 paws)
35. Weight logging with trend line
36. Growth chart for puppies/kittens

### 4. AI Health Intelligence (10 features)
37. Behavior pattern analysis (7-day rolling)
38. Anomaly detection alerts (sudden changes)
39. Health score daily calculation algorithm
40. AI-generated weekly pet health report
41. Symptom checker (dropdown of common symptoms)
42. Health trend predictions
43. Breed-specific health insights
44. Nutrition recommendations based on activity
45. Emergency vet locator (MapKit integration)
46. Pet health risk assessment

### 5. Owner Habit Gamification (10 features)
47. Owner habit streak tracking
48. Pet task completion = owner habit points
49. Achievement badges system (20+ badges)
50. Level progression (Lv1-50, XP system)
51. Daily owner goals setting
52. Habit reminders for owner
53. Focus mode (distraction blocking)
54. Weekly owner-pet growth report
55. Social sharing (pet achievements)
56. Accountability partner invite (link sharing)

### 6. Social & Community (5 features)
57. Pet profile page (public/private toggle)
58. Activity feed (pet friends' updates)
59. Milestone celebrations (animations)
60. Before/after transformation posts
61. Community challenges (30-Day Walk Challenge)

### 7. Premium Features (5 features)
62. AI deep health analysis (full spectrum)
63. Unlimited pet profiles
64. Advanced behavior analytics (30-day charts)
65. Custom reminders (unlimited)
66. PDF health report export

---

## UI/UX Design Direction

### Visual Style
- Modern, warm, trustworthy - Apple Design Award quality
- Gradient backgrounds: warm amber to coral
- Card-based layout with soft shadows
- Animations: smooth, playful micro-interactions

### Color Palette
- Primary: #FF8C00 (Amber) → #FF6B6B (Coral) gradient
- Secondary: #20B2AA (Teal) for health indicators
- Background: #FFF8F0 (Warm cream)
- Text: #2D3436 (Dark charcoal)
- Success: #27AE60 (Green)
- Warning: #F39C12 (Orange)

### Layout Approach
- Tab-based navigation (5 tabs: Home, Activities, AI Insights, Social, Settings)
- Floating action button for quick-add
- Pull-to-refresh gesture
- Haptic feedback on task completion

### Typography
- Primary: SF Pro Display (Apple system font)
- Hierarchy: Bold headers, regular body, light captions

### Icons
- SF Symbols with custom pet-themed icons
- Animated icons for streaks and achievements

---

## Technical Stack

| Component | Technology |
|-----------|------------|
| Framework | SwiftUI + UIKit hybrid |
| Architecture | MVVM |
| Data Storage | UserDefaults + SQLite.swift |
| AI Features | On-device CoreML (no cloud AI) |
| Maps | MapKit |
| Charts | Swift Charts |
| Animations | Lottie + native SwiftUI |
| Subscriptions | StoreKit 2 |

---

## Privacy & Legal

- All pet health data stored locally on device
- No cloud AI processing (on-device ML only)
- Privacy Policy URL required before submission
- Contact Email: lauer3912@qq.com

---

*Document Version: 1.0*  
*Created: 2026-04-29*
