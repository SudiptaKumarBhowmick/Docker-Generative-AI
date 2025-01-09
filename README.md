# A simple Generative AI application

## Features
- Used google flan t5 small LLM model for text to text generation.
- Basic Generative AI LLM model.
- Deployed at Hugging Face platform.

## Demo
[Swagger UI](https://sudiptashuvo-dockergenai.hf.space/docs)

## Installation

### Create Environment
`conda create -p EnvironmentName python==3.9 -y`

### Activate Environment
`conda activate ./EnvironmentName`

### Install the dependencies
`pip install -r requirements.txt`

### Build docker image
`docker build -t docker-gen-ai-model .`

### Run container using the image
`docker run --name=gen-ai-model -d -p 7860:7860 --user root docker-gen-ai-model`

### Access the app
`http://localhost:7860`