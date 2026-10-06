from pydantic import BaseModel
from typing import Optional
from datetime import date

#-------------------Peliculas-------------------

class Pelis(BaseModel):
    pelicula_id:int
    titulo: str
    sinopsis: Optional[str] = None
    fecha: date
    link: Optional[str] = None
    genero: list[int]
    class Config:
        orm_mode = True

class Pelis_con_estado(BaseModel):
    pelicula_id:int
    comentario: Optional[str] = None
    calificacion: Optional[int] = None
    estado: bool
    fecha_vista: Optional[date] = None
    
#-------------------Usuario_Pelicula-------------------
      
class peli_user(BaseModel):
    comentario: Optional[str] = None
    calificacion: Optional[int] = None
    estado: bool
    fecha_vista: Optional[date] = None
    
    owner: Pelis
    class Config:
        orm_mode = True
    
class peli_user_update(BaseModel):
    comentario: Optional[str] = None
    calificacion: Optional[int] = None
    estado: Optional[bool]
    fecha_vista: Optional[date] = None

#-------------------Genero-------------------
 
class genero(BaseModel):
    nombre_genero: str
    