# Jenkins CI/CD Pipeline with Python and Docker

This project demonstrates a CI/CD pipeline using Jenkins to build, test, and deploy a Python application using Docker.

## Pipeline Overview

The pipeline performs the following steps:
1. Clones the repository
2. Builds the Python application
3. Runs unit tests
4. Creates a Docker image
5. Deploys the containerized application

## Prerequisites

- Jenkins server with following plugins:
  - Git plugin
  - Docker Pipeline plugin
  - Python plugin
- Docker installed on Jenkins server
- Python 3.x
- Git

## Project Structure

```
Assignment_1/
├── Jenkinsfile        # Jenkins pipeline configuration
├── requirements.txt   # Python dependencies
├── app.py            # Main application file
├──test_app.py   # Unit tests
└── Dockerfile        # Docker configuration
```

## Setup Instructions

1. **Jenkins Configuration**
   - Install required Jenkins plugins
   - Configure Docker in Jenkins
   - Add GitHub credentials if repository is private

2. **Create Jenkins Pipeline**
   - Create new Pipeline job
   - Configure pipeline to use SCM
   - Point to Jenkinsfile in repository

3. **Environment Variables**
   ```groovy
   IMAGE_NAME = "jenkins-python-demo"
   CONTAINER_NAME = "python-container"
   ```

## Running the Pipeline

1. Access Jenkins dashboard
2. Select the pipeline project
3. Click "Build Now"

## Port Configuration

The application runs on port 5000:
- Container port: 5000
- Host port: 5000

## Test Results

Tests are executed using pytest and results are displayed in Jenkins:
- Test reports are generated in JUnit format
- Coverage reports are available after successful test execution

## Docker Commands

To manually manage the container:
```bash
# Stop container
docker stop python-container

# Remove container
docker rm python-container

# Run container
docker run -d --name python-container -p 5000:5000 jenkins-python-demo
```

## Troubleshooting

Common issues and solutions:
1. **Python not found**: Ensure Python 3.x is installed on Jenkins server
2. **Docker permission issues**: Add Jenkins user to docker group
3. **Port conflicts**: Check if port 5000 is already in use

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.