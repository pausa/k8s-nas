FROM ollama/ollama
RUN ollama serve & \
    ollama pull mistral:7b-instruct
CMD ["ollama", "serve", "mistral:7b-instruct"]
