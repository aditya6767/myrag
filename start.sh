#!/bin/bash

echo Starting ollama
nohup bash -c "ollama serve &" && sleep 5 && ollama run llama2

tail -f -n100 /dev/null

