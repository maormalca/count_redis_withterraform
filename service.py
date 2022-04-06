from flask import Flask
import redis

r = redis.Redis(
    host='redis',
    port='6379', 
    password='A123456a123456')

app = Flask(__name__)
r.set('hits', '0')
@app.route('/hits')
def hello():
    numof=r.get('hits')
    newnumof=int(numof)+1
    r.set('hits', str(newnumof))
    return 'hello'

@app.route('/query')
def query():
    return r.get('hits')

if __name__ == "__main__":
    app.run(debug=True,port=8081,host="0.0.0.0")
                                        
