from robot.api.deco import library, keyword

import datetime
import gridfs
import pymongo


@library
class MongoDB:

    @keyword
    def upload_file(self, file_name, fs):
        try:
            data = None
            with open(file_name, 'rb') as file_data:
                data = file_data.read()
            fs.put(data, filename=file_name)
            print("upload_complete")
        except Exception as e:
            print(e)

    @keyword
    def mongo_conn(self, mongo_password):
        uri = "mongodb+srv://jraghulraj:" + mongo_password + "@raghul.5vjlmpl.mongodb.net/?retryWrites=true&w=majority"

        client = pymongo.MongoClient(uri)
        try:
            client.admin.command('ping')
            print("Pinged your deployment. You successfully connected to MongoDB!")
            return client['tests']
        except Exception as e:
            print(e)

    @keyword
    def create_conn_upload(self, mongo_password):
        try:
            db = self.mongo_conn(mongo_password)
            fs = gridfs.GridFS(db, collection="Report_" + str(datetime.datetime.now()))
            self.upload_file(file_name='log.html', fs=fs)
            self.upload_file(file_name='output.xml', fs=fs)
            self.upload_file(file_name='report.html', fs=fs)
        except Exception as e:
            print(e)
