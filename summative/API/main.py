from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
from predict import predict_grade

app = FastAPI()

# Allow requests from any frontend (including Flutter)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # You can restrict this later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define expected input format using Pydantic
class StudentData(BaseModel):
    sex: int = Field(..., ge=0, le=1)
    address: int = Field(..., ge=0, le=1)
    famsize: int = Field(..., ge=0, le=1)
    Pstatus: int = Field(..., ge=0, le=1)
    schoolsup: int = Field(..., ge=0, le=1)
    famsup: int = Field(..., ge=0, le=1)
    paid: int = Field(..., ge=0, le=1)
    activities: int = Field(..., ge=0, le=1)
    nursery: int = Field(..., ge=0, le=1)
    higher: int = Field(..., ge=0, le=1)
    internet: int = Field(..., ge=0, le=1)
    romantic: int = Field(..., ge=0, le=1)
    age: int
    Medu: int
    Fedu: int
    traveltime: int
    studytime: int
    failures: int
    famrel: int
    freetime: int
    goout: int
    Dalc: int
    Walc: int
    health: int
    absences: int
    G1: int
    G2: int
    school_MS: int
    Mjob_health: int
    Mjob_other: int
    Mjob_services: int
    Mjob_teacher: int
    Fjob_other: int
    Fjob_services: int
    Fjob_health: int
    Fjob_at_home: int
    Fjob_teacher: int
    reason_home: int
    reason_other: int
    reason_reputation: int
    guardian_mother: int
    guardian_other: int
    guardian_father: int

@app.post("/predict")
def predict(data: StudentData):
    # Convert to dictionary and predict
    prediction = predict_grade(data.dict())
    return {"predicted_g3": prediction}
