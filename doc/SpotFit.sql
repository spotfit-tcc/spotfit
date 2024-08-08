CREATE DATABASE IF NOT EXISTS spotfit;
USE spotfit;

CREATE TABLE IF NOT EXISTS EmailContact (
    email_contact_id INT AUTO_INCREMENT PRIMARY KEY,
    person_name VARCHAR(255) NOT NULL,
    person_email VARCHAR(255) NOT NULL,
    message VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS RegisterType (
    register_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    country VARCHAR(100)  NOT NULL,
    type_description VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Profession (
    profession_id INT AUTO_INCREMENT PRIMARY KEY,
    profession_name VARCHAR(100) NOT NULL,
    profession_description TEXT
);

CREATE TABLE IF NOT EXISTS Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    cpf_or_cnpj VARCHAR(20) NOT NULL,
    profile_photo VARCHAR(255),
    professional VARCHAR(100),
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Consulting (
    consulting_id INT AUTO_INCREMENT PRIMARY KEY,
    consulting_name VARCHAR(255) NOT NULL,
    description TEXT,
    contact_email VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    adm_user_id INT,
    FOREIGN KEY (adm_user_id) REFERENCES User(user_id)
);

CREATE TABLE IF NOT EXISTS ConsultingProfessional (
    consulting_professional_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    instagram VARCHAR(255),
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    consulting_id INT,
    FOREIGN KEY (consulting_id) REFERENCES Consulting(consulting_id)
);

CREATE TABLE IF NOT EXISTS ProfessionalRegister (
    professional_register_id INT AUTO_INCREMENT PRIMARY KEY,
    consulting_professional_id INT,
    profession_id INT,
    register_type_id INT,
    register VARCHAR(255) NOT NULL,
    FOREIGN KEY (consulting_professional_id) REFERENCES ConsultingProfessional(consulting_professional_id),
    FOREIGN KEY (profession_id) REFERENCES Profession(profession_id),
    FOREIGN KEY (register_type_id) REFERENCES RegisterType(register_type_id)
);

CREATE TABLE IF NOT EXISTS ConsultingBenefit (
    consulting_benefit_id INT AUTO_INCREMENT PRIMARY KEY,
    benefit VARCHAR(255) NOT NULL,
    description TEXT,
    icon VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS ConsultingBenefitProfessional (
    consulting_benefit_id INT,
    consulting_professional_id INT,
    PRIMARY KEY (consulting_benefit_id, consulting_professional_id),
    FOREIGN KEY (consulting_benefit_id) REFERENCES ConsultingBenefit(consulting_benefit_id),
    FOREIGN KEY (consulting_professional_id) REFERENCES ConsultingProfessional(consulting_professional_id)
);

CREATE TABLE IF NOT EXISTS ConsultingComment (
    id_consulting_comment INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    consulting_id INT NOT NULL,
    comment_type VARCHAR(50),
    comment_text TEXT,
    rating DECIMAL(2,1),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (consulting_id) REFERENCES Consulting(consulting_id)
);

CREATE TABLE IF NOT EXISTS ConsultingPlan (
    consulting_plans_id INT AUTO_INCREMENT PRIMARY KEY,
    consulting_id INT NOT NULL,
    plan VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    period VARCHAR(50) NOT NULL,
    FOREIGN KEY (consulting_id) REFERENCES Consulting(consulting_id)
);

CREATE TABLE IF NOT EXISTS ConsultingPlanBenefit (
    consulting_plans_id INT,
    id_beneficio_consultoria INT,
    PRIMARY KEY (consulting_plans_id, id_beneficio_consultoria),
    FOREIGN KEY (consulting_plans_id) REFERENCES ConsultingPlan(consulting_plans_id),
    FOREIGN KEY (id_beneficio_consultoria) REFERENCES ConsultingBenefit(consulting_benefit_id)
);

CREATE TABLE IF NOT EXISTS ConsultingImage (
    consulting_image_id INT AUTO_INCREMENT PRIMARY KEY,
    description TEXT,
    image_dir VARCHAR(255),
    consulting_id INT,
    FOREIGN KEY (consulting_id) REFERENCES Consulting(consulting_id)
);

CREATE TABLE IF NOT EXISTS ConsultingCategory (
    consulting_id INT,
    category_id INT,
    PRIMARY KEY (consulting_id, category_id),
    FOREIGN KEY (consulting_id) REFERENCES Consulting(consulting_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE IF NOT EXISTS ConsultingAccess (
    user_id INT,
    consulting_id INT,
    liked BOOLEAN,
    PRIMARY KEY (user_id, consulting_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (consulting_id) REFERENCES Consulting(consulting_id)
);

