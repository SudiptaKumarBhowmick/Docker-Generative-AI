## Sets the base image for your container. Use the official python image (version 3.9), as the starting point.
## It includes Python and pip pre-installed, providing a consistent runtime environment for your application.
FROM python:3.9

## Set the working directory to /code inside the container. If /code does not exist, it will be created automatically.
## All subsequent commands (COPY, RUN, etc.) will be executed relative to /code.
WORKDIR /code

## Copy the requirements.txt file from your local machine into the container at /code
COPY ./requirements.txt /code/requirements.txt

## Install the requirements.txt
## --no-cache-dir: Prevents pip from caching the packages, which reduces the size of the Docker image.
## --upgrade: Ensures the latest versions of the specified packages are installed.
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

## Set up a new user named "user". It reduces the risk of potential security vulnerabilities.
RUN useradd user

## Switch to the "user" user
USER user

## Set environment variables inside the container
## HOME: Sets the home directory for the user.
## PATH: Adds /home/user/.local/bin to the system path so the container can find executables installed there.
## TRANSFORMERS_CACHE: Defines the cache directory for Hugging Face Transformers, ensuring the model files are cached in a writable location (/tmp).
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    TRANSFORMERS_CACHE=/tmp/transformers_cache

## Set the working directory to the /home/user/app
WORKDIR $HOME/app

## Copy the current directory contents into the container at $HOME/app, setting the owner to the user
## --chown=user: Ensures that the files are owned by the user (non-root) for proper permissions.
COPY --chown=user . $HOME/app

## Defines the command to run when the container starts.
## uvicorn: Starts the FastAPI server.
## app:app -> First "app" refers to the module/ file name (That is app.py). Second "app" refers to the application instance or variable named app, inside the "app.py" file. This is actually the FastAPI application object that serves as the entry point for handling requests.
## --host 0.0.0.0: Ensures the app is accessible from outside the container.
## --port 7860: Runs the app on port 7860.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]