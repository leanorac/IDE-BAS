-- Создание таблицы кандидатов
CREATE TABLE candidate (
    candidate_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы резюме
CREATE TABLE resume (
    resume_id SERIAL PRIMARY KEY,
    candidate_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    summary TEXT,
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
);

-- Создание таблицы навыков
CREATE TABLE skill (
    skill_id SERIAL PRIMARY KEY,
    resume_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    level VARCHAR(20),
    FOREIGN KEY (resume_id) REFERENCES resume(resume_id)
);

-- Создание таблицы опыта работы
CREATE TABLE experience (
    experience_id SERIAL PRIMARY KEY,
    resume_id INT NOT NULL,
    company VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    description TEXT,
    FOREIGN KEY (resume_id) REFERENCES resume(resume_id)
);

-- Создание таблицы образования
CREATE TABLE education (
    education_id SERIAL PRIMARY KEY,
    resume_id INT NOT NULL,
    institution VARCHAR(100) NOT NULL,
    degree VARCHAR(50) NOT NULL,
    field_of_study VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (resume_id) REFERENCES resume(resume_id)
);

-- Создание таблицы вакансий
CREATE TABLE vacancy (
    vacancy_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    department VARCHAR(50),
    status VARCHAR(20) DEFAULT 'open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы требований к вакансии
CREATE TABLE requirement (
    requirement_id SERIAL PRIMARY KEY,
    vacancy_id INT NOT NULL,
    skill_name VARCHAR(50) NOT NULL,
    min_level VARCHAR(20),
    min_experience_years INT,
    FOREIGN KEY (vacancy_id) REFERENCES vacancy(vacancy_id)
);

-- Создание таблицы результатов анализа
CREATE TABLE analysis_result (
    analysis_id SERIAL PRIMARY KEY,
    resume_id INT NOT NULL,
    vacancy_id INT NOT NULL,
    match_score FLOAT NOT NULL,
    strengths TEXT,
    weaknesses TEXT,
    recommendations TEXT,
    analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resume_id) REFERENCES resume(resume_id),
    FOREIGN KEY (vacancy_id) REFERENCES vacancy(vacancy_id)
);

-- Создание индексов для ускорения поиска
CREATE INDEX idx_resume_candidate ON resume(candidate_id);
CREATE INDEX idx_skill_resume ON skill(resume_id);
CREATE INDEX idx_experience_resume ON experience(resume_id);
CREATE INDEX idx_education_resume ON education(resume_id);
CREATE INDEX idx_requirement_vacancy ON requirement(vacancy_id);
CREATE INDEX idx_analysis_resume ON analysis_result(resume_id);
CREATE INDEX idx_analysis_vacancy ON analysis_result(vacancy_id);
