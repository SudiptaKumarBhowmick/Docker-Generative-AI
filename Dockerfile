## Use the official python image
FROM python:3.9

## Set the working directory to /code
WORKDIR /code

## Copy the current directory contents into the container at /code
COPY ./requirements.txt /code/requirements.txt

## Install the requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

## Set up a new user named user
USER user

## Set environment variables
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    TRANSFORMERS_CACHE=/tmp/transformers_cache

## Set the working directory to the user's home directory
WORKDIR $HOME/app

## Copy the current directory contents into the container at $HOME/app setting the owner to the user
COPY --chown=user . $HOME/app

## Start the FastAPI app on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]