insert into users(user_id, user_name, phone_number, user_email)
values (1, '테스트', '010-1111-2222', 'test01@naver.com');

insert into Account(account_id, user_id, pw_hash, last_login_dt)
values ('test01@naver.com', 1, '401357cf18542b4117ca59800657b64cce2a36d8ad4c56b6102a1e0b03049e97', now());

insert into Consent(consent_id, user_id, marketing_consent, terms_conditions_consent)
values (1, 1, true, true);

insert into Profile(profile_id, user_id, title, profile_job_opt)
values (1, 1, '테스트 데이터 입니다.', 1);

insert into Profile_Count(profile_count_id, profile_id)
values (1, 1);

insert into Company(company_id, profile_id, company_nm, company_position, current_state, start_date)
values (1, 1, 'test.corp', 'manager', 1, now());

insert into Education(edu_id, profile_id, institute, major, current_state, start_date)
values (1, 1, 'test_univ', 'computer-science', 1, now());

insert into Skill(skill_id, skill_name, category, second_category)
values(1, 'spring web', 'development', 'back-end');
insert into Skill(skill_id, skill_name, category, second_category)
values(2, 'spring cloud', 'development', 'back-end');

insert into Profile_Skill(profile_id, skill_id)
values (1, 1), (1, 2);
