# Stilist 💇‍♂️💇‍♀️

**Stilist** is a modern iOS mobile platform designed to revolutionize the hair salon experience. Built with SwiftUI and Firebase, it serves three primary user groups — customers, stylists, and salon managers — through an intuitive and secure app.

---

## 🎯 Project Motivation

- Help users find barbers/salons and book appointments easily.
- Minimize customer wait times and optimize time management.
- Support salon owners in efficiently managing their schedules and improving client relationships.

---

## 👥 User Roles

| Feature                  | Customer | Stylist | Manager |
|--------------------------|:--------:|:-------:|:-------:|
| Salon Discovery          | ✅       | ❌      | ❌      |
| Appointment Booking      | ✅       | ❌      | ❌      |
| Calendar Management      | ✅       | ✅      | ✅      |
| In-App Messaging         | ✅       | ✅      | ✅      |
| Revenue Analytics        | ❌       | ✅      | ✅      |

---

## 📱 Key Features

### For Customers:
- 🔍 **Salon Discovery:** Search for salons based on location and filters via Apple MapKit.
- 📅 **Appointment Booking:** Choose date/time and book directly with available stylists.
- 👤 **Salon Profiles & Reviews:** View detailed information and customer feedback.
- 💬 **Secure Messaging:** Communicate directly with salons through in-app chat.
- ❌ **Appointment Cancellation:** Reschedule or cancel bookings easily.

### For Stylists/Salon Managers:
- 🗓️ **Appointment Management:** Accept, manage, or cancel appointments with ease.
- 📈 **Analytics Dashboard:** Monitor performance, booking efficiency, and revenue.
- 🧑‍💼 **Customer Communication:** Respond to messages and maintain client relationships.

---

## 🔐 User Flow

1. **Registration:** Users sign up using email and password via Firebase Authentication.
2. **Role Routing:** `ContentView` evaluates auth state and user role, presenting the appropriate interface.
3. **Salon Search:** Use location or filters to find suitable salons.
4. **Appointment:** Browse profiles and book available slots.
5. **Messaging:** Communicate with stylists through a secure interface.
6. **Manage Appointments:** Cancel or reschedule if needed.

---

## 🏗️ Architecture

The app follows the **MVVM (Model-View-ViewModel)** design pattern.

- `StilistApp` is the entry point and initializes all Firebase services on launch.
- `ContentView` acts as the root router — it instantiates all primary ViewModels as `@StateObject` and distributes them down the view hierarchy via `.environmentObject()`.
- A protocol-based service layer abstracts all Firestore data access, keeping ViewModels testable and decoupled from Firebase internals.

---

## 🧩 Modules

| Module              | Description                                                   |
|---------------------|---------------------------------------------------------------|
| **Authentication**  | Secure session management with Firebase Auth                  |
| **Salon Discovery** | Location-based search and filtering powered by Apple MapKit   |
| **Appointments**    | Real-time reservation creation, management, and cancellation  |
| **Messaging**       | In-app chat between customers and salons                      |
| **Data Layer**      | Protocol-based Firestore service layer for all data access    |

---

## ⚙️ Tech Stack

| Layer           | Technology                        |
|-----------------|-----------------------------------|
| **Frontend**    | SwiftUI (iOS)                     |
| **Auth**        | Firebase Authentication           |
| **Database**    | Firebase Firestore                |
| **Maps**        | Apple MapKit                      |
| **Architecture**| MVVM                              |

---

## 📊 Market Insights & Competitive Advantages

- 📈 **Growing Demand:** Rising need for digital transformation in the salon industry.
- 🎯 **Personalized Experience:** Filters and smart search for user-specific needs.
- ⏰ **Efficient Scheduling:** Time-saving features for both customers and barbers.
- 🔐 **Secure Platform:** Strong focus on user privacy and data protection.

---

## 📸 Screenshots

<img width="266" height="568" alt="image" src="https://github.com/user-attachments/assets/f85ba36e-17d9-489d-a370-9c3f1f389a26" />
<img width="254" height="548" alt="image" src="https://github.com/user-attachments/assets/6ca7ec33-3af9-4f44-97c0-5e36d4c2ce54" />
<img width="282" height="610" alt="image" src="https://github.com/user-attachments/assets/e723813c-ff5a-41a0-b09b-a709ee28d0d2" />
<img width="262" height="566" alt="image" src="https://github.com/user-attachments/assets/140469b4-435c-4813-86f1-1dc1212c872f" />
<img width="262" height="566" alt="image" src="https://github.com/user-attachments/assets/f782a722-f79c-4ea5-930a-72a2cc3057ea" />
<img width="274" height="592" alt="image" src="https://github.com/user-attachments/assets/1b0f7005-a2af-4b4d-806a-5d2839676456" />
<img width="287" height="622" alt="image" src="https://github.com/user-attachments/assets/3568b043-ec0e-40e5-9b22-45e8b7987d3f" />
<img width="288" height="621" alt="image" src="https://github.com/user-attachments/assets/3fdbff96-5661-4814-ac64-619c066872a6" />
<img width="288" height="622" alt="image" src="https://github.com/user-attachments/assets/2dcdc867-9dee-4c64-af49-f55679346afb" />
<img width="275" height="596" alt="image" src="https://github.com/user-attachments/assets/9f7ca8e9-c3c6-4ca9-bc6c-893a3a4d151d" />
<img width="276" height="596" alt="image" src="https://github.com/user-attachments/assets/e5674bfd-75b0-454f-983d-c895c75beef0" />
<img width="276" height="598" alt="image" src="https://github.com/user-attachments/assets/02941458-6ea1-4ea4-90d8-155a3859dc68" />
<img width="288" height="624" alt="image" src="https://github.com/user-attachments/assets/84b34c7f-dbed-4d23-afe0-2bfe7efd9df8" />
<img width="273" height="592" alt="image" src="https://github.com/user-attachments/assets/b49603e8-b51e-4d58-b34d-3edf345a2dfb" />
<img width="286" height="620" alt="image" src="https://github.com/user-attachments/assets/62162139-8ab8-42f9-955d-31fd65bd56bc" />
<img width="287" height="620" alt="image" src="https://github.com/user-attachments/assets/4a892771-c7c0-468c-865f-4bb81bc73eb5" />
