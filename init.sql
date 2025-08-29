DROP TABLE IF EXISTS answer_option CASCADE;
DROP TABLE IF EXISTS question CASCADE;
DROP TABLE IF EXISTS topic CASCADE;
DROP TABLE IF EXISTS subject CASCADE;

CREATE TABLE subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE topic (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject_id INT REFERENCES subject(id) ON DELETE CASCADE
);

CREATE TABLE question (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    subject_id INT REFERENCES subject(id) ON DELETE CASCADE,
    topic_id INT REFERENCES topic(id) ON DELETE CASCADE
);

CREATE TABLE answer_option (
    id SERIAL PRIMARY KEY,
    question_id INT REFERENCES question(id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE
);


INSERT INTO subject (name) VALUES 
('Farmacologia'),
('Fisiologia'),
('Patologia');

INSERT INTO topic (name, subject_id) VALUES
('Hipertensão', 1),
('Diabetes', 1),
('Sistema Nervoso', 2),
('Cardiopatias', 3);

INSERT INTO question (text, subject_id, topic_id) VALUES
('Qual classe de fármacos é mais utilizada no tratamento inicial da hipertensão?', 1, 1),
('Qual hormônio está deficiente no Diabetes tipo 1?', 1, 2),
('Qual neurotransmissor está envolvido no controle motor no Parkinson?', 2, 3),
('Qual é a principal complicação da insuficiência cardíaca?', 3, 4);


INSERT INTO answer_option (question_id, text, is_correct) VALUES

(1, 'Betabloqueadores', FALSE),
(1, 'Diuréticos tiazídicos', TRUE),
(1, 'Antidepressivos', FALSE),
(1, 'Antibióticos', FALSE),

(2, 'Insulina', TRUE),
(2, 'Glucagon', FALSE),
(2, 'Adrenalina', FALSE),
(2, 'Cortisol', FALSE),


(3, 'Dopamina', TRUE),
(3, 'Serotonina', FALSE),
(3, 'GABA', FALSE),
(3, 'Noradrenalina', FALSE),


(4, 'Hipertensão arterial', FALSE),
(4, 'Edema pulmonar', TRUE),
(4, 'Diabetes mellitus', FALSE),
(4, 'Alergia medicamentosa', FALSE);