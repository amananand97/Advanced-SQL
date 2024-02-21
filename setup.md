# Initial Setup for Running SQL Server on Apple Silicon Mac

## Requirements (arm 64 app)

Azure Data Studio
Docker Desktop

## Steps

1. **Setup Docker Desktop**:
   - Download and install Docker Desktop for Apple silicon.
   - Login to Docker Desktop.

2. **Configure Docker Desktop**:
   - Go to Docker Desktop settings.
   - Navigate to "General".
   - Select "Use Rosetta for x86/amd64 emulation on Apple Silicon".

3. **Download SQL Server Image**:
   - Go to Docker Hub.
   - Search for the official Microsoft Docker image for "Azure SQL Edge".
   - Copy the Docker pull command.

4. **Pull Docker Image**:
   - Open Terminal.
   - Paste the Docker pull command to download the SQL Server image.

     ```sh
     docker pull mcr.microsoft.com/azure-sql-edge
     ```

5. **Start Docker Container**:
   - Run the following command to start the Docker container with SQL Server:

     ```sh
     docker run -e "ACCEPT_EULA=1" -e "MSSQL_SA_PASSWORD=StrongPassword" -e "MSSQL_PID=Developer" -e "MSSQL_USER=SA" -p 1433:1433 -d --name=sql mcr.microsoft.com/azure-sql-edge
     ```

     - Replace `StrongPassword` with a strong password.

   - **Breaking Down the Command**:
     - `docker run`: To run the Docker container.
     - `-e "ACCEPT_EULA=1"`: Authentication.
     - `-e "MSSQL_SA_PASSWORD=StrongPassword"`: Setting the server password (Make sure to use a strong password, otherwise the Docker will stop immediately).
     - `-e "MSSQL_USER=SA"`: Name of the user.
     - `--name=sql mcr.microsoft.com/azure-sql-edge`: The container will be running with this name.

6. **Check Docker Container**:
   - Use `docker ps` to check if the Docker container is running.

7. **Open Azure Data Studio**:
   - Set up a new connection in Azure Data Studio.
   - Click on "New Connection".
   - Fill out the connection details:
     - Connection Type: Microsoft SQL Server
     - Server: localhost
     - Username: SA or the username you set up
     - Password: The password you set up
     - Click "Remember Password" if desired.
   - Click "Connect".
