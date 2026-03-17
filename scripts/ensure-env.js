const fs = require("fs");
const path = require("path");

const root = process.cwd();
const envPath = path.join(root, ".env");
const envExamplePath = path.join(root, ".env.example");

if (fs.existsSync(envPath)) {
  console.log("[setup] .env already exists, leaving it unchanged.");
  process.exit(0);
}

if (!fs.existsSync(envExamplePath)) {
  console.error("[setup] Missing .env.example. Cannot create .env.");
  process.exit(1);
}

fs.copyFileSync(envExamplePath, envPath);
console.log("[setup] Created .env from .env.example.");
