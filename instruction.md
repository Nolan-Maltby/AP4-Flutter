# AP4 Android Application

## 📱 Vue d'ensemble
Application mobile développée en Flutter pour la gestion des visites médicales. Cette application permet aux professionnels de santé de gérer efficacement leurs visites, patients et localisations.

## 🏗 Structure du Projet

### 📂 Écrans Principaux (`lib/screens/`)
- `main.dart` : point d'entrée de l'application, exécution de la fonction main() qui initialise et lance l'application.
- `first_screen.dart` : Écran d'accueil (avant la connexion)
- `second_screen.dart` : Interface de connexion a l'application
- `third_screen.dart` : Écran d'accueil (après la connexion)
- `patient_screen.dart` : Gestion complète des informations de la visite
- `map_screen.dart` : Interface cartographique
- `visite_screen.dart` : Gestion des visites médicales

### 📦 Modèles de Données (`lib/models/`)
- `credentials.dart` : Structure des données d'authentification
- `credentials.g.dart` : Code généré pour la sérialisation des credentials
- `visite.dart` : Structure des données de visite
- `visite.g.dart` : Code généré pour la sérialisation des visites

### 🔧 Services (`lib/services/`)
- `api_service.dart` : Gestion des communications avec l'API
- `permissions_service.dart` : Gestion des permissions système
- `storage_service.dart` : Service de stockage local

## 🚀 Fonctionnalités Principales

### 1. Gestion des Visites
- Modification des visites existantes
- Consultation détaillée des visites
- Suivi des visites en cours

### 2. Interface Cartographique
- Géolocalisation des patients

### 3. Gestion des Patients
- Historique des visites par patient

### 4. Système d'Authentification
- Connexion sécurisée
- Gestion des sessions
- Stockage sécurisé des identifiants

## 🛠 Configuration Technique

### Prérequis
- Flutter SDK
- Android Studio / VS Code
- Git

### Installation
1. Cloner le repository
```bash
git clone https://github.com/Nolan-Maltby/AP4-Flutter.git
```

2. Installer les dépendances
```bash
flutter pub get
```

3. Lancer l'application
```bash
flutter run
```

## 📱 Plateformes Supportées
- Android
- iOS
- Web (en développement)

## 🧪 Tests
Les tests sont situés dans le dossier `test/` et incluent :
- Tests unitaires
- Tests d'intégration
- Tests de widgets
