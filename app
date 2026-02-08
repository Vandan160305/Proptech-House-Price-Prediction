# ['number of bedrooms', 'number of bathrooms', 'living area',
#        'condition of the house', 'Number of schools nearby']

# import streamlit as st
# import numpy as np
# import joblib

# model = joblib.load(r"C:\Users\patel\OneDrive\Desktop\Proptech(House Price Prediction)\Models\model.pkl")

# st.title("House Price Prediction App")

# st.divider()

# st.write("This App Uses Machine Learning to Predict House Prices With The Given Features Of The House. For Using This App You Can Enter The Inputs From This UI and Then Click On The Predict Button To Get The Predicted Price Of The House.")

# st.divider()

# bedrooms = st.number_input("Number of Bedrooms", min_value=0, value=0)
# bathrooms = st.number_input("Number of Bathrooms", min_value=0, value=0)
# living_area = st.number_input("Living Area (in sqft)", min_value=0, value=2000)
# condition = st.number_input("Condition of the House",min_value=0, value=3)
# numberofschools = st.number_input("Number of Schools Nearby", value=0)

# st.divider()

# X = [[bedrooms, bathrooms, living_area, condition, numberofschools]]

# predict_button = st.button("Predict!")

# if predict_button:
#     st.balloons()
#     X_array = np.array(X)
#     prediction = model.predict(X_array)[0]
#     st.write(f"The predicted price of the house is {prediction:,.2f}")
# else:
#     st.write("Please enter all the values to get a prediction.")




from flask import Flask, request, jsonify
import numpy as np
import joblib

app = Flask(__name__)

# Load model
model = joblib.load(r"C:\Users\patel\OneDrive\Desktop\Proptech(House Price Prediction)\Models\model.pkl")
@app.route("/predict", methods=["POST"])
def predict():
    data = request.json

    bedrooms = data["bedrooms"]
    bathrooms = data["bathrooms"]
    living_area = data["living_area"]
    condition = data["condition"]
    schools = data["schools"]

    X = np.array([[bedrooms, bathrooms, living_area, condition, schools]])
    prediction = model.predict(X)[0]

    return jsonify({
        "predicted_price": float(prediction)
    })

if __name__ == "__main__":
    app.run(debug=True)
