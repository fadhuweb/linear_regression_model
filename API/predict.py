import numpy as np
import pandas as pd
import joblib

# Load model and preprocessors
model = joblib.load('best_model.pkl')
scaler = joblib.load('scaler.pkl')
label_encoders = joblib.load('label_encoders.pkl')
feature_names = joblib.load('feature_names.pkl')

def predict_production(input_dict):
    # ✅ Remove unexpected fields like 'yield' if accidentally present
    input_dict.pop('yield', None)

    # Convert input to DataFrame
    input_data = pd.DataFrame([input_dict])

    # ✅ Feature engineering: growing duration
    input_data['growing_duration'] = (input_data['harvest_month'] - input_data['planting_month']) % 12
    input_data['growing_duration'] = input_data['growing_duration'].replace(0, 12)

    # ✅ Label encoding with validation
    for col, le in label_encoders.items():
        value = input_data.at[0, col]
        if value not in le.classes_:
            valid_values = list(le.classes_)
            raise ValueError(
                f"\nInvalid value '{value}' for column '{col}'.\n"
                f"Expected one of: {valid_values}\n"
            )
        input_data[col] = le.transform([value])

    # ✅ One-hot encode product and season_name only if they exist
    for col in ['product', 'season_name']:
        if col in input_data.columns:
            input_data = pd.get_dummies(input_data, columns=[col], drop_first=True)

    # ✅ Add any missing columns from training (dummy or not)
    missing_cols = [col for col in feature_names if col not in input_data.columns]
    for col in missing_cols:
        input_data[col] = 0

    # ✅ Reorder columns to match training data
    input_data = input_data[feature_names]

    # ✅ Scale numeric inputs and predict
    input_scaled = scaler.transform(input_data)
    prediction = model.predict(input_scaled)[0]

    return prediction
