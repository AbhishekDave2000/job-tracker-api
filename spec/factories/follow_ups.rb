FactoryBot.define do
  factory :follow_up do
    job_application { nil }
    remind_at { "2026-05-02 22:11:24" }
    message { "MyString" }
    completed { false }
    completed_at { "2026-05-02 22:11:24" }
  end
end
