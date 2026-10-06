from .database import Base
from sqlalchemy.orm import relationship
from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, Date, ARRAY
from sqlalchemy.ext.mutable import MutableList


    
class Pelis(Base):
    __tablename__ = "pelicula"
    
    pelicula_id = Column(Integer, primary_key=True, nullable=False, unique=True)
    titulo = Column(String, nullable=False)
    sinopsis = Column(String)
    fecha= Column(Date, nullable=False)
    link = Column(String)
    genero = Column(MutableList.as_mutable(ARRAY(Integer)))
    numero = Column(Integer, nullable=False)
    
class peli_user(Base):
    __tablename__ = "peli_user"
    
    persona_id_2 = Column(Integer, primary_key=True , nullable=False)
    pelicula_id_2 = Column(Integer, ForeignKey("pelicula.pelicula_id", ondelete="CASCADE"), primary_key=True , nullable=False)
    comentario = Column(String)
    calificacion = Column(Integer)
    estado = Column(Boolean, nullable=False)
    fecha_vista = Column(Date)
    
    owner=relationship("Pelis")
    
    
class genero(Base):
    __tablename__ = "genero"
    
    genero_id = Column(Integer, primary_key=True, nullable=False)
    nombre_genero = Column(String, nullable=False)
    