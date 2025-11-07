# Jenkins Pipeline Build Result (http://34.229.193.151:8080/job/assignment1/20/console)

## Build Overview
| Detail | Value |
|--------|-------|
| Started By | Sukanthi R |
| Repository | https://github.com/Sukanthi2000/Assignment_Sukanthi.git |
| Status | ✅ SUCCESS |

## Stage Execution Details

### 1. Source Code Checkout
```shell
Git Version: 2.50.1
Commit: 1cb59ecf9265dff8bfe1c61236c0b2cb86a9ce2d
Branch: main
```

### 2. Python Environment Setup
```shell
# Python dependencies installed:
flask==3.0.0
pytest==7.4.3
pytest-cov==4.1.0 
pytest-html==4.1.1
Werkzeug==3.0.1
```

### 3. Test Results
```python
Test Summary:
✓ Assignment_1/test_app.py::TestApp::test_sample
✓ Assignment_1/test_app.py::TestApp::test_string

Total: 2 passed in 0.02s
```

### 4. Docker Build
```dockerfile
# Build Steps:
[1/5] FROM python:3.11-slim
[2/5] WORKDIR /app
[3/5] COPY requirements.txt
[4/5] RUN pip install
[5/5] COPY . .

Status: Built successfully
Image: jenkins-python-demo
```

### 5. Container Deployment
```shell
# Container Operations:
✓ Stopped: python-container
✓ Removed: python-container
✓ Started: 50f2498e94c1
Port Mapping: 5000:5000
```

## Environment Details
- **Python**: 3.9.24
- **OS**: Linux 6.1.156-177.286
- **Jenkins URL**: http://34.229.193.151:8080/
- **Workspace**: /var/lib/jenkins/workspace/assignment1

## Final Status
> ✅ Python App built and deployed successfully!

---
*Generated: Jenkins Pipeline Build #20*