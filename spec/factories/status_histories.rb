FactoryBot.define do
  factory :status_history do
    job_application { nil }
    previous_status { 1 }
    new_status { 1 }
    changed_at { "2026-05-02 22:11:01" }
    notes { "MyString" }
  end
end
