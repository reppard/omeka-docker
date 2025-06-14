# Omeka S Docker Setup

This project provides a Dockerized environment for running [Omeka S](https://omeka.org/s/) with a MySQL backend. It uses Docker Compose to orchestrate the application and database containers.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (v20+ recommended)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2+ recommended)

## Configuration

1. **Clone the repository**
   ```sh
   git clone https://github.com/reppard/omeka-docker.git
   cd omeka-docker
   ```

2. **Set up environment variables**
   Create a `.env` file in the project root with the following content:
   ```
   DB_USER=root
   DB_NAME=omeka
   DB_PASSWORD=yourpassword
   MYSQL_USERNAME=root
   MYSQL_DATABASE=omeka
   MYSQL_ROOT_PASSWORD=yourpassword
   ```
   Replace `yourpassword` with a secure password.

3. **Configure Omeka S database connection**
   Edit or create `./config/database.ini` with:

   ```bash
   mkdir -p ./config

   vim ./config/database.ini
   ```

   ```
   # ./config/database.ini

   username = root
   password = yourpassword
   dbname   = omeka
   host     = db
   ```

## Starting the Project

From the project root, run:
```sh
docker-compose up --build -d
```
- Omeka S will be available at [http://localhost:9543](http://localhost:9543)
- MySQL will be available on port `12832` (for advanced users)

## File Structure

- `Dockerfile` – Docker build instructions for Omeka S
- `config/database.ini` – Database connection settings
- `files/` – Uploaded files (persistent)
- `mysql/` – MySQL data (persistent)
- `docker-compose.yml` – Service orchestration

## Stopping and Cleaning Up

To stop the containers:
```sh
docker-compose down
```
To remove all data (including uploads and database):
```sh
docker-compose down -v
```

## Notes

- The first build may take several minutes.
- Uploaded files and database data are persisted in `./files/` and `./mysql/`.
- For Omeka S configuration, visit the web interface after startup.
