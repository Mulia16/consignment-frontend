# Alpro Consignment Frontend

This repository contains the standalone frontend application for the **Alpro Consignment System**. It is built using Java Spring Boot (serving JSP pages), Bootstrap 4, and jQuery. 

The application is designed to communicate with a 5-domain microservice backend architecture via a central API Gateway. It supports two execution modes: **Slicing (Dev Mode)** using mocked data, and **API Integration (Stage/Prod Mode)**.

---

## 🏛️ Architecture

The frontend acts as a unified portal, directing requests to a central API Gateway (`localhost:8080`), which routes traffic to 5 core microservice domains:

1. **TRACE_LOG** (Audit Trails, Action Logs)
2. **MASTER_SETUP** (Products, Suppliers, Warehouses, System Configs)
3. **TRANSACTION** (Stock Management, Inbound PO/GR, Outbound SO/DO, Returns/Adjustments, POS Sales)
4. **SETTLEMENT** (Partner Commissions, Payment Records)
5. **REPORT** (Generated PDFs/Excel for Inventory & Financials)
*(Authentication is handled intrinsically via the Gateway's Auth service)*

---

## 🛠️ Technology Stack

- **Framework:** Java 17 + Spring Boot 3.2.5
- **Template Engine:** Jakarta Server Pages (JSP) + JSTL
- **Styling:** Bootstrap 4 + Custom CSS
- **Interactivity:** jQuery 3.5.x + Vanilla JS (Fetch API)
- **Containerization:** Docker + Docker Compose

---

## 📁 Directory Structure

```text
consigment-frontend/
├── .env.example              # Template for environment variables
├── docker-compose.yml        # Docker composition file
├── Dockerfile                # Multi-stage build instruction
├── pom.xml                   # Maven dependencies & build config
├── src/
│   ├── main/java/...         # Spring Boot runner & API Config Controller
│   ├── main/resources/       # application.yml
│   └── main/webapp/
│       ├── static/           
│       │   ├── css/          # Core styling (style.css, login.css)
│       │   └── js/           # API Core (api-config.js, api-client.js, auth.js)
│       └── WEB-INF/jsp/      # 20+ feature views (JSP)
```

---

## ⚙️ Configuration (`.env`)

The project uses `.env` files to manage environments (loaded via `spring-dotenv`). Ensure you copy `.env.example` to `.env` before running.

```dotenv
# App Mode: 'dev' for frontend Slicing/Mock Data Bypass, or 'prod' for real API
APP_MODE=dev

# Server Config
SERVER_PORT=8800
GATEWAY_BASE_URL=http://localhost:8080

# Service Bindings (Gateway Paths)
SERVICE_AUTH=/auth
SERVICE_TRACE_LOG=/api/trace-log
SERVICE_MASTER_SETUP=/api/master-setup
SERVICE_TRANSACTION=/api/transaction
SERVICE_SETTLEMENT=/api/settlement
SERVICE_REPORT=/api/report
```

### 💡 Dev Mode (Slicing Bypass)
When `APP_MODE=dev`, the frontend operates entirely independent of the backend microservices. 
- The Login screen is bypassed automatically.
- The `api-client.js` fetch wrapper intercepts all HTTP requests and responds with simulated JSON Mock Data.
- *Perfect for UI/UX slicing and frontend modifications without spinning up 16 different Spring Boot API services.*

---

## 🚀 How to Run

### Method 1: Docker (Recommended)
Ensure Docker Desktop is running on your machine.

```bash
# 1. Clone repository
# 2. Setup your .env file
cp .env.example .env

# 3. Build & Run the container in detached mode
docker-compose up -d --build

# 4. View logs (optional)
docker-compose logs -f
```

The application will be accessible at [http://localhost:8800](http://localhost:8800).

### Method 2: Maven (Local Development)
Requires JDK 17+ and Maven installed.

```bash
# Compile and run via Spring Boot Maven Plugin
mvn clean spring-boot:run
```

---

## 🔐 Authentication
When operating out of `dev` mode (e.g., `APP_MODE=prod`), the application relies on JWT-based authentication. The `api-client.js` script handles attaching the `Authorization` header and performing automatic seamless token-refreshes using the `/auth/refresh` endpoint upon 401 Unauthorized responses.

> **Default Admin Credentials (Stage/Prod):**  
> Username: `admin`  
> Password: `admin123`
