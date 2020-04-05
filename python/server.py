from flask import Flask
from flask import jsonify
import recommendation
app = Flask(__name__)


@app.route('/<user_id>')
def hello_world(user_id):
    #import ipdb; ipdb.set_trace()
    sorted_index = recommendation.get_recommendation("football_news_development", int(user_id))
    return jsonify(sorted_index.tolist())
