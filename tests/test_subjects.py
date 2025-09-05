def test_create_subject(client, db_session):
    subject_data = {"name": "Mathematics"}
    response = client.post("/subjects", json=subject_data)
    assert response.status_code == 201
    assert response.json()["name"] == "Mathematics"

def test_read_subjects(client, db_session):
    response = client.get("/subjects")
    assert response.status_code == 200
    assert isinstance(response.json(), list)