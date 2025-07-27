FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

# 필수 시스템 패키지 설치
RUN apt-get update && apt-get install -y \
    ffmpeg \
    build-essential \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# pip 최신화
RUN python3 -m pip install --upgrade pip

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y \
    build-essential libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install -e .
RUN python3 -m unidic download
RUN python3 melo/init_downloads.py
