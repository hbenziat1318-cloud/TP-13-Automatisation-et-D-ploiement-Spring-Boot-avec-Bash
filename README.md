# TP13 Spring Boot Application with Bash/PowerShell Automation

## Description
Ce projet démontre l'automatisation complète du cycle de vie d'une application Spring Boot à l'aide de scripts Bash et PowerShell. Il intègre les concepts DevOps de livraison continue et déploiement reproductible.

##  Structure du Projet
```
ens-springbash/
├── src/
│   └── main/java/ma/ens/springbash/
│       ├── SpringbashApplication.java
│       ├── entity/User.java
│       ├── repository/UserRepository.java
│       └── controller/UserController.java
├── scripts/
│   ├── run.sh / run.ps1
│   ├── stop.sh / stop.ps1
│   ├── logs.sh / logs.ps1
│   ├── deploy.sh
│   ├── healthcheck.sh
│   └── archive-logs.sh
├── logs/
│   ├── app.log
│   ├── deploy.log
│   └── app.pid
├── target/
└── pom.xml
```

##  Scripts d'Automatisation


### Pour Windows (PowerShell)
```
powershell
.\scripts\run.ps1
.\scripts\logs.ps1
.\scripts\stop.ps1
```

##   Tests

### 1. Test de Démarrage de l'Application

# Démarrer l'application
.\scripts\run.ps1

<img width="959" height="202" alt="IM1" src="https://github.com/user-attachments/assets/72bd435e-49a8-4170-88b2-1a63345075f5" />

# Vérifier le démarrage
.\scripts\logs.ps1

*Résultat attendu :*



https://github.com/user-attachments/assets/cbeb0533-b696-4a40-aec2-e3e47082e6b6



### 2. Test des Endpoints API

#### Test de l'endpoint Hello
```
powershell
curl http://localhost:8085/api/users/hello
```
*Résultat :*

https://github.com/user-attachments/assets/5749d3a8-b2f9-4642-b17e-019210a4e133


#### Test de l'Actuator Health
```
powershell
curl http://localhost:8085/actuator/health
```
*Résultat :*



https://github.com/user-attachments/assets/6d3b148c-c698-422d-8b10-0958a1091afc




#### Test CRUD des Utilisateurs

##### Création d'utilisateur
```
powershell
$body = @{
    name = "John Doe"
    email = "john@example.com"
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8085/api/users" -Method Post -Body $body -ContentType "application/json"
```
*Résultat :*


https://github.com/user-attachments/assets/8cade571-17d3-4571-a151-affabff73f15



##### Liste des utilisateurs
```
powershell
curl http://localhost:8085/api/users
```
*Résultat :*



https://github.com/user-attachments/assets/c4d1cd3f-23c8-4a15-84cf-dfbf701f38ae


### 3. Test de la Base de Données H2

#### Accès à la console H2
1. Ouvrir : http://localhost:8085/h2-console
2. Paramètres :
   - *URL JDBC* : jdbc:h2:mem:testdb
   - *Username* : sa
   - *Password* : (vide)

<img width="970" height="493" alt="image" src="https://github.com/user-attachments/assets/657f9edf-1e27-4c52-8cd4-ec8001e0567e" />

#### Requête SQL de test
```
sql
SELECT * FROM users;
```

<img width="970" height="493" alt="SQL TEST" src="https://github.com/user-attachments/assets/4f3c56f9-fdb8-4e81-9c70-b7cacef8c0d8" />

### 4. Test des Logs et Supervision
```
powershell
# Affichage des logs
.\scripts\logs.ps1
```


https://github.com/user-attachments/assets/ff337eac-7156-4dbe-a0c1-c2072512cc0c


# Surveillance en temps réel
```
Get-Content "logs\app.log" -Wait
```


https://github.com/user-attachments/assets/2409f4f5-4b04-489c-892a-ed1e95a0e752


### 5. Test d'Arrêt et Nettoyage
```
powershell
# Arrêt de l'application
.\scripts\stop.ps1
```
<img width="954" height="194" alt="image" src="https://github.com/user-attachments/assets/5acdccea-440f-4969-9ec3-be2819861901" />


##  Résultats des Tests Validés

###  Tests Fonctionnels
- **Démarrage Application** : 3.789 secondes
- **Port HTTP** : 8085 accessible
- **Base de données H2** : Initialisée avec table `users`
- **API REST** : 
  - GET `/api/users/hello` → 200 OK
  - GET `/api/users` → 200 OK
  - POST `/api/users` → 201 Created
-  **Spring Boot Actuator** : 
  - `/actuator/health` → Status UP
-  **Gestion des processus** : Démarrage/Arrêt fonctionnel

###  Tests d'Automatisation
-  **Scripts PowerShell** : run.ps1, logs.ps1, stop.ps1 opérationnels
- **Gestion des logs** : Redirection vers `logs/app.log`
- **Gestion des PID** : Identification et arrêt des processus
- **Libération des ressources** : Port 8085 libéré après arrêt

###  Tests de Robustesse
-  **Compilation** : Maven build successful
-  **Dépendances** : Spring Boot, JPA, H2, Lombok
-  **Configuration** : application.properties correcte
-  **Entités JPA** : Mapping User → table users

##  Technologies Utilisées

- **Spring Boot 3.2.0** - Framework principal
- **Java 21** - Langage de programmation
- **Maven** - Gestion des dépendances et build
- **H2 Database** - Base de données en mémoire
- **Spring Data JPA** - Persistance des données
- **Spring Web** - API REST
- **Lombok** - Réduction du code boilerplate
- **Spring Boot Actuator** - Monitoring
- **PowerShell/Bash** - Automatisation et scripts

##  Commandes Utiles

### Développement
```
powershell
# Compilation et démarrage
mvn clean compile
mvn spring-boot:run

# Construction du JAR
mvn clean package

# Exécution du JAR
java -jar target/springbash-1.0.0.jar


5

```

##  Résolution de Problèmes

### Problème Rencontré et Solution
```
*Erreur* : class SpringbashApplication is public, should be declared in a file named SpringbashApplication.java
```
*Solution* : 
```powershell
Rename-Item -Path "src/main/java/ma/ens/springbash/SpringBashApplication.java" -NewName "SpringbashApplication.java"
```
#### BENZIAT HANA
