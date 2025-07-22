from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from schemas import YieldInput  # ✅ Import from your schema
from predict import predict_yield  # ✅ Import the prediction logic
import traceback

app = FastAPI(title="Crop Yield Predictor")

# CORS (for testing from frontend or Postman)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/predict")
def predict(payload: YieldInput):
    try:
        input_dict = payload.dict()
        prediction = predict_yield(input_dict)
        return {"predicted_yield": round(prediction, 2)}
    except ValueError as ve:
        raise HTTPException(status_code=400, detail=str(ve))
    except Exception as e:
        tb = traceback.format_exc()
        raise HTTPException(status_code=500, detail=f"Server error: {str(e)}\n{tb}")
