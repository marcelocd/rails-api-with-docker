# Rails API with Docker

Rails API with Docker is a streamlined template designed to kickstart your API development process using Ruby on Rails 7.1 and Ruby 3.2.2 in conjunction with essential tools like Devise, Devise-JWT, JSONAPI::Serializer, Docker, Docker Compose, PostgreSQL, Redis and Sidekiq. By utilizing this template, you can swiftly set up a robust Rails API environment without the hassle of manual configurations.

## Prerequisites

Before you start, make sure you have the following prerequisites installed:

- Docker
- Docker Compose

## Getting Started

To begin using Rails API with Docker, follow these simple steps:

1. Clone the repository:

```bash
git clone https://github.com/marcelocd/rails-api-with-docker.git
```

2. Navigate to the repository directory:

```bash
cd rails-api-with-docker
```

3. Build and start the Docker containers:

```bash
docker-compose up --build
```

## Usage

### Sign Up

Create a new user by sending a **POST** request to **`http://localhost:4000/signup`** with the following JSON payload:

```json
{
  "user": {
    "username": "marcelo",
    "email": "marcelo@gmail.com",
    "password": "password123",
  }
}
```

### Login

Authenticate by sending a **POST** request to **`http://localhost:4000/login`** with the following JSON payload:

```json
{
  "user": {
    "email": "marcelo@gmail.com",
    "password": "password123",
  }
}
```

or _(if you want to login with the username)_

```json
{
  "user": {
    "email": "marcelo",
    "password": "password123",
  }
}
```

### Logout

Log out by sending a **DELETE** request to **`http://localhost:4000/logout`** with the user's authentication token.

The authentication token can be found in the "authorization" header received as a response from sucessfull signup or login requests

## Running Specs

To run specs, use the following commands:
```bash
docker-compose exec backend /bin/bash
bundle exec rspec -fd
```

## Included Tools and Technologies

- **Ruby on Rails 7.1**: Leverage the latest features and improvements in Rails for your API projects.

- **Docker and Docker Compose**: Containerize your application and its dependencies for a consistent and reproducible development environment.

- **PostgreSQL**: A powerful, open-source relational database management system.

- **Redis**: A fast, in-memory data structure store commonly used as a cache or message broker.

- **Sidekiq**: A simple and efficient background processing framework for Ruby.

- **Devise and Devise-JWT**: Implement authentication for your API.

- **JSONAPI::Serializer**: Serialize your API responses following the JSON API specification.

- **RSpec with Shoulda-Matchers**: Conduct thorough and readable testing with RSpec's behavior-driven development framework.

- **FactoryBot**: Simplify the creation of test data by defining factories for your models.

- **Faker**: Generate realistic and randomized data for testing and development.

## Contributing

If you'd like to contribute to Rails API with Docker, please follow these steps:

1. Fork the repository.

2. Create a new branch for your feature or bug fix:

```bash
git checkout -b feature/your_feature_name
```

3. Make your changes and commit them:

```bash
git commit -m "Add your commit message here"
```

4. Push to your branch:

```bash
git push origin feature/your_feature_name
```

5. Create a pull request on GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE.md](backend/LICENSE.md) file for details.
