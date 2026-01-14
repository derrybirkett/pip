const fs = require('fs');
const path = require('path');

// Function to create file relative to repo root
function createFile(filePath, content) {
  const fullPath = path.join(process.cwd(), filePath);
  fs.mkdirSync(path.dirname(fullPath), { recursive: true });
  fs.writeFileSync(fullPath, content);
}

// Example usage
// createFile('docs/agent-monitoring.md', '# Monitoring Autonomous Agent');

console.log('Agent script executed successfully.');