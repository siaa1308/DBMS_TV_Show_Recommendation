# 🎬 DBMS_TV_Show_Recommendation

A full-stack Movie & TV Show Recommendation System built using **Python, Streamlit, and MySQL**, designed to simulate an OTT platform with personalized recommendations, watch history tracking, user reviews, and analytics dashboards.

---

## 📖 Overview

**DBMS_TV_Show_Recommendation** demonstrates how database management concepts can be used to build an intelligent content recommendation platform.

The application allows users to create profiles, watch and rate content, receive personalized recommendations, and explore viewing analytics—all powered by SQL queries, stored functions, triggers, and relational database design.

---

## ✨ Key Features

### 👤 User Management

* Create and manage user profiles
* Store user demographics and subscription details
* Automatic User ID generation

### 🎥 Watch History Tracking

* Log movies and TV shows watched by users
* Record watch duration and timestamps
* Maintain a complete viewing history

### ⭐ Ratings & Reviews

* Submit ratings from **0.0 – 5.0**
* Write detailed reviews
* Store user feedback for recommendation generation

### 🎯 Personalized Recommendations

* Automatically generated recommendations
* Powered by SQL logic and database triggers
* Displays recommendation reasons and suggested content

### 📊 Analytics Dashboard

Provides user-level insights including:

* Total content watched
* Favorite genre
* Average rating given
* Viewing behavior statistics

---

## 🛠️ Tech Stack

| Component     | Technology            |
| ------------- | --------------------- |
| Frontend      | Streamlit             |
| Backend       | Python                |
| Database      | MySQL                 |
| UI Components | Streamlit Option Menu |
| Styling       | Custom CSS            |

---

## 🗄️ Database Concepts Demonstrated

* Relational Database Design
* Primary & Foreign Keys
* SQL Joins
* Aggregate Functions
* Stored Functions
* Database Triggers
* Recommendation Logic
* Analytics Queries

---

## 📂 Database Schema

### Main Tables

* `USER`
* `MOVIE`
* `WATCH_HISTORY`
* `RATING`
* `RECOMMENDATION`

### Stored Functions

```sql
GetUserWatchCount(USER_ID)
GetFavoriteGenre(USER_ID)
```

### Additional DBMS Features

* Automated recommendation triggers
* User preference analysis
* Genre-based recommendation logic
* Watch history analytics

---

## 🚀 Application Modules

### 1. Add User

Create new user profiles with:

* Name
* Email
* Age
* Country
* Subscription Type

### 2. Watch Movie

* Select a user
* Choose a movie/show
* Log viewing activity

### 3. Rate Movie

* Submit ratings
* Write reviews
* Update recommendation data

### 4. View Recommendations

* Personalized content suggestions
* Recommendation explanations
* Clean card-based UI

### 5. Analytics Dashboard

Visualize user engagement and viewing preferences through SQL-powered insights.

---

## 📸 Screenshots

### Home Dashboard

*(Add screenshot here)*

### Recommendation Page

*(Add screenshot here)*

### Analytics Dashboard

*(Add screenshot here)*

### User Management

*(Add screenshot here)*

---

## ▶️ Running the Project

### Clone the Repository

```bash
git clone https://github.com/yourusername/DBMS_TV_Show_Recommendation.git
cd DBMS_TV_Show_Recommendation
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

### Configure MySQL

1. Create the database.
2. Import the provided SQL schema.
3. Update database credentials in the project configuration.

### Launch the Application

```bash
streamlit run app.py
```

---

## 🎯 Learning Outcomes

This project showcases the practical implementation of DBMS concepts in a real-world recommendation system, combining database design, SQL programming, backend development, and interactive analytics into a single application.
