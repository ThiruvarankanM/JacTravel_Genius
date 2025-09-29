# 🌍 AI Travel Planner

An interactive AI-powered travel itinerary generator. Enter your destination, trip duration, budget, and interests, and instantly receive a detailed, realistic travel plan—complete with daily activities, local prices, and travel tips.

## Features

- **Streamlit Web App**: User-friendly interface for input and itinerary display.
- **AI-Powered Planning**: Uses LLMs (via Jac and byllm) to generate personalized, multi-day travel plans.
- **Local Currency & Realistic Costs**: All prices are in the destination's local currency, not USD.
- **Downloadable Plans**: Export your itinerary as a text file.
- **Customizable**: Choose your budget (Budget, Moderate, Luxury) and specify interests.

## Demo

[![Demo Video](https://img.youtube.com/vi/o55G-XqW5Ko/0.jpg)](https://youtu.be/o55G-XqW5Ko)


## Getting Started

### Prerequisites

- Python 3.8+
- [Jaclang](https://jaclang.com/) installed and available in your PATH

### Installation

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd Jac_agentic
   ```

2. **Install dependencies:**
   ```sh
   pip install -r requirements.txt
   ```

3. **(Optional) Set up environment variables:**
   - If using API keys for LLMs, create a `.env` file as needed.

### Usage

1. **Run the Streamlit app:**
   ```sh
   streamlit run app.py
   ```

2. **Fill in the form:**
   - Destination (e.g., Kandy, Tokyo, Paris)
   - Number of days (1–30)
   - Budget (Budget, Moderate, Luxury)
   - Interests (e.g., history, nature, food)

3. **Generate your itinerary!**
   - View, copy, or download your travel plan.

### How It Works

- The Streamlit app collects your preferences and runs the Jac program (`main.jac`) with your inputs.
- The Jac program uses an LLM (via byllm) to generate a detailed travel plan, including daily activities, costs, and tips.
- The plan is displayed in the app and can be downloaded.

### File Structure

- `app.py` — Streamlit frontend and Jac integration
- `main.jac` — Jac program for AI itinerary generation
- `requirements.txt` — Python dependencies

### Dependencies

- `jaclang`
- `Streamlit`
- `byllm`
- `python-dotenv`

Install all with:
```sh
pip install -r requirements.txt
```

### Notes

- Ensure the `jac` executable is available in your environment.
- The LLM model used is Gemini 2.5 Flash (configurable in `main.jac`).
- All costs are shown in the local currency of the destination.

## License

MIT License
