import os
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, Field
from typing import List, Optional
from sqlalchemy import create_engine, Column, Integer, String, Float, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session

# Initialize FastAPI app with enhanced metadata for Swagger UI
app = FastAPI(
    title="Product Catalog API",
    description="A simple API for managing a product catalog",
    version="1.0.0",
    openapi_tags=[
        {
            "name": "Products",
            "description": "Operations related to products in the catalog"
        }
    ]
)

# Setup SQLAlchemy with Neon
DATABASE_URL = os.environ.get(
    "DATABASE_URL", 
    "postgresql://neondb_owner:npg_g7OojvYHx0fF@ep-rough-rice-adl1il6g-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require"
)
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Define SQLAlchemy model
class ProductModel(Base):
    __tablename__ = "products"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    price = Column(Float)
    description = Column(Text, nullable=True)

# Create tables
Base.metadata.create_all(bind=engine)

# Define Pydantic model for API with enhanced field descriptions
class Product(BaseModel):
    id: int = Field(..., description="Unique identifier for the product")
    name: str = Field(..., description="Name of the product", example="Laptop")
    price: float = Field(..., description="Price of the product in USD", example=999.99)
    description: Optional[str] = Field(None, description="Detailed description of the product", example="High-performance laptop with SSD")
    
    class Config:
        orm_mode = True

# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/products", response_model=List[Product], tags=["Products"])
async def list_products(db: Session = Depends(get_db)):
    """
    Retrieve a list of all products in the catalog.
    
    Returns:
        List[Product]: A list of all product objects in the database
    """
    products = db.query(ProductModel).all()
    return products

@app.get("/products/{product_id}", response_model=Product, tags=["Products"])
async def get_product(product_id: int, db: Session = Depends(get_db)):
    """
    Retrieve a specific product by its ID.
    
    Parameters:
        product_id (int): The ID of the product to retrieve
        
    Returns:
        Product: The requested product
        
    Raises:
        HTTPException: If the product is not found (404)
    """
    product = db.query(ProductModel).filter(ProductModel.id == product_id).first()
    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    return product

@app.post("/products", response_model=Product, status_code=201, tags=["Products"])
async def add_product(product: Product, db: Session = Depends(get_db)):
    """
    Add a new product to the catalog.
    
    Parameters:
        product (Product): The product object to add
        
    Returns:
        Product: The newly created product
    """
    db_product = ProductModel(id=product.id, name=product.name, price=product.price, description=product.description)
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product