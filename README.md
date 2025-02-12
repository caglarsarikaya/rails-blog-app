# Blog Platform: Ruby on Rails Practices

## General Information
- **Backend:** Ruby on Rails (API Mode)  
  *API Mode was chosen to leverage Rails' natural RESTful structure. Compared to traditional MVC, API Mode allows the frontend to function independently.*
- **Frontend:**
  - Traditional Rails ERB templates for core blog functionalities  
    *Using server-side rendering for simple pages to avoid unnecessary API calls and gain SEO advantages.*
  - Vue (SPA) for dynamic components and the comment system   
     *Vue is chosen for its ease of integration with Rails, simpler state management, and lower learning curve compared to React, making it ideal for a hybrid Rails application.*
- **Database:** PostgreSQL  
  *The most preferred, scalable, and secure database in the Rails community.*
- **Deployment:** Fully Dockerized  
  *Docker Compose will be used to ensure environment-independent development.*

## Features
### 1. Authentication
- **Devise** for user authentication  
  *A widely used, secure, and customizable authentication system for Rails projects.*
- **Doorkeeper** for OAuth2 support (required for API)  
  *Necessary for API-based authentication in SPA (React/Vue) or mobile applications.*
- **OAuth2 access token instead of JWT**  
  *OAuth2 is preferred because JWT can introduce security vulnerabilities, and session management is better optimized in Rails.*

### 2. Authorization (RBAC - Role-Based Access Control)
- **Policy-based authorization with Pundit**  
  *Pundit is preferred because it allows defining policies per model and avoids the excessive abstraction of CanCanCan.*
- **Access control based on user roles**  
  *(Admin, Author, Reader, etc.) Pundit ensures a flexible and easily manageable RBAC system.*

### 3. Object-Oriented Design (OOD)
Following best practices in Rails, the business logic will be structured as:
- **Service Objects:** To separate business logic from controllers and improve modularity.
- **Form Objects (ActiveModel::Model):** For handling complex form processing across multiple models.
- **Concerns:** To modularize repetitive code.
- **Background Jobs (ActiveJob + Sidekiq):** For scheduled tasks and background processing.

### 4. Database Management
- **Rails' Active Record ORM will be used**  
  *Active Record is more efficient and better integrated with the Rails ecosystem compared to the Repository Pattern.*
- **Repository Pattern is not used**  
  *Rails' ORM naturally includes the abstractions provided by the Repository Pattern, making additional abstraction unnecessary.*

### 5. Queue Processing (Background Jobs & Messaging)
- **Sidekiq is preferred over RabbitMQ**  
  *Sidekiq, being Redis-based, is faster and better integrated into the Rails ecosystem.*
- **Email Notifications When a New Blog is Published**
  - When a user creates a new blog post, a **Sidekiq Job** will be triggered.
  - **ActionMailer will be used for email delivery**  
    *As it is Rails' built-in email delivery library.*

### 6. Fetching Weather Data
- **Sidekiq + Scheduler** will fetch weather data from an API every 15 minutes.
- **This data will be cached using Redis**  
  *To ensure fast access to relatively static data.*

### 7. Caching
- **Fragment caching** (for performance optimization at the view level)  
  *To improve the loading speed of static content.*
- **Rails.cache (Redis-based cache management) for frequently accessed data**  
  *To speed up API responses and reduce database load.*

### 8. Testing and CI/CD
- **RSpec & FactoryBot for unit and integration testing**  
  *Popular frameworks for comprehensive testing.*
- **Capybara for integration tests**  
  *To test user interactions.*
- **CI/CD: GitHub Actions for automated testing and deployment**  
  *To manage automated testing and deployment workflows.*

## Development Phases
1. **Authentication and Authorization**
   - Implement authentication using Devise.
   - Apply role-based authorization with Pundit.
2. **CRUD Operations**
   - Complete CRUD operations for users, blogs, and comments.
3. **User Interactions**
   - Implement blog publishing, commenting, and like functionalities.
4. **Follow System**
   - Users should be able to follow each other.
   - When a followed user publishes a new post, an email notification will be sent via Sidekiq.
5. **Performance Optimization**
   - Apply caching using Redis.
6. **Dockerization and Deployment**
   - Fully Dockerize all services and manage with Compose.
7. **Testing and Documentation**
   - Complete testing and set up CI/CD workflows.

