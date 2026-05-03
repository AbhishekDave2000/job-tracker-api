FactoryBot.define do
  factory :job_application do
    user { nil }
    company_name { "MyString" }
    job_title { "MyString" }
    job_url { "MyString" }
    job_description { "MyText" }
    status { 1 }
    applied_date { "2026-05-02" }
    salary_min { 1 }
    salary_max { 1 }
    location { "MyString" }
    remote { false }
    notes { "MyText" }
  end
end
