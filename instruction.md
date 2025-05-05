# AP4 Android Application

## 📱 Vue d'ensemble
Application mobile développée en Flutter pour la gestion des visites médicales. Cette application permet aux professionnels de santé de gérer efficacement leurs visites, patients et localisations.

## 🏗 Structure du Projet

### 📂 Écrans Principaux (`lib/screens/`)
- `first_screen.dart` : Écran d'accueil et point d'entrée de l'application
- `second_screen.dart` : Interface de navigation secondaire
- `third_screen.dart` : Interface de navigation tertiaire
- `patient_screen.dart` : Gestion complète des informations patients
- `map_screen.dart` : Interface cartographique interactive
- `visite_screen.dart` : Gestion des visites médicales
- `visite_details_screen.dart` : Affichage détaillé des visites

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
- Création de nouvelles visites
- Modification des visites existantes
- Consultation détaillée des visites
- Suivi des visites en cours

### 2. Interface Cartographique
- Visualisation des visites sur une carte
- Navigation vers les lieux de visite
- Géolocalisation des patients

### 3. Gestion des Patients
- Création de profils patients
- Modification des informations
- Historique des visites par patient

### 4. Système d'Authentification
- Connexion sécurisée
- Gestion des sessions
- Stockage sécurisé des identifiants

### 5. Services Backend
- Communication API REST
- Gestion des permissions système
- Stockage local des données
- Synchronisation des données

## 🛠 Configuration Technique

### Prérequis
- Flutter SDK
- Android Studio / VS Code
- Git

### Installation
1. Cloner le repository
```bash
git clone [URL_DU_REPO]
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
