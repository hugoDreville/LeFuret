# Gestionnaire - Le Furet du Nord
Le gestionnaire du Furet du Nord est un logiciel de gestion developpé en Dart. C'est un projet qui a pour but de permettre a une personne lambda n'ayant aucune connaissance en base de données ou très peu, de pouvoir modifier et gérer la base de données du furet du nord.

## Pré-requis

### Installation

* Mettre à jour les packages en appuyant sur l'icone **Get Packages** de la page pubspec.yaml.
* installer [mysql](https://www.mysql.com/fr/) avec la commande suivante:
```bash
apt install php-mysql
```
* installer [mariadb](https://go.mariadb.com/download-mariadb-server-community107.html?utm_source=google&utm_medium=ppc&utm_campaign=MKG-Search-Google-Brand-Awareness-EMEA-France&matchtype=e&keyword=mariadb&cid=15211749993&agid=130837842378&device=c&placement=&creative=560054840304&adposition=&gclid=EAIaIQobChMIts6H486E9wIVGIXVCh0dggxkEAAYASAAEgJ7HfD_BwE) avec la commande suivante 
```bash
apt install mariadb-server
```
### Création de la Base de Données
1. Avant toute chose, il faut commencer par créer une base de données, avec la commande `mysql`.
```bash
mysql
```
2. Créer la **Base de Données**.
```bash
create database maBDD;
```
3. Donner les **privilèges** à un utilisateur.
```bash
grant all privileges on maBDD.* to 'monUser'@'localhost' identified by 'monMdp';
```
4. **Appliquer** les privilèges.
```bash
flush privileges;
``` 
## Utilisation
Quand on lance le programme, on nous demande les informations de connexion sur la base de données, on les renseignes donc.
```
> Veuillez saisir le nom de la BDD :
maBDD
> Veuillez saisir l'utilisateur :
monUser
> Veuillez saisir le mot de passe :
monMdp
```
L'affichage se fait sous forme de **menu**, voici par exemple le menu principal:
```
+-----------------------------------+
|           Menu Principal          |
|  1- Gestion de la BDD             |
|  2- Gestion de la table Article   |
|  3- Gestion de la table Editeur   |
|  4- Gestion de la table Auteur    |
|  0- Quitter                       |
+-----------------------------------+
```
Le programme nous demande ensuite une saisie, voici la saisie de ce menu :

```
> Veuillez saisir une action (0-4)
```
Pour **naviguer dans les menus**, il suffit juste de **suivre les instructions**, dans le cas suivant, on nous demande de choisir entre les 5 propositions.
Si l'on vient à se tromper dans la saisie, ce n'est pas grave, un message nous indiquera que la saisie est mauvaise et nous redemandera de faire une saisie.
### Création des tables
Avant de vouloir insérer ou modifier des données, il faut que les tables soient créés, pour cela nous allons choisir l'option 1 du menu principal qui est `1- Gestion de la BDD`.
On arrive donc dans le `menu - Gestion BDD`. 
```
+----------------------------------------------+
|             Menu - Gestion BDD               |
|  1- Création des tables de la BDD            |
|  2- Verification des tables de la BDD        |
|  3- Afficher les tables de la BDD            |
|  4- Supprimer une table dans la BDD          |
|  5- Supprimer toutes les tables dans la BDD  |
|  0- Quitter                                  |
+----------------------------------------------+
```
* L'options 2 nous permet de vérifier si toute les tables sont déjà créer.
* Si elles ne le sont pas, l'option 1 vas nous permettre de les créer en 1 clic.
* Une fois qu'elles sont créés, on peut revérifier avec l'option 2 et les afficher avec la 3.
### Insertions et modifications des données
Une fois les tables créés, nous pouvons insérer des articles,des éditeurs et des auteurs. Pour cela nous allons retourner en arrière avec  l'option 0 et choisir la table qui nous intéresse(option 2,3,4).
Par exemple, prenons la table Article:
```
+--------------------------------------------------+
|           Menu - Gestion Article                 |
|  1- Afficher des données de la table             |
|  2- Inserer une données dans la table            |
|  3- Modifier le stock                            |
|  4- Modifier une données dans la table           |
|  5- Supprimer tout les articles d'un editeur     |
|  6- Supprimer tout les articles d'un auteur      |
|  7- Supprimer une données dans la tables         |
|  8- Supprimer toutes les données dans la tables  |
|  0- Quitter                                      |
+--------------------------------------------------+
```
* Pour insérer un article, il faut choisir l'option 2 et rentrer les informations dans l'ordre suivant:
1. Titre
2. Type
3. Quantité
4. Prix
5. L'année de parution
6. L'id de l'éditeur
7. L'id de l'auteur
* Si l'on vient a vouloir modifié cet article il suffira d'afficher la liste des articles avec l'option `1- Afficher des données de la table ` et de retenir l'id de l'article, pour ensuite prendre l'option `4- Modifier une donnée dans la table` et rerentrer les informations dnas le même ordre que précedement.
### Supression de données
Vous l'avez surement remarqué dans les menus ci-dessus, il est possible de supprimer des données.
On peut:
* Supprimer une donnée avec son id:
```
Supprimer une donnée dans la table
```
* Supprimer toutes les données d'une table:
```
Supprimer toutes les données dans la table
```
* Mais il est également possible de supprimer tous les articles d'un éditeur:
```
Supprimer tous les articles d'un éditeur
```
* ou d'un auteur:
```
Supprimer tous les articles d'un auteur
```
### Supression de table
Dans le `Menu - Gestion BDD`, il est possible de supprimer une table avec :
```
4- Supprimer une table dans la BDD
```
Et en indiquant la table que l'on souhaite supprimer.
Mais on peut également tous les supprimer avec:
```
5- Supprimer toutes les tables dans la BDD
```
## Structure
Voici le modele conceptuelle pour lequel nous avons opté pour notre base de données:
