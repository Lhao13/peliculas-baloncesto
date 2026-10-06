from .. import models, schemas
from fastapi import FastAPI, Response, status, HTTPException, Depends, APIRouter
from sqlalchemy.orm import Session
from ..database import get_db
from typing import Optional

router = APIRouter(prefix="/pelicula", tags=["pelicula"])

@router.post("/", status_code=status.HTTP_201_CREATED)
def crearPelicula(peli: schemas.Pelis, db: Session = Depends(get_db)):
    new_peli=models.Pelis(**peli.dict())
    db.add(new_peli)
    db.commit()
    db.refresh(new_peli)
    return  new_peli

@router.get("/", response_model=list[schemas.Pelis])
def getPeliculas(db: Session = Depends(get_db), 
                   search: Optional[str] ="", limit: int = 20):
    peliculas=db.query(models.Pelis).\
    filter(models.Pelis.titulo.contains(search)).\
    limit(limit).\
    all()
    return peliculas

@router.get("/{id}", response_model=list[schemas.Pelis])
def getPelicula_id(id: int, db: Session = Depends(get_db)):
    pelicula=db.query(models.Pelis).filter(models.Pelis.numero == id).all()
    
    if not pelicula:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"El {id} no se encuentra en la base de datos")  
    return  pelicula

