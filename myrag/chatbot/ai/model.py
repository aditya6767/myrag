import os
import logging

from django.conf import settings
from langchain.llms import GPT4All
from langchain_community.llms import Ollama
from langchain.vectorstores import Chroma
from langchain.chains import ConversationalRetrievalChain
from langchain.embeddings import HuggingFaceEmbeddings
from bs4 import BeautifulSoup as Soup

logger = logging.getLogger(__name__)

CHECKPOINTS_PATH = os.getenv('CHECKPOINTS_PATH', '/srv/data/checkpoints/')
OLLAMA_HOST = os.getenv('OLLAMA_HOST', '172.17.0.1')
OLLAMA_PORT = os.getenv('OLLAMA_PORT', '11434')
OLLAMA_MODEL = os.getenv('OLLAMA_MODEL', 'llama2')

global conversation
conversation = None

def initialize_rag():
    global conversation
    embeddings = HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")
    vectordb = Chroma(persist_directory=settings.INDEX_PERSIST_DIRECTORY,embedding_function=embeddings)

    # create conversation
    llm = Ollama(
        # model=os.path.join(CHECKPOINTS_PATH, "nous-hermes-llama2-13b.Q4_0.gguf"),
        model=OLLAMA_MODEL,
        base_url=f"http://{OLLAMA_HOST}:{OLLAMA_PORT}",
        verbose=True,
    )
    conversation = ConversationalRetrievalChain.from_llm(
        llm,
        retriever=vectordb.as_retriever(),
        return_source_documents=True,
        verbose=True,
    )
    logger.info(f"initialized RAG")

def chat(question):
    global conversation

    chat_history = []
    response = conversation({"question": question, "chat_history": chat_history})
    answer = response['answer']

    logger.info(f"got response from llm - {answer}")

    return answer
