# schemas.p

from pydantic import BaseModel, Field

class ProductInput(BaseModel):
    country: str = Field(..., description="Country name (e.g., 'Nigeria')")
    admin_1: str = Field(..., description="State/Province (e.g., 'Kano')")
    crop_production_system: str = Field(..., description="E.g., 'Rainfed (PS)' or 'Irrigated (PS)'")
    product: str = Field(..., description="Crop name (e.g., 'Maize')")
    season_name: str = Field(..., description="Season (e.g., 'Main', 'Dry')")
    planting_month: int = Field(..., ge=1, le=12, description="Month of planting (1–12)")
    harvest_month: int = Field(..., ge=1, le=12, description="Month of harvest (1–12)")
    area: float = Field(..., gt=0, description="Cultivated area in hectares (ha)")
