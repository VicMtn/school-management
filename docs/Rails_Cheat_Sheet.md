# ROR - Cheat Sheet

## **Chaining Commands**
| Example | Description |
|----------|------------|
| `rails db:drop db:create db:migrate` | Drop, create and migrate the DB | 
| | |
| | |

## **1. Project Creation and Management**  
| Command | Description |
|----------|------------|
| `rails new project_name` | Creates a new Rails application |
| `cd project_name` | Enters the project directory |
| `rails server` (`rails s`) | Starts the local server (default on `localhost:3000`) |
| `rails console` (`rails c`) | Opens an interactive Rails console (irb) |
| `rails dbconsole` (`rails db`) | Opens a SQL console to interact with the database |

---

## **2. Component Generation (Models, Controllers, Migrations)**  
| Command | Description |
|----------|------------|
| `rails generate scaffold ModelName attribute:type` | Generates a model, controller, views and migrations |
| `rails generate model ModelName attribute:type` | Creates a model with its attributes |
| `rails generate controller ControllerName action1 action2` | Creates a controller with its actions |
| `rails generate migration MigrationName` | Creates an empty migration |
| `rails generate resource ModelName` | Generates a model, controller and RESTful routes |
| `rails destroy model ModelName` | Deletes a model |
| `rails destroy controller ControllerName` | Deletes a controller |
| `rails destroy migration MigrationName` | Deletes a migration |

---

## **3. Database Management**  
| Command | Description |
|----------|------------|
| `rails db:create` | Creates the database |
| `rails db:migrate` | Applies migrations to the database |
| `rails db:rollback` | Reverts the last migration |
| `rails db:reset` | Resets the database (drops and recreates) |
| `rails db:setup` | Creates, migrates and seeds the database |
| `rails db:seed` | Executes the `db/seeds.rb` file to populate the database |
| `rails db:migrate:status` | Shows migration status |
| `rails db:drop` | Drops the database |
| `rails db:prepare` | Prepares the database for test environment |

---

## **4. Routes and Controllers Management**  
| Command | Description |
|----------|------------|
| `rails routes` | Displays available routes |
| `rails middleware` | Displays the Rails middleware stack |

---

## **5. Models and ActiveRecord (ORM) Management**  
| Command | Description |
|----------|------------|
| `rails console` (`rails c`) | Opens Rails console to manipulate models |
| `Model.all` | Retrieves all records of a model |
| `Model.find(id)` | Finds a record by its ID |
| `Model.where(condition: "value")` | Filters results based on a condition |
| `Model.create(attributes)` | Creates and saves a new object to the database |
| `Model.update(id, attributes)` | Updates an existing record |
| `Model.destroy(id)` | Deletes a record |

---

## **6. Views and Assets Management**  
| Command | Description |
|----------|------------|
| `rails generate view filename` | Creates a view manually |
| `rails assets:precompile` | Compiles assets (CSS, JS, images) |

---

## **7. Authentication and Sessions**  
| Command | Description |
|----------|------------|
| `rails generate devise:install` | Installs Devise (if used for authentication) |
| `rails generate devise ModelName` | Generates a user model with Devise |

---

## **8. Debugging and Tools**  
| Command | Description |
|----------|------------|
| `rails logs` | Displays server logs |
| `rails runner "Ruby Command"` | Executes Ruby code directly in Rails |
| `rails middleware` | Displays the Rails middleware stack |
| `bundle pristine --all` | Reinstalls all gems by cleaning extensions |

---

## **9. Testing and Deployment**  
| Command | Description |
|----------|------------|
| `rails test` | Runs unit tests |
| `rails test:system` | Executes system tests |
| `rails assets:precompile` | Precompiles assets for deployment |

---

### **Gems and Bundler Management**
| Command | Description |
|----------|------------|
| `bundle install` | Installs gems from the `Gemfile` |
| `bundle update` | Updates gems |
| `gem uninstall gem_name` | Uninstalls a gem |
| `gem install gem_name` | Installs a gem |

---
