-- Create SEQUENCE for Profile.profile_id
CREATE SEQUENCE IF NOT EXISTS profile_id_seq;
-- Create SEQUENCE for Profile_count.profile_count_id
CREATE SEQUENCE IF NOT EXISTS profile_count_id_seq;
-- Create SEQUENCE for Token.token_id
CREATE SEQUENCE IF NOT EXISTS token_id_seq;
-- Create SEQUENCE for Consent.consent_id
CREATE SEQUENCE IF NOT EXISTS consent_id_seq;
-- Create SEQUENCE for Company.company_id
CREATE SEQUENCE IF NOT EXISTS company_id_seq;
-- Create SEQUENCE for Education.edu_id
CREATE SEQUENCE IF NOT EXISTS edu_id_seq;
-- Create SEQUENCE for Profile_sites.profile_sites_id
CREATE SEQUENCE IF NOT EXISTS profile_sites_id_seq;
-- Create SEQUENCE for Skill.skill_id
CREATE SEQUENCE IF NOT EXISTS skill_id_seq;


-- Create Account table
CREATE TABLE IF NOT EXISTS Account (
                                       account_email_id VARCHAR PRIMARY KEY,
                                       pw_hash VARCHAR NOT NULL,
                                       last_login_dt TIMESTAMP WITH TIME ZONE,
                                       create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       update_at TIMESTAMP WITH TIME ZONE
);


-- Create Profile table
CREATE TABLE IF NOT EXISTS Profile (
    profile_id INT PRIMARY KEY DEFAULT nextval('profile_id_seq'),
    account_email_id VARCHAR REFERENCES Account(account_email_id),
    name VARCHAR NOT NULL,
    image_url VARCHAR,
    title VARCHAR NOT NULL,
    phone_number VARCHAR NOT NULL,
    short_description VARCHAR,
    description VARCHAR,
    links VARCHAR,
    hashtags VARCHAR,
    note VARCHAR,
    profile_job_opt INT NOT NULL,
    openToSearchEngine INT NOT NULL DEFAULT 0,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Profile_count
CREATE TABLE IF NOT EXISTS Profile_count (
    profile_count_id INT PRIMARY KEY DEFAULT nextval('profile_count_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    subscriber_count INT NOT NULL DEFAULT 0,
    subscribing_count INT NOT NULL DEFAULT 0,
    post_count INT NOT NULL DEFAULT 0,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Token table
CREATE TABLE IF NOT EXISTS Token (
    token_id INT PRIMARY KEY DEFAULT nextval('token_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    access_token VARCHAR UNIQUE,
    refresh_token VARCHAR UNIQUE,
    expire_at TIMESTAMP WITH TIME ZONE NOT NULL,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
                            );

-- Create Consent table
CREATE TABLE IF NOT EXISTS Consent (
    consent_id INT PRIMARY KEY DEFAULT nextval('consent_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    marketing_consent BOOLEAN NOT NULL,
    terms_conditions_consent BOOLEAN NOT NULL,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Company table
CREATE TABLE IF NOT EXISTS Company (
    company_id INT PRIMARY KEY DEFAULT nextval('company_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    company_nm VARCHAR NOT NULL,
    company_position VARCHAR NOT NULL,
    description VARCHAR,
    is_current INT NOT NULL,
    url VARCHAR,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Education table
CREATE TABLE IF NOT EXISTS Education (
    edu_id INT PRIMARY KEY DEFAULT nextval('edu_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    institute VARCHAR NOT NULL,
    major VARCHAR NOT NULL,
    description VARCHAR,
    is_current INT NOT NULL,
    url VARCHAR,
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Profile_sites table
CREATE TABLE IF NOT EXISTS Profile_sites (
    profile_sites_id INT PRIMARY KEY DEFAULT nextval('profile_sites_id_seq'),
    profile_id INT REFERENCES Profile(profile_id),
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Skill table
CREATE TABLE IF NOT EXISTS Skill (
    skill_id INT PRIMARY KEY DEFAULT nextval('skill_id_seq'),
    name VARCHAR NOT NULL,
    category VARCHAR NOT NULL,
    second_category VARCHAR NOT NULL,
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME ZONE
                            );

-- Create Profile_skill table
CREATE TABLE IF NOT EXISTS Profile_skill (
    profile_id INT REFERENCES Profile(profile_id),
    skill_id INT REFERENCES Skill(skill_id),
    create_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP WITH TIME zone,
                            primary key(profile_id, skill_id)
    );

ALTER SEQUENCE profile_id_seq OWNED BY Profile.profile_id;
ALTER SEQUENCE profile_count_id_seq OWNED BY Profile_count.profile_count_id;
ALTER SEQUENCE token_id_seq OWNED BY Token.token_id;
ALTER SEQUENCE consent_id_seq OWNED BY Consent.consent_id;
ALTER SEQUENCE company_id_seq OWNED BY Company.company_id;
ALTER SEQUENCE edu_id_seq OWNED BY Education.edu_id;
ALTER SEQUENCE profile_sites_id_seq OWNED BY Profile_sites.profile_sites_id;
ALTER SEQUENCE skill_id_seq OWNED BY Skill.skill_id;