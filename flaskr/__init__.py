from flask import Flask

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)

    from flaskr.view import index
    app.register_blueprint(index.bp)

    return app