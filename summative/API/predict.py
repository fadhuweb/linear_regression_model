import joblib
import pandas as pd

# Load model, scaler, and feature column names
model = joblib.load(r'C:\Users\fadhl\OneDrive\Desktop\linear_regression_model\summative\linear_regression\best_model.pkl')
scaler = joblib.load(r'C:\Users\fadhl\OneDrive\Desktop\linear_regression_model\summative\linear_regression\scaler.pkl')
feature_columns = joblib.load(r'C:\Users\fadhl\OneDrive\Desktop\linear_regression_model\summative\linear_regression\feature_columns.pkl')

def predict_grade(input_data: dict) -> float:
    input_df = pd.DataFrame([input_data])
    input_df = input_df.reindex(columns=feature_columns, fill_value=0)
    input_scaled = scaler.transform(input_df)
    input_scaled_df = pd.DataFrame(input_scaled, columns=feature_columns)
    prediction = model.predict(input_scaled_df)[0]
    return round(prediction, 2)


# Optional test
if __name__ == "__main__":
    test_input = {
        'sex': 0,
        'address': 1,
        'famsize': 1,
        'Pstatus': 1,
        'schoolsup': 0,
        'famsup': 1,
        'paid': 0,
        'activities': 0,
        'nursery': 1,
        'higher': 1,
        'internet': 1,
        'romantic': 0,
        'age': 17,
        'Medu': 4,
        'Fedu': 4,
        'traveltime': 1,
        'studytime': 2,
        'failures': 0,
        'famrel': 4,
        'freetime': 3,
        'goout': 3,
        'Dalc': 1,
        'Walc': 1,
        'health': 5,
        'absences': 4,
        'G1': 15,
        'G2': 15,
        'school_MS': 1,
        'Mjob_health': 0,
        'Mjob_other': 1,
        'Mjob_services': 0,
        'Mjob_teacher': 0,
        'Fjob_other': 0,
        'Fjob_services': 1,
        'Fjob_health': 0,
        'Fjob_at_home': 0,
        'Fjob_teacher': 0,  # Add any missing columns with 0
        'reason_home': 0,
        'reason_other': 0,
        'reason_reputation': 1,
        'guardian_mother': 1,
        'guardian_other': 0,
        'guardian_father': 0  # Any additional fields should also be covered
    }

    print(predict_grade(test_input))
