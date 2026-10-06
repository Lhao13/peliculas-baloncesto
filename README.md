# Películas de baloncesto

**Trabajo final de Programación de Aplicaciones**

**Fecha del trabajo: 17/05/2024**

Aplicación concebida para recomendar películas relacionadas con el baloncesto según las características o categorías que seleccione el usuario. El proyecto reúne trabajos previos del equipo: dos proyectos relacionados con el baloncesto y un catálogo de películas, con la idea de convertir ese catálogo en una forma de descubrir películas de baloncesto.

El informe describe el trabajo de **Leandro Coral, Fabián De La Cruz y Matías Reyes**. Mi aporte fue la aplicación de catálogo de películas, disponible en [peliculas_list](https://github.com/Lhao13/peliculas_list).

Las preferencias de contenido contempladas en la aplicación son **Otro**, **Internacional**, **High School**, **NCAA/College** y **NBA/WNBA**.

## Qué incluye

- Código fuente parcial de la interfaz Flutter/Dart.
- Una API en Python con FastAPI para consultar películas y géneros y gestionar las películas asociadas a un usuario.
- Modelos de datos y una migración Alembic para PostgreSQL.
- Archivos SQL y Java de trabajos anteriores relacionados con baloncesto y acceso REST.
- Un archivo CSV con datos de películas.

## Importante: código Flutter incompleto

Para ahorrar espacio no se incluyó el proyecto Flutter completo: la carpeta `Final/Flutter` contiene únicamente algunos archivos fuente `.dart`. Faltan, entre otros, `pubspec.yaml`, recursos y otros archivos de configuración. Por ello, **este repositorio por sí solo no permite ejecutar `flutter pub get` ni compilar o iniciar la aplicación**; se necesita completar esos archivos con el proyecto Flutter original.

Las carpetas `Final/BDD Log In` y `Final/Rest Log In` también contienen archivos sueltos de trabajos anteriores y no incluyen toda la configuración necesaria para ejecutarlos como proyectos independientes.

## Tecnologías

- Flutter y Dart (fragmentos de la interfaz).
- Python, FastAPI y SQLAlchemy (API).
- PostgreSQL y Alembic (persistencia y migraciones).
- ngrok (exponer la API durante las pruebas).

## API

La API está en `py_api_basket`. Necesita Python, PostgreSQL y las variables de entorno de conexión y configuración. No se incluye ninguna credencial; crea `py_api_basket/.env` a partir de `.env.example` y completa sus valores localmente. No publiques ese archivo ni claves privadas.

Desde esa carpeta, instala las dependencias, aplica la migración y arranca el servidor:

```bash
python -m venv .venv
python -m pip install -r requirements.txt
cp .env.example .env
alembic upgrade head
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Antes de arrancar, edita `.env` con las credenciales de tu PostgreSQL y una clave secreta local. En Windows PowerShell puedes copiar la plantilla con `Copy-Item .env.example .env`.

Para probar desde un dispositivo o acceder a la API por Internet, el informe indica que se utilizó ngrok. Por ejemplo, se puede exponer el puerto local `8000` con `ngrok http 8000`. Después de iniciar o reiniciar el túnel, actualiza la URL base en `Final/Flutter/globals.dart` con la URL nueva de ngrok. El servicio remoto original puede dejar de estar disponible y no forma parte de este repositorio.

La base de datos debe estar creada antes de ejecutar las migraciones. La API usa PostgreSQL; revisa que `py_api_basket/.env` contenga los valores correctos para tu entorno.

## Estructura

```text
Final/
  BDD Log In/      Scripts SQL del trabajo de baloncesto
  Flutter/         Archivos Dart seleccionados; proyecto incompleto
  Rest Log In/     Archivos Java del trabajo de acceso REST
py_api_basket/
  app/             API FastAPI, modelos y rutas
  alembic/         Migraciones de PostgreSQL
datapelis+num.csv  Datos de películas
```

## Alcance

Este repositorio documenta una entrega académica que integra ideas y componentes de proyectos anteriores. No es una distribución completa lista para instalar: faltan partes del proyecto Flutter y la disponibilidad de la API depende de la configuración local y del túnel ngrok.
