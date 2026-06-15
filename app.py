import streamlit as st
from streamlit_option_menu import option_menu
import mysql.connector

# ===============================
# CONFIGURATION
# ===============================
st.set_page_config(
    page_title="🎬 Movie & TV Analytics Dashboard",
    layout="wide",
    page_icon="🎥"
)

# ===============================
# BACKGROUND STYLE
# ===============================
st.markdown("""
<style>
[data-testid="stAppViewContainer"] {
    background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
    color: #FFFFFF;
}
[data-testid="stSidebar"] {
    background: #111827;
}
</style>
""", unsafe_allow_html=True)

# ===============================
# DATABASE CONNECTION
# ===============================
def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="abcde",  
        database="MovieTVAnalytics"
    )

# Utility function to fetch movies
def fetch_movies():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT Movie_ID, Title FROM MOVIE ORDER BY Title")
    data = cursor.fetchall()
    conn.close()
    return {title: mid for (mid, title) in data}

# ===============================
# SIDEBAR MENU
# ===============================
with st.sidebar:
    st.image("https://cdn-icons-png.flaticon.com/512/189/189001.png", width=80)
    st.markdown("### Welcome to Netflix OTT 🧠")
    selected = option_menu(
        menu_title="Main Menu",
        options=["Add User", "Watch Movie", "Rate Movie", "View Recommendations", "Analytics Dashboard"],
        icons=["person-plus", "tv", "star", "lightbulb", "bar-chart-line"],
        menu_icon="cast",
        default_index=0,
        styles={
            "container": {"background-color": "#111827"},
            "icon": {"color": "cyan", "font-size": "18px"},
            "nav-link": {"color": "white", "font-size": "16px"},
            "nav-link-selected": {"background-color": "#10B981"},
        }
    )

# ===============================
# ADD USER PAGE
# ===============================
if selected == "Add User":
    st.subheader("👤 Add New User")
    with st.form("add_user_form"):
        name = st.text_input("Full Name")
        email = st.text_input("Email")
        age = st.number_input("Age", min_value=1, max_value=120)
        country = st.text_input("Country")
        sub_type = st.selectbox("Subscription Type", ["Basic", "Premium", "VIP"])
        submitted = st.form_submit_button("Add User")

    if submitted:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO USER (Name, Email, Age, Country, Subscription_Type)
            VALUES (%s, %s, %s, %s, %s)
        """, (name, email, age, country, sub_type))
        conn.commit()
        new_user_id = cursor.lastrowid  # fetch auto-generated ID
        conn.close()

        st.success(f"✅ User '{name}' added successfully!")
        st.info(f"🆔 Your User ID is **{new_user_id}** — use this for future actions.")
        st.balloons()

# ===============================
# WATCH MOVIE PAGE
# ===============================
elif selected == "Watch Movie":
    st.subheader("🎥 Log a Movie/Show Watch")

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT User_ID, Name FROM USER ORDER BY User_ID")
    users = cursor.fetchall()
    conn.close()

    user_display = {f"{uid} - {name}": uid for uid, name in users}
    user_choice = st.selectbox("Select User", list(user_display.keys()))
    user_id = user_display[user_choice]

    movies = fetch_movies()
    movie_choice = st.selectbox("Select Movie", list(movies.keys()))
    movie_id = movies[movie_choice]

    duration = st.number_input("Watch Duration (minutes)", min_value=10)
    
    if st.button("Log Watch"):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO WATCH_HISTORY (User_ID, Content_ID, Watch_Date, Watch_Duration)
            VALUES (%s, %s, NOW(), %s)
        """, (user_id, movie_id, duration))
        conn.commit()
        conn.close()
        st.success(f"🎬 Logged: {movie_choice} watched by {user_choice} successfully!")

# ===============================
# RATE MOVIE PAGE
# ===============================
elif selected == "Rate Movie":
    st.subheader("⭐ Rate a Movie or Show")

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT User_ID, Name FROM USER ORDER BY User_ID")
    users = cursor.fetchall()
    conn.close()

    user_display = {f"{uid} - {name}": uid for uid, name in users}
    user_choice = st.selectbox("Select User", list(user_display.keys()))
    user_id = user_display[user_choice]

    movies = fetch_movies()
    movie_choice = st.selectbox("Select Movie", list(movies.keys()))
    movie_id = movies[movie_choice]

    rating = st.slider("Select Rating", 0.0, 5.0, 3.0, 0.1)
    review = st.text_area("Write your review")

    if st.button("Submit Rating"):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO RATING (User_ID, Content_ID, Rating_Value, Review)
            VALUES (%s, %s, %s, %s)
        """, (user_id, movie_id, rating, review))
        conn.commit()
        conn.close()
        st.success(f"⭐ Rating added for '{movie_choice}'!")
        st.info("Trigger activated — a recommendation might have been generated.")

# ===============================
# VIEW RECOMMENDATIONS PAGE
# ===============================
elif selected == "View Recommendations":
    st.subheader("💡 Your Recommendations")

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT User_ID, Name FROM USER ORDER BY User_ID")
    users = cursor.fetchall()
    conn.close()

    user_display = {f"{uid} - {name}": uid for uid, name in users}
    user_choice = st.selectbox("Select User", list(user_display.keys()))
    user_id = user_display[user_choice]

    if st.button("Show Recommendations"):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT r.Content_ID, m.Title, r.Reason
            FROM RECOMMENDATION r
            JOIN MOVIE m ON r.Content_ID = m.Movie_ID
            WHERE r.User_ID = %s
        """, (user_id,))
        recs = cursor.fetchall()
        conn.close()

        if not recs:
            st.warning("No recommendations available yet.")
        else:
            st.success("✨ Recommended for You:")
            for cid, title, reason in recs:
                st.markdown(
                    f"""
                    <div style='background-color:#1E293B; padding:15px; border-radius:10px; margin-bottom:10px;'>
                        <h4>🎞️ {title}</h4>
                        <p>{reason}</p>
                        <small>Content ID: {cid}</small>
                    </div>
                    """,
                    unsafe_allow_html=True
                )

# ===============================
# ANALYTICS PAGE (FIXED)
# ===============================
elif selected == "Analytics Dashboard":
    st.subheader("📊 Viewer Analytics")

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT User_ID, Name FROM USER ORDER BY User_ID")
    users = cursor.fetchall()
    conn.close()

    user_display = {f"{uid} - {name}": uid for uid, name in users}
    user_choice = st.selectbox("Select User to Analyze", list(user_display.keys()))
    user_id = user_display[user_choice]

    if st.button("Show Analytics"):
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT GetUserWatchCount(%s)", (user_id,))
        total = cursor.fetchone()[0]

        cursor.execute("SELECT GetFavoriteGenre(%s)", (user_id,))
        genre = cursor.fetchone()[0]

        cursor.execute("SELECT ROUND(AVG(Rating_Value),2) FROM RATING WHERE User_ID=%s", (user_id,))
        avg_rating = cursor.fetchone()[0]

        conn.close()

        # Convert Decimal to float safely
        total = float(total or 0)
        avg_rating = float(avg_rating or 0)

        c1, c2, c3 = st.columns(3)
        c1.metric("🎬 Movies Watched", int(total))
        c2.metric("💖 Favorite Genre", genre if genre else "N/A")
        c3.metric("⭐ Avg Rating", round(avg_rating, 2))

        st.markdown("---")
        st.success("Here's your personalized viewing summary!")
