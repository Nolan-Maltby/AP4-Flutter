<<<<<<< HEAD
## 📱 Vue d'ensemble
Application mobile développée en Flutter pour la gestion des visites médicales. Cette application permet aux professionnels de santé de gérer efficacement leurs visites, patients et localisations. Elle offre les fonctionnalités suivantes :

- Authentification.
- Navigation pour visualiser les visites, importer des données.
- Affichage et modification des informations des soins effectués.
- Géolocalisation pour situer les patients et l'infirmière sur une carte (api-adresse.data.gouv pour géocoder et OpenStreetMap pour afficher la carte).
- Stockage local des données via une base de données (Hive).
- L'application est développée sous Flutter pour une meilleure compatibilité multi-plateforme.
=======
# AP4 Android Application

## 📱 Vue d'ensemble
Application mobile développée en Flutter pour la gestion des visites médicales. Cette application permet aux professionnels de santé de gérer efficacement leurs visites, patients et localisations.
>>>>>>> 83c32e0 (suppression fichier inutile)

## 🏗 Structure du Projet

### 📂 Écrans Principaux (`lib/screens/`)
<<<<<<< HEAD
- `main.dart` : point d'entrée de l'application, exécution de la fonction main() qui initialise et lance l'application.
- `first_screen.dart` : Écran d'accueil (avant la connexion)
- `second_screen.dart` : Interface de connexion a l'application
- `third_screen.dart` : Écran d'accueil (après la connexion)
- `patient_screen.dart` : Gestion complète des informations de la visite
- `map_screen.dart` : Interface cartographique
- `visite_screen.dart` : Gestion des visites médicales
=======
- `first_screen.dart` : Écran d'accueil et point d'entrée de l'application
- `second_screen.dart` : Interface de navigation secondaire
- `third_screen.dart` : Interface de navigation tertiaire
- `patient_screen.dart` : Gestion complète des informations patients
- `map_screen.dart` : Interface cartographique interactive
- `visite_screen.dart` : Gestion des visites médicales
- `visite_details_screen.dart` : Affichage détaillé des visites
>>>>>>> 83c32e0 (suppression fichier inutile)

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
<<<<<<< HEAD
=======
- Création de nouvelles visites
>>>>>>> 83c32e0 (suppression fichier inutile)
- Modification des visites existantes
- Consultation détaillée des visites
- Suivi des visites en cours

### 2. Interface Cartographique
<<<<<<< HEAD
- Géolocalisation des patients

### 3. Gestion des Patients
=======
- Visualisation des visites sur une carte
- Navigation vers les lieux de visite
- Géolocalisation des patients

### 3. Gestion des Patients
- Création de profils patients
- Modification des informations
>>>>>>> 83c32e0 (suppression fichier inutile)
- Historique des visites par patient

### 4. Système d'Authentification
- Connexion sécurisée
- Gestion des sessions
- Stockage sécurisé des identifiants

<<<<<<< HEAD
=======
### 5. Services Backend
- Communication API REST
- Gestion des permissions système
- Stockage local des données
- Synchronisation des données

>>>>>>> 83c32e0 (suppression fichier inutile)
## 🛠 Configuration Technique

### Prérequis
- Flutter SDK
- Android Studio / VS Code
- Git

### Installation
1. Cloner le repository
```bash
<<<<<<< HEAD
git clone https://github.com/Nolan-Maltby/AP4-Flutter.git
=======
git clone [URL_DU_REPO]
>>>>>>> 83c32e0 (suppression fichier inutile)
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
<<<<<<< HEAD
=======

## 📄 Licence
[À définir]

## 👥 Contribution
Les contributions sont les bienvenues. Veuillez suivre les étapes suivantes :
1. Fork le projet
2. Créer une branche pour votre fonctionnalité
3. Commiter vos changements
4. Pousser vers la branche
5. Ouvrir une Pull Request

## 📞 Support
Pour toute question ou problème, veuillez ouvrir une issue dans le repository.
>>>>>>> 83c32e0 (suppression fichier inutile)
