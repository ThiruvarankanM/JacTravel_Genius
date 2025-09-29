import streamlit as st
import subprocess
import sys
import os

def run_jac(destination, days, budget_choice, interests):
    """Run main.jac with user inputs"""
    try:
        user_inputs = f"{destination}\n{days}\n{budget_choice}\n{interests}\n"
        
        # Find jac executable
        jac_path = os.path.join(os.path.dirname(sys.executable), 'jac')
        
        process = subprocess.Popen(
            [jac_path, 'run', 'main.jac'],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        
        stdout, stderr = process.communicate(input=user_inputs, timeout=120)
        
        return stdout if process.returncode == 0 else None, stderr
            
    except Exception as e:
        return None, str(e)

st.set_page_config(page_title="🌍 Travel Planner", page_icon="✈️")

st.title("🌍 AI Travel Planner")

with st.form("travel_form"):
    col1, col2 = st.columns(2)
    
    with col1:
        destination = st.text_input("🏙️ Destination:", placeholder="e.g., Kandy, Tokyo, Paris")
        days = st.number_input("📅 Days:", min_value=1, max_value=30, value=3)
    
    with col2:
        budget_choice = st.selectbox(
            "💰 Budget:",
            options=[1, 2, 3],
            format_func=lambda x: {1: "Budget", 2: "Moderate", 3: "Luxury"}[x]
        )
        interests = st.text_input("🎯 Interests:", placeholder="history, nature, food...")
    
    submitted = st.form_submit_button("🚀 Generate Itinerary", type="primary")

if submitted:
    if destination and interests:
        with st.spinner(f"Creating {days}-day itinerary..."):
            output, error = run_jac(destination, days, budget_choice, interests)
            
            if output:
                st.success("✅ Travel plan ready!")
                st.text(output)
                st.download_button(
                    "📄 Download Plan",
                    data=output,
                    file_name=f"{destination}_plan.txt",
                    mime="text/plain"
                )
            else:
                st.error(f"❌ Error: {error}")
    else:
        st.warning("⚠️ Please fill in destination and interests!")