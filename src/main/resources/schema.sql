DROP SEQUENCE IF EXISTS user_id_seq CASCADE;
DROP SEQUENCE IF EXISTS profile_id_seq CASCADE;
DROP SEQUENCE IF EXISTS profile_count_id_seq CASCADE;
DROP SEQUENCE IF EXISTS login_key_id_seq CASCADE;
DROP SEQUENCE IF EXISTS consent_id_seq CASCADE;
DROP SEQUENCE IF EXISTS company_id_seq CASCADE;
DROP SEQUENCE IF EXISTS edu_id_seq CASCADE;
DROP SEQUENCE IF EXISTS profile_sites_id_seq CASCADE;
DROP SEQUENCE IF EXISTS skill_id_seq CASCADE;

-- Create SEQUENCE for Users.user_id
CREATE SEQUENCE IF NOT EXISTS user_id_seq START 100;
-- Create SEQUENCE for Profile.profile_id
CREATE SEQUENCE IF NOT EXISTS profile_id_seq START 100;
-- Create SEQUENCE for Profile_count.profile_count_id
CREATE SEQUENCE IF NOT EXISTS profile_count_id_seq START 100;
-- Create SEQUENCE for Login_Key.login_key_id
CREATE SEQUENCE IF NOT EXISTS login_key_id_seq START 100;
-- Create SEQUENCE for Consent.consent_id
CREATE SEQUENCE IF NOT EXISTS consent_id_seq START 100;
-- Create SEQUENCE for Company.company_id
CREATE SEQUENCE IF NOT EXISTS company_id_seq START 100;
-- Create SEQUENCE for Education.edu_id
CREATE SEQUENCE IF NOT EXISTS edu_id_seq START 100;
-- Create SEQUENCE for Profile_sites.profile_sites_id
CREATE SEQUENCE IF NOT EXISTS profile_sites_id_seq START 100;
-- Create SEQUENCE for Skill.skill_id
CREATE SEQUENCE IF NOT EXISTS skill_id_seq START 100;

DROP TABLE IF EXISTS Users CASCADE;
CREATE table IF not EXISTS Users (
    user_id int primary key default nextval('user_id_seq'),
    user_name varchar not null,
    phone_number varchar not null,
    user_email varchar not null,
    is_active BOOLEAN DEFAULT TRUE
);


-- Create Account table
DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE IF NOT EXISTS Account (
    account_id varchar primary key,
    user_id int references Users(user_id),
    pw_hash VARCHAR NOT NULL,
    last_login_dt TIMESTAMP WITH TIME ZONE,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create Profile table
DROP TABLE IF EXISTS Profile CASCADE;
CREATE TABLE IF NOT EXISTS Profile (
    profile_id INT PRIMARY KEY DEFAULT nextval('profile_id_seq'),
    user_id int references Users(user_id),
    image_url VARCHAR,
    title VARCHAR NOT NULL,
    short_description VARCHAR,
    description VARCHAR,
    links VARCHAR,
    hashtags VARCHAR,
    note VARCHAR,
    profile_job_opt INT NOT NULL,
    openToSearchEngine INT NOT NULL DEFAULT 0,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create Profile_count
DROP TABLE IF EXISTS Profile_Count CASCADE;
CREATE TABLE IF NOT EXISTS Profile_count (
    profile_count_id INT PRIMARY KEY DEFAULT nextval('profile_count_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    subscriber_count INT NOT NULL DEFAULT 0,
    subscribing_count INT NOT NULL DEFAULT 0,
    post_count INT NOT NULL DEFAULT 0,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
);

-- Create Login_Key table
DROP TABLE IF EXISTS Login_Key CASCADE;
CREATE TABLE IF NOT EXISTS Login_Key (
    login_key_id INT PRIMARY KEY DEFAULT nextval('login_key_id_seq'),
    user_id int references Users(user_id),
    access_token VARCHAR UNIQUE NOT NULL,
    refresh_token VARCHAR UNIQUE NOT NULL,
    expire_at TIMESTAMP WITH TIME ZONE NOT NULL,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create Consent table
DROP TABLE IF EXISTS Consent CASCADE;
CREATE TABLE IF NOT EXISTS Consent (
    consent_id INT PRIMARY KEY DEFAULT nextval('consent_id_seq'),
    user_id int references Users(user_id),
    marketing_consent BOOLEAN NOT NULL,
    terms_conditions_consent BOOLEAN NOT NULL,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
);

-- Create Company table
DROP TABLE IF EXISTS Company CASCADE;
CREATE TABLE IF NOT EXISTS Company (
    company_id INT PRIMARY KEY DEFAULT nextval('company_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    company_nm VARCHAR NOT NULL,
    company_position VARCHAR NOT NULL,
    description VARCHAR,
    current_state INT NOT NULL,
    url VARCHAR,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create Education table
DROP TABLE IF EXISTS Education CASCADE;
CREATE TABLE IF NOT EXISTS Education (
    edu_id INT PRIMARY KEY DEFAULT nextval('edu_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    institute VARCHAR NOT NULL,
    major VARCHAR NOT NULL,
    description VARCHAR,
    current_state INTEGER NOT NULL,
    url VARCHAR,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create Profile_sites table
DROP TABLE IF EXISTS Profile_sites CASCADE;
CREATE TABLE IF NOT EXISTS Profile_sites (
    profile_sites_id INT PRIMARY KEY DEFAULT nextval('profile_sites_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Create Skill table
DROP TABLE IF EXISTS Skill CASCADE;
CREATE TABLE IF NOT EXISTS Skill (
    skill_id INT PRIMARY KEY DEFAULT nextval('skill_id_seq'),
    skill_name VARCHAR NOT NULL,
    category VARCHAR NOT NULL,
    second_category VARCHAR NOT NULL,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
);

-- Create Profile_skill table
DROP TABLE IF EXISTS Profile_Skill CASCADE;
CREATE TABLE IF NOT EXISTS Profile_skill (
    profile_id INT REFERENCES Profile(profile_id),
    skill_id INT REFERENCES Skill(skill_id),
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME zone,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY(profile_id, skill_id)
);

ALTER SEQUENCE user_id_seq OWNED BY Users.user_id;
ALTER SEQUENCE profile_id_seq OWNED BY Profile.profile_id;
ALTER SEQUENCE profile_count_id_seq OWNED BY Profile_count.profile_count_id;
ALTER SEQUENCE login_key_id_seq OWNED BY Login_Key.login_key_id;
ALTER SEQUENCE consent_id_seq OWNED BY Consent.consent_id;
ALTER SEQUENCE company_id_seq OWNED BY Company.company_id;
ALTER SEQUENCE edu_id_seq OWNED BY Education.edu_id;
ALTER SEQUENCE profile_sites_id_seq OWNED BY Profile_sites.profile_sites_id;
ALTER SEQUENCE skill_id_seq OWNED BY Skill.skill_id;