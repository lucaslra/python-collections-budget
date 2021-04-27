FROM python:3.8-slim

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1
# Install and setup poetry
RUN pip install -U pip \
    && apt-get update \
    && apt install -y curl netcat \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
ENV PATH="${PATH}:/root/.poetry/bin"

WORKDIR /src/app/

COPY ./pyproject.toml .

RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

COPY . .

RUN groupadd projects && useradd --no-create-home -g projects projects
RUN chown -R projects:projects /src/app
USER projects
