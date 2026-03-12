import pytest
from app import app as flask_app

@pytest.fixture
def app():
    flask_app.config["TESTING"] = True
    yield flask_app

@pytest.fixture
def client(app):
    return app.test_client()

def test_home_returns_200(client):
    response = client.get("/")
    assert response.status_code == 200

def test_home_returns_json(client):
    response = client.get("/")
    data = response.get_json()
    assert "message" in data

def test_health_check(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"

def test_info_endpoint(client):
    response = client.get("/info")
    assert response.status_code == 200