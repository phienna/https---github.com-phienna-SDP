# Software Development Processes (SDP)

Project for FHTW course Software Development Processes.
The task is to develop a flask webserver to read out CPU information on a raspberry pi zero.
It shall use a docker with python:3.9-alpine

## GitHub Requirements

* Public repository
* Use a project Kanban board to track your user stories
  * Steps: Todo, In Progress, Done
* Use gitflow
  * <https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow>
* Protect your master and develop branch
  * <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pullrequests/managing-a-branch-protection-rule>
* Use GitHub Actions feature branch
  * Build docker test stage
* develop
  * Build docker test stage
  * Build and push dev image to DockerHub (only on push)
* main/master
  * Build docker test stage
  * Build and push prod image to DockerHub (only on push)

### GitHub Actions Help

* <https://docs.docker.com/ci-cd/github-actions/>
* <https://github.com/marketplace/actions/build-and-push-docker-images>

## Application Requirements

* Flask application
* Clean application layout
  * <https://flask.palletsprojects.com/en/2.2.x/tutorial/layout/>
  * <https://flask.palletsprojects.com/en/2.2.x/tutorial/factory/>
  * <https://flask.palletsprojects.com/en/2.2.x/tutorial/views/>
* Separate requirements for each environment (test, dev and prod)
<https://riptutorial.com/django/example/8561/using-multiple-requirements-files>
* Sensor endpoints
  * /cpu/temp: Current CPU temperature in Celsius
  * /cpu/temp/error: Return "too hot" if the temperature is over 60 degree Celsius, else return "fine"
  * /disk/usage: Current disk usage in percent
* Write unit and integration tests
  * <https://docs.pytest.org/en/latest/>
  * <https://flask.palletsprojects.com/en/2.2.x/testing/>
  * Unit tests are marked as such
  * Integration test are marked as such
    * <https://docs.pytest.org/en/7.1.x/example/markers.html>
    * <https://docs.pytest.org/en/7.1.x/how-to/mark.html>
* Mock external libraries for testing
  * <https://changhsinlee.com/pytest-mock/>
  * <https://nedbatchelder.com/blog/201908/why_your_mock_doesnt_work.html>
* At least 80% coverage
  * <https://coverage.readthedocs.io/en/6.4.2/>

### Endpoint Help

* <https://gpiozero.readthedocs.io/en/stable/>
* <https://pypi.org/project/RPi.GPIO/>

### Mocking Help

```bash
def test_temp(mocker): 
    mock_cpu = mocker.patch('application.cpu.CPUTemperature')
    mock_cpu.return_value.temperature = 40.0
    # assert ...
```

## Docker Requirements

* Use arm32v6/python:3.9-alpine as image
* 4 Dockerfile targets
  * base
  includes everything that all targets need 
  * test
    * run linter (<https://flake8.pycqa.org/en/latest/>)
    * run tests (first unit tests, then integration tests)
      * `coverage run -m pytest [...]`
    * check coverage
      * `coverage report [...]`
    * fails if test coverage is below 80%
  * development
    * will start Flask server in debug mode
    * `flask --debug run --host=0.0.0.0`
  * production
    * will start Flask server without debug mode

### Dockerfile RPi.GPIO Help

Add this to your Dockerfile for the RPi.GPIO python library

```docker
# gcc needed for python RPi.GPIO library
RUN apk update
RUN apk add python3-dev \ 
            gcc \ 
            libc-dev \
            libffi-dev
```

### Dockerfile Help

* <https://www.freecodecamp.org/news/how-to-dockerize-a-flask-app/>
* <https://docs.docker.com/language/java/run-tests/>
* <https://docs.docker.com/language/java/configure-ci-cd/>

## Documentation Requirements

* PDF file
* Team member names
* Screenshots of the processes with descriptions
* Time Tracking
  * how long did every process take to complete
* Link to GitHub repository
* Contents
  * User stories
  * Kanban Board
  * One feature branch lifecycle
    * associated user story (don't forget to move it in the Kanban board)
    * creation
    * development (good commit messages)
    * testing
    * GitHub action
    * pull request
    * merging
    * deletion
  * develop branch dev image creation
  * master branch prod image creation
  * Docker image on Raspberry Pi
  * Working sensor endpoints
