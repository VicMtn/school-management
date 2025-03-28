# School Management System

A comprehensive Ruby on Rails application for managing school operations including students, teachers, classes, courses, examinations, and grading.

## Requirements

- ![Ruby](https://img.shields.io/badge/Ruby-3.2.0+-CC342D?style=flat-square&logo=ruby&logoColor=white)
- ![Rails](https://img.shields.io/badge/Rails-8.0.0+-CC0000?style=flat-square&logo=ruby-on-rails&logoColor=white)
- ![SQLite](https://img.shields.io/badge/SQLite-3-003B57?style=flat-square&logo=sqlite&logoColor=white)
- ![Node.js](https://img.shields.io/badge/Node.js-18+-339933?style=flat-square&logo=node.js&logoColor=white)
- ![npm](https://img.shields.io/badge/npm-9+-CB3837?style=flat-square&logo=npm&logoColor=white)

## Wiki
All informations are available in the [wiki](https://github.com/VicMtn/school-management/wiki) and well more described

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/school-management.git
cd school-management
```

2. Install dependencies
```bash
bundle install
```

3. Setup the database
```bash
bundle exec db:drop
bundle exec db:create
```

4. Run de migration
```bash
bundle exec rails db:migrate
```

5. Seed the database with initial data
```bash
bundle exec rails db:seed
```

## Running the Application

1. Start the Rails server with esbuild (handles both backend and frontend)
```bash
./bin/dev
```

2. Access the application at `http://localhost:3000`

## Database Structure

The application uses a relational database with the following key entities:
- Adresses
- Courses
- Examinations
- Grades
- Moments
- People (students, teachers with STI)
- Promotions_asserts
- Rooms
- School_classes
- Sector
- Statuses
- Students_classes
- Subjects
- Users (authentication)

For a visual representation of the database schema:
- [Mermaid Diagram](docs/database_mld.md)

## Development

### Generating Models

The application structure was built using scaffolds. If you need to recreate the database from scratch, the commands are documented in [docs/commands.md](docs/commands.md).

## Maintenance

### Backups

To backup the database:
```bash
bin/rails db:dump
```

### Software Updates

1. Update dependencies:
```bash
bundle update
```

2. Run migrations:
```bash
bin/rails db:migrate
```

## Architecture

This application follows standard Rails MVC architecture with:
- Single Table Inheritance (STI) for Person models
- Soft deletion pattern using `deleted_at` timestamps
- RESTful resource routing
- Tailwind CSS for styling

## License

This project is licensed under the MIT License - see the LICENSE file for details.

