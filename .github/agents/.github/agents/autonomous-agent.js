const fs = require('fs');
const path = require('path');

// Function to create a file relative to the repo root
function createFile(filePath, content) {
  const fullPath = path.join(process.cwd(), filePath);
  fs.mkdirSync(path.dirname(fullPath), { recursive: true });
  fs.writeFileSync(fullPath, content);
}

// Example usage
createFile('docs/agent-monitoring.md', '# Agent Monitoring\nThis document describes the monitoring capabilities of the autonomous agent.');

console.log('File created successfully.');