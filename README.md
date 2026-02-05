 HR Analytics - Employee Attrition & Income Prediction

🎯 Contexte et Objectif

 Problématique métier
Dans un contexte où la rétention des talents est cruciale, les entreprises ont besoin de comprendre les facteurs qui influencent la rémunération et le turnover de leurs employés. Ce projet vise à analyser les données RH d'une organisation pour identifier les déterminants de la rémunération et créer un modèle prédictif exploitable par les équipes RH.

 Objectifs du projet
- Analyser les caractéristiques démographiques et professionnelles des employés
- Identifier les facteurs clés influençant la rémunération mensuelle
- Construire un modèle de régression linéaire pour prédire les salaires
- Fournir des insights actionnables pour la politique de rémunération

 🏗️ Architecture et Méthodologie

 Stack technique
- Langage : R
- Bibliothèques : Base R (stats, graphics)
- Approche : Analyse exploratoire + Modélisation statistique

 Pipeline d'analyse

```
1. Data Loading & Exploration
   └─> Dimensions, types, statistiques descriptives

2. Exploratory Data Analysis (EDA)
   ├─> Analyse univariée (distributions, boxplots)
   ├─> Analyse bivariée (corrélations, scatter plots)
   └─> Analyse catégorielle (répartitions par département, genre, etc.)

3. Feature Engineering
   └─> Création de variables dérivées (YearlyIncome)

4. Modeling
   ├─> Modèle simple : MonthlyIncome ~ YearsAtCompany
   └─> Modèle complet : Régression multiple (6 variables)

5. Model Evaluation & Interpretation
   └─> R², p-values, résidus, fonction de prédiction
```

 📊 Dataset

 Caractéristiques
- Taille : 1,470 employés
- Variables : 12+ attributs (démographiques, professionnels, organisationnels)

 Variables principales analysées
| Variable | Type | Description |
|----------|------|-------------|
| `MonthlyIncome` | Numérique | Revenu mensuel ($2,911 - $19,999) |
| `Age` | Numérique | Âge de l'employé (18-60 ans) |
| `TotalWorkingYears` | Numérique | Années d'expérience totale (0-40 ans) |
| `YearsAtCompany` | Numérique | Ancienneté dans l'entreprise (0-40 ans) |
| `YearsWithCurrManager` | Numérique | Années sous le manager actuel (0-17 ans) |
| `JobLevel` | Catégorielle ordonnée | Niveau hiérarchique (1-5) |
| `DistanceFromHome` | Numérique | Distance domicile-travail (1-29 miles) |
| `Department` | Catégorielle | Département (R&D, Sales, HR) |
| `Gender` | Catégorielle | Genre de l'employé |
| `MaritalStatus` | Catégorielle | Statut matrimonial (Single, Married, Divorced) |

 🔍 Insights clés

 1. Statistiques descriptives

Revenu mensuel moyen : $6,503 (médiane : $4,919)
- 25% des employés gagnent ≤ $2,911
- 75% des employés gagnent ≤ $8,379
- Présence de hauts salaires (max : $19,999)

Ancienneté moyenne : 7.01 ans (médiane : 5 ans)
- Workforce relativement stable
- Certains employés avec 40 ans d'ancienneté

Âge moyen : 36.92 ans (range : 18-60)
- Population mature avec forte expérience

 2. Analyse de corrélation

```r
cor(MonthlyIncome, YearsAtCompany) = 0.514
```

✅ Corrélation positive modérée entre ancienneté et salaire

 3. Modèle de régression simple

Équation : `MonthlyIncome = 3,733.3 + 395.2 × YearsAtCompany`

 Interprétation :
- Pour chaque année supplémentaire dans l'entreprise, le salaire augmente de €395.20
- R² = 0.2645 : L'ancienneté explique seulement 26.45% de la variance des salaires
- p-value < 2e-16 : Relation statistiquement significative
- Erreur résiduelle : €4,039 (forte variance non expliquée)

 4. Modèle de régression multiple (6 variables)

Équation complète :
```
MonthlyIncome = -1,336.05
                + 61.64 × TotalWorkingYears
                - 56.93 × YearsWithCurrManager
                + 3,784.46 × JobLevel
                - 12.63 × DistanceFromHome
```

Variables significatives :
- ⭐ JobLevel : Impact majeur (+€3,784 par niveau)
- ⭐ TotalWorkingYears : +€61.64 par année d'expérience
- ⚠️ YearsWithCurrManager : Impact négatif (-€56.93) - possiblement confondant avec TotalWorkingYears
- ⚠️ DistanceFromHome : Impact faible (-€12.63)

Performance améliorée : Ce modèle capture mieux la complexité de la rémunération

 🚀 Fonctionnalités implémentées

 1. Analyse exploratoire complète
```r
# Statistiques descriptives
summary(Data[6:12])

# Visualisations
boxplot(Data[,6:12], outline = FALSE)
```

 2. Filtrage conditionnel
```r
# Employés avec revenu > $10,000
high_income <- Data[Data$MonthlyIncome > 10000, ]

# Employés âgés de 55-60 ans
EM_age <- Data[Data$Age>=55 & Data$Age<=60, ]
```

 3. Fonction de prédiction
```r
predictedIncome <- function(TotalWorkingYears, YearsWithCurrManager, JobLevel, DistanceFromHome){
  return(-1336.05 + 61.639*TotalWorkingYears - 56.926*YearsWithCurrManager + 
         3784.463*JobLevel - 12.633*DistanceFromHome)
}

# Exemple d'utilisation
predictedIncome(3, 5, 7, 9)  # Prédiction pour un profil donné
```

 4. Visualisations
- Scatter plot : MonthlyIncome vs YearsAtCompany avec ligne de régression
- Boxplots : Distribution des variables numériques (avec/sans outliers)
- Pie charts : Répartition par JobLevel, MaritalStatus
- Barplots : Distribution par Department, Gender

 ⚠️ Limites et Améliorations futures

 Limites identifiées

1. R² relativement faible (26.45%) : 
   - Beaucoup de variance inexpliquée
   - Variables importantes manquantes (performance, certifications, spécialisation)

2. Multicollinéarité potentielle :
   - TotalWorkingYears et YearsAtCompany sont fortement corrélés
   - Nécessite une analyse VIF (Variance Inflation Factor)

3. Variables catégorielles non intégrées :
   - Department, Gender, EducationField exclus du modèle final
   - Pourraient apporter de l'information supplémentaire

4. Absence de validation :
   - Pas de split train/test
   - Pas de validation croisée
   - Risque d'overfitting non évalué

5. Hypothèses de régression non vérifiées :
   - Normalité des résidus
   - Homoscédasticité
   - Indépendance des observations

 Améliorations proposées

Court terme
- [ ] Ajouter variables catégorielles (one-hot encoding)
- [ ] Implémenter train/test split (80/20)
- [ ] Calculer métriques complémentaires (MAE, RMSE)
- [ ] Vérifier hypothèses de régression (Q-Q plot, Breusch-Pagan test)

Moyen terme
- [ ] Tester modèles non-linéaires (Random Forest, XGBoost)
- [ ] Feature engineering avancé (interactions, polynômes)
- [ ] Analyse de multicollinéarité (VIF)
- [ ] Cross-validation k-fold

Long terme
- [ ] Dashboard interactif (Shiny)
- [ ] Système de recommandation salariale
- [ ] Analyse de clustering (identification de profils types)
- [ ] Intégration d'API pour prédictions en temps réel

 📈 Résultats Business

 Insights actionnables pour les RH

1. Le niveau hiérarchique (JobLevel) est le déterminant principal de la rémunération
   - Action : Formaliser les grilles salariales par niveau

2. L'ancienneté a un impact modéré (+€395/an)
   - Action : Revoir la politique de progression salariale pour fidéliser les talents

3. L'expérience totale compte plus que l'ancienneté interne
   - Action : Valoriser l'expérience externe lors des recrutements

4. 26% de variance inexpliquée suggère d'autres facteurs importants
   - Action : Enrichir les données (performance, skills, certifications)

 📚 Compétences développées

 Techniques
- Analyse statistique descriptive et inférentielle
- Régression linéaire simple et multiple
- Data wrangling et manipulation avec R
- Visualisation de données (base graphics)
- Feature engineering

 Méthodologiques
- Démarche d'analyse exploratoire structurée
- Interprétation de modèles de régression
- Identification de limites et biais
- Communication de résultats techniques à des non-data scientists

 Domaine métier
- Analyse RH et compensation & benefits
- KPIs RH (turnover, ancienneté, rémunération)
- Compréhension des enjeux de retention

 🔧 Reproduction du projet

 Prérequis
```r
# Packages requis
install.packages("base")  # Fonctionnalités de base R (déjà installé)
```

 Utilisation
```r
# 1. Charger les données
Data <- read.csv("hr_data.csv")

# 2. Lancer l'analyse exploratoire
source("hr_analytics.R")

# 3. Utiliser la fonction de prédiction
predictedIncome(TotalWorkingYears = 10, 
                YearsWithCurrManager = 3, 
                JobLevel = 2, 
                DistanceFromHome = 5)
```

 📖 Contexte académique

Projet réalisé dans le cadre : Master Data Science et Business Intelligence  
Cours : Analyse statistique avec R  
Durée : 3 semaines  
Objectif pédagogique : Maîtriser les fondamentaux de la régression linéaire et l'analyse exploratoire avec R

📧 Contact

  Franck Ulrich BIPANDA 
📧 bipanda.franck@icloud.com  
🔗 [LinkedIn](https://linkedin.com/in/franck-bipanda-13392372)  
🌐 [Portfolio](https://datascienceportfol.io/bipandaf)
