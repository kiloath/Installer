import xml.etree.ElementTree as ET
import json

tree = ET.parse('cppcheck-report.xml')
root = tree.getroot()

issues = []
for error in root.findall('errors/error'):
    message = error.get('msg')
    severity = error.get('severity')
    location = error.find('location')
    if location is not None:
        file = location.get('file')
        line = location.get('line')
        issues.append({
            "engineId": "cppcheck",
            "ruleId": "cppcheck-" + severity,
            "primaryLocation": {
                "message": message,
                "filePath": file,
                "textRange": {
                    "startLine": int(line),
                    "endLine": int(line)
                }
            },
            "type": "CODE_SMELL" if severity in ["style", "performance"] else "BUG",
            "severity": "CRITICAL" if severity == "error" else "MINOR"
        })

with open('sonar-cppcheck-report.json', 'w') as f:
    json.dump({"issues": issues}, f, indent=2)
