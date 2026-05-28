# 🎯 Job Tracker API

A production-ready RESTful API built with **Ruby on Rails 8.1** to help job seekers
organize and manage their job applications from start to finish — track statuses,
manage contacts, and never miss a follow-up reminder again.

> 🔗 Frontend Repository: [job-tracker-frontend](https://github.com/AbhishekDave2000/job-tracker-frontend)

---

## ✨ Features

- 🔐 **JWT Authentication** — Secure register and login with token-based stateless auth
- 📋 **Job Applications** — Full CRUD with rich details including salary range, job description, and notes
- 📊 **Status Pipeline** — Track every stage from first look to final decision
- 🕐 **Status History** — Automatic audit trail every time an application status changes
- 👤 **Contacts** — Manage hiring managers and recruiters tied to each application
- ⏰ **Follow Up Reminders** — Set reminders with automatic pending, overdue, and completed tracking
- 🔒 **User Scoped Data** — Every user only ever sees their own data

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Ruby on Rails 8.1 (API mode) | Backend framework |
| PostgreSQL | Primary database |
| JWT (`jwt` gem) | Token-based authentication |
| BCrypt (`bcrypt` gem) | Password hashing via `has_secure_password` |
| Rack CORS | Cross-origin request handling |
| Active Model Serializers | JSON response serialization |

---

## 🚀 Getting Started

### Prerequisites

- Ruby 3.3+
- Rails 8.1+
- PostgreSQL 14+
- Bundler

### Installation

```bash
# Clone the repository
git clone https://github.com/abhishekdave/job-tracker-api.git
cd job-tracker-api

# Install dependencies
bundle install

# Setup environment variables
cp .env.example .env
# Fill in your values in .env

# Create and migrate the database
rails db:create
rails db:migrate

# Start the server
rails server
# API available at http://localhost:3000/api/v1
```

---

## ⚙️ Environment Variables

Create a `.env` file in the root directory:

```env
DB_USERNAME=your_postgres_username
DB_PASSWORD=your_postgres_password
DB_HOST=localhost
```

> ⚠️ Never commit your `.env` file. Use `.env.example` as a reference.

---

## 📡 API Endpoints

All endpoints are prefixed with `/api/v1`

> All protected routes require the header:
> `Authorization: Bearer <your_jwt_token>`

---

### 🔐 Authentication

| Method | Endpoint | Auth Required | Description |
|--------|----------|---------------|-------------|
| `POST` | `/auth/register` | ❌ | Register a new account |
| `POST` | `/auth/login` | ❌ | Login and receive JWT token |

#### Register
**Request Body:**
```json
{
  "first_name": "Abhishek",
  "last_name": "Dave",
  "email": "abhishek.dave.ca@gmail.com",
  "password": "securepassword"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Account created successfully",
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "first_name": "Abhishek",
    "last_name": "Dave",
    "email": "abhishek.dave.ca@gmail.com"
  }
}
```

#### Login
**Request Body:**
```json
{
  "email": "abhishek.dave.ca@gmail.com",
  "password": "securepassword"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "first_name": "Abhishek",
    "last_name": "Dave",
    "email": "abhishek.dave.ca@gmail.com"
  }
}
```

---

### 📋 Job Applications

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/job_applications` | List all applications for current user |
| `POST` | `/job_applications` | Create a new application |
| `GET` | `/job_applications/:id` | Get a single application |
| `PATCH` | `/job_applications/:id` | Update an application |
| `DELETE` | `/job_applications/:id` | Delete an application |
| `PATCH` | `/job_applications/:id/update_status` | Update status only |
| `GET` | `/job_applications/:id/status_histories` | Get status change history |

#### Application Statuses

| Value | Integer | Description |
|-------|---------|-------------|
| `bookmarked` | 0 | Saved for later |
| `applied` | 1 | Application submitted |
| `interview` | 2 | Interview scheduled |
| `offer` | 3 | Offer received |
| `rejected` | 4 | Application rejected |
| `withdrawn` | 5 | Withdrew application |

#### Create / Update Request Body
```json
{
  "application": {
    "company_name": "Basis Technologies",
    "job_title": "Senior Rails Developer",
    "job_url": "https://basis.com/careers/senior-rails-developer",
    "status": "applied",
    "location": "Toronto, ON",
    "remote": true,
    "applied_date": "2026-05-20",
    "salary_min": 110000,
    "salary_max": 140000,
    "job_description": "Core backend platform role working on Rails microservices...",
    "notes": "Referred by a colleague at Basis"
  }
}
```

#### Update Status Request Body
```json
{
  "status": "interview"
}
```

---

### 👤 Contacts

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/job_applications/:id/contacts` | List all contacts for an application |
| `POST` | `/job_applications/:id/contacts` | Add a new contact |
| `GET` | `/contacts/:id` | Get a single contact |
| `PATCH` | `/contacts/:id` | Update a contact |
| `DELETE` | `/contacts/:id` | Delete a contact |

#### Create / Update Request Body
```json
{
  "contact": {
    "name": "Sarah Mitchell",
    "email": "sarah.mitchell@basis.com",
    "phone_number": "+1 (416) 555-0192",
    "note": "Talent Acquisition — spoke at Toronto Dev Meetup"
  }
}
```

---

### ⏰ Follow Ups

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/job_applications/:id/follow_ups` | List all follow ups |
| `POST` | `/job_applications/:id/follow_ups` | Create a follow up |
| `GET` | `/follow_ups/:id` | Get a single follow up |
| `PATCH` | `/follow_ups/:id` | Update a follow up |
| `PATCH` | `/follow_ups/:id/complete` | Mark follow up as completed |
| `DELETE` | `/follow_ups/:id` | Delete a follow up |

#### Filter Follow Ups by Status
```
GET /job_applications/:id/follow_ups?status=pending
GET /job_applications/:id/follow_ups?status=overdue
GET /job_applications/:id/follow_ups?status=completed
GET /job_applications/:id/follow_ups?status=today
GET /job_applications/:id/follow_ups?status=upcoming
```

#### Create Request Body
```json
{
  "follow_up": {
    "message": "Send thank you email to Sarah after the interview",
    "remind_at": "2026-05-28T09:00:00"
  }
}
```

#### Follow Up Status Logic
```
completed = true                     → "completed"
completed = false, remind_at < now   → "overdue"
completed = false, remind_at >= now  → "pending"
```

---

## 🗄️ Database Schema

```
users
├── id, first_name, last_name
├── email (unique)
└── password_digest

job_applications (belongs_to user)
├── id, user_id
├── company_name, job_title, job_url
├── status (integer, enum)
├── location, remote (boolean)
├── applied_date, salary_min, salary_max
├── job_description, notes
└── created_at, updated_at

contacts (belongs_to job_application)
├── id, job_application_id
├── name, email (required)
├── phone_number, note
└── created_at, updated_at

follow_ups (belongs_to job_application)
├── id, job_application_id
├── message, remind_at (required)
├── completed (boolean, default: false)
├── completed_at
└── created_at, updated_at

status_histories (belongs_to job_application)
├── id, job_application_id
├── previous_status, new_status (integers)
├── notes, changed_at
└── created_at, updated_at
```

---

## 📁 Project Structure

```
job-tracker-api/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb        # JWT auth + ExceptionHandler
│   │   └── api/v1/
│   │       ├── authentication_controller.rb
│   │       ├── job_applications_controller.rb
│   │       ├── contacts_controller.rb
│   │       └── follow_ups_controller.rb
│   ├── models/
│   │   ├── user.rb
│   │   ├── job_application.rb               # Status enum + history tracking
│   │   ├── contact.rb
│   │   ├── follow_up.rb                     # Scopes: pending, overdue, completed
│   │   └── status_history.rb
│   ├── serializers/
│   │   ├── user_serializer.rb
│   │   ├── job_application_serializer.rb
│   │   ├── contact_serializer.rb
│   │   └── follow_up_serializer.rb          # Custom status computed field
│   └── services/
│       └── json_web_token.rb                # JWT encode/decode
├── config/
│   ├── routes.rb
│   └── initializers/
│       ├── cors.rb
│       └── active_model_serializers.rb
└── db/
    └── schema.rb
```

---

## 🧪 Running Tests

```bash
bundle exec rspec
```

---

## 👨‍💻 Author

**Abhishek Dave**
Full Stack Developer — Toronto, ON

[LinkedIn](https://www.linkedin.com/in/abhishek-dave-15b3711a4/)
[GitHub](https://github.com/AbhishekDave2000)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
