import pyodbc
from flask import Flask, jsonify, request
from flask_cors import CORS
app=Flask(__name__)
CORS(app)
import ssl
import random
import string
 
try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    # Legacy Python that doesn't verify HTTPS certificates by default
    pass
else:
    # Handle target environment that doesn't support HTTPS verification
    ssl._create_default_https_context = _create_unverified_https_context

def connection():
    server = '172.17.0.2,1433'
    database = 'TestDB' 
    username = 'SA' 
    password = 'ENTER_YOUR_PASSWORD_HERE'
    Driver = 'DRIVER={/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.10.so.1.1};SERVER='+server+';DATABASE='+database+';ENCRYPT=no;UID='+username+';PWD='+ password
    cnxn = pyodbc.connect('DRIVER={/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.10.so.1.1};SERVER='+server+';DATABASE='+database+';ENCRYPT=no;UID='+username+';PWD='+ password)
    cursor = cnxn.cursor()
    return cnxn

@app.route("/",methods=['GET','POST'])
def index():
    if request.method=='GET':
     cnxn = connection()
     cursor = cnxn.cursor()
#getting the url argument
     items = []
     Viewcount = 1
     cursor.execute('SELECT * FROM dbo.INVENTORY')
     for row in cursor.fetchall():
         Viewcount = Viewcount + 1
         print('row = %r' %(row,))
         items.append({"viewcount": row[0]})

     cursor = cnxn.cursor()
     insert_stmt = (
       "USE TestDB;"
       "INSERT INTO dbo.INVENTORY (viewcount) "
       "VALUES (?)"
     )
     data = (Viewcount)
     cursor.execute(insert_stmt, data)
     cnxn.commit()
     cnxn.close()
     return items
    else:
        return jsonify({'Error':"This is a GET API method"})
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=80)
