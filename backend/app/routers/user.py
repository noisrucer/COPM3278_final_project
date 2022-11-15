from fastapi import APIRouter

router = APIRouter(
    prefix="/user",
    tags="user"
)

@router.get("/{login_token}")
async def get_user_info_by_token(login_token: str):
    pass