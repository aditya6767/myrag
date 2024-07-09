import logging

from rest_framework import status
from rest_framework.views import APIView
from rest_framework.request import Request
from rest_framework.response import Response

from ..ai import chat

logger = logging.getLogger(__name__)


class PostQuestionView(APIView):

    def post(self, request: Request, *args, **kwargs) -> Response:
        try:
            question = request.data.get('question', '')

            if not question:
                logger.error("No question asked")
                return Response(status=status.HTTP_400_BAD_REQUEST)

            resp = chat(question)
            data = {'answer':resp}
            return Response(data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.error(f"Error while posting question {e}")
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


