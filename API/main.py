from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from schemas import ProductInput  # ✅ Reuse the schema if inputs are the same
from predict import predict_production  # ✅ Updated function name
import traceback

app = FastAPI(title="Crop Production Predictor")


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/predict")
def predict(payload: ProductInput):
    try:
        input_dict = payload.dict()
        prediction = predict_production(input_dict)
        return {"predicted_production": round(prediction, 2)}
    except ValueError as ve:
        raise HTTPException(status_code=400, detail=str(ve))
    except Exception as e:
        tb = traceback.format_exc()
        raise HTTPException(status_code=500, detail=f"Server error: {str(e)}\n{tb}")
