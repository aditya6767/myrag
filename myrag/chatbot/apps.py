import logging

from django.apps import AppConfig
from .ai.model import initialize_rag

logger = logging.getLogger(__name__)

class ChatbotConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'chatbot'

    def ready(self) -> None:
        initialize_rag()
        logger.info("Initialised RAG")
